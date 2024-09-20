#!/usr/bin/env python3
"""
OpenStack mapping generator performs:
 * reads GSI (global static identity) mapping file (environment/<>/openstack/global-static-identity-mappings/<>-gsi-mapping.yaml)
 * reads all project-quotas-acls manifests and scans user-role-mappings section (environment/<>/openstack/projects-quotas-acls/<domain>/<>.yaml)
 * generates complete mapping with GSI name by merging mappings from above sources
   * project manifest files user-role-mappings section is transformed into OpenStack mapping segment

Usage examples:
 * generate OpenStack mapping "login_e_infra_cz_mapping" from
   * global static identity (GSI) mapping (environments/prod-ostrava/openstack/global-static-identity-mappings/login_e_infra_cz_mapping-gsi-mapping.yaml)
   * project static identity (PSI) mapping (environments/prod-ostrava/openstack/projects-quotas-acls/**/*.yaml)
   to JSON ostack mapping rules file (just rules subsection)
   ci/src/ostack-mapping-generate.py
     --input-gsi-mapping-file environments/prod-ostrava/openstack/global-static-identity-mappings/login_e_infra_cz_mapping-gsi-mapping.yaml
     --input-psi-mapping-dir environments/prod-ostrava/openstack/projects-quotas-acls
     --output-ostack-identity-mapping-file environments/prod-ostrava/openstack/global-static-identity-mappings/login_e_infra_cz_mapping-mapping-rules.json
"""
import argparse
import glob
import json
import os
import os.path
import sys

import yaml

# local functions
# ---------------------------------------------------------------------------
def get_gsi_mapping(input_gsi_file):
    """ get GSI mapping ID/name """
    return yaml.load(input_gsi_file, Loader=yaml.SafeLoader)

def get_project_manifests_per_gsi_mapping(gsi_mapping_id, psi_mapping_dir, psi_mapping_glob):
    """ get project manifests per specific GSI mapping ID """
    project_manifest_files = glob.glob(os.path.join(psi_mapping_dir, psi_mapping_glob), recursive=True)
    gsi_mapping_contributing_manifest_files = []
    for i_project_manifest_file in project_manifest_files:
        with open(i_project_manifest_file) as fh:
            i_project_manifest_data = yaml.load(fh, Loader=yaml.SafeLoader)
            if 'user-role-mappings' in i_project_manifest_data and i_project_manifest_data['user-role-mappings']:
                for i_user_role_mapping in i_project_manifest_data['user-role-mappings']:
                    if 'mapping-id' in i_user_role_mapping and i_user_role_mapping['mapping-id'] == gsi_mapping_id:
                        gsi_mapping_contributing_manifest_files.append(i_project_manifest_file)
    return gsi_mapping_contributing_manifest_files


def psi_ostack_mapping(project_name, project_roles, remote_type, remote_condition, remote_identities):
    """ OpenStack mapping data item constructor from project-quota-acls object """
    mapping = { "local": [
                  { "projects": [
                     {  "name": project_name,
                        "roles": [{"name": i_role} for i_role in project_roles]
                     }          ]
                  }      ],
                "remote": [
                  { "type": remote_type,
                    remote_condition: remote_identities
                  }       ]
              }

    return mapping

def generate_ostack_manifest_mappings(gsi_mapping_id, project_manifest_files):
    """ generate ostack mapping entry """
    project_manifest_mappings = []

    for i_project_manifest_file in project_manifest_files:
        with open(i_project_manifest_file) as fh:
            # read-in project manifest file
            i_project_manifest_data = yaml.load(fh, Loader=yaml.SafeLoader)
            if i_project_manifest_data.get('user-role-mappings', None):
                # project manifest file come with non-empty user-role-mappings
                for i_urm_mapping in i_project_manifest_data['user-role-mappings']:
                    # skip on mappings not relevant to this GSI mapping
                    if i_urm_mapping.get("mapping-id", None) != gsi_mapping_id:
                        continue
                    # browse all specified user-role-mappings
                    i_urm_mapping_remote_entities = i_urm_mapping['remote-entities']

                    assert isinstance(i_urm_mapping_remote_entities, (list, tuple)), \
                        "Invalid Project .user-role-mappings.[i].remote-entities entity (expecting sequence, got %s)" % i_urm_mapping_remote_entities

                    i_remote_identities = list(i_urm_mapping_remote_entities)
                    if i_remote_identities:
                        # add ostack mapping if we found identities
                        i_mapping = psi_ostack_mapping(i_project_manifest_data['name'],
                                                       i_urm_mapping['local-roles'],
                                                       i_urm_mapping['remote-type'],
                                                       i_urm_mapping['remote-condition'],
                                                       i_remote_identities)
                        project_manifest_mappings.append(i_mapping)

    return project_manifest_mappings


def merge_ostack_mappings(gsi_mapping_data, psi_mapping_data_rules):
    """ merge GSI and PSI mappings """
    # TODO: remove duplicities
    return gsi_mapping_data["rules"] + psi_mapping_data_rules


def main(args):
    """ main loop """

    # load GSI mapping
    gsi_mapping_data = get_gsi_mapping(args.input_gsi_mapping_file)

    # find manifest files, reduce them for above detected GSI mapping ID
    ostack_project_manifest_files = get_project_manifests_per_gsi_mapping(gsi_mapping_data['id'],
                                                                          args.input_psi_mapping_dir,
                                                                          args.input_psi_mapping_file_glob)

    # generate ostack mappings out of the manifest files, as list of dicts
    psi_mapping_data_rules = generate_ostack_manifest_mappings(gsi_mapping_data['id'],
                                                               ostack_project_manifest_files)

    # merge ostack domain identity mappings
    ostack_mapping_data_rules = merge_ostack_mappings(gsi_mapping_data, psi_mapping_data_rules)

    # export ostack domain identity mappings
    json.dump(ostack_mapping_data_rules, args.output_ostack_identity_mapping_file, indent=2)


# main() call (argument parsing)
# ---------------------------------------------------------------------------
if __name__ == "__main__":
    AP = argparse.ArgumentParser(epilog=globals().get('__doc__'),
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    AP.add_argument('--input-gsi-mapping-file', type=argparse.FileType('r'), required=True,
                    help='OpenStack global static identity (GSI) mapping file as yaml (normally under environments/<>/openstack/global-static-identity-mappings/*-gsi-mapping.yaml)')
    AP.add_argument('--input-psi-mapping-dir', type=str, required=True, default=None,
                    help='Input project manifests with PSI mapping including dir (default: %(default)s)')
    AP.add_argument('--input-psi-mapping-file-glob', type=str, required=False, default="**/*.yaml",
                    help='Input project manifests file glob (default: %(default)s)')
    AP.add_argument('--output-ostack-identity-mapping-file', type=argparse.FileType('w'),
                    required=True, help='Output OpenStack mapping json file')

    ARGS = AP.parse_args()
    sys.exit(main(ARGS))
