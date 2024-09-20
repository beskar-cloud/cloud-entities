#!/usr/bin/env python3
"""
Yaml to terraform code translator

Usage examples:
 - ci/src/input-to-terraform-generate.py --input-manifest-dir environments/dev_proman --input-terraform-skeleton-dir ci/terraform --output-dir terraform-workdir

"""
import argparse
import glob
import sys
import os.path
import shutil
import pathlib
import pprint
import json
from datetime import datetime

import yaml
import jinja2

# local functions
# ---------------------------------------------------------------------------
def generate_terraform_common_files(output_dir, input_skeleton_dir, environment_name, project_root_dir):
    """ generate base common terraform files (workdir + 1:1 files + jinja templates) """

    # create output directory is not up
    os.makedirs(output_dir, exist_ok=True)

    # copy terraform skeleton files
    for i_file in glob.glob(os.path.join(input_skeleton_dir, "files", "*.tf")):
        shutil.copy(i_file, output_dir)

    # template terraform skeleton files
    i_template_data = {'environment_name' : environment_name,
                       'project_root_dir' : project_root_dir}
    for i_template_filename in ("main.tf.j2", "variables.tf.j2",):
        for i_file in glob.glob(os.path.join(input_skeleton_dir, "templates", i_template_filename)):
            i_file_basename = os.path.basename(i_file)
            i_file_template = None
            with open(i_file, 'r') as fh:
                i_file_template = jinja2.Template(fh.read())
            with open(os.path.join(output_dir, i_file_basename.replace('.j2', '')), 'w') as fh:
                fh.write(i_file_template.render(i_template_data))

def get_target_terraform_filename(object_type, manifest_data, suffix=".tf"):
    """ generate output/target terraform filename """
    if 'name' in manifest_data:
        return '%s-%s%s' % (manifest_data["name"], object_type, suffix)
    elif 'name' in manifest_data.get("project", {}) and 'domain' in manifest_data.get("project", {}):
        return '%s_%s-%s%s' % (manifest_data["project"]["domain"], manifest_data["project"]["name"], object_type, suffix)
    else:
        return 'unnamed%s' % suffix

def generate_terraform_objects(object_type, object_basedir, manifest_files, output_dir, input_skeleton_dir):
    """ generate object terraform code from yaml manifests """
    tf_template = None
    with open(os.path.join(input_skeleton_dir, "templates", "%s.tf.j2" % object_type), 'r') as fh:
        tf_template = jinja2.Template(fh.read())
    tf_template.globals['current_date'] = datetime.now().date()
        
    for i_manifest_file in manifest_files:
        i_manifest_file_data = None
        i_manifest_relative_path = os.path.relpath(os.path.dirname(i_manifest_file), object_basedir)
        with open(i_manifest_file, 'r') as i_fh:
            i_manifest_file_data = yaml.load(i_fh, Loader=yaml.SafeLoader)
        os.makedirs(os.path.join(output_dir, i_manifest_relative_path), exist_ok=True)
        i_manifest_name = i_manifest_file_data['name'] if 'name' in i_manifest_file_data else i_manifest_file_data['project']['name']
        with open(os.path.join(output_dir, i_manifest_relative_path,
                               get_target_terraform_filename(object_type, i_manifest_file_data, '.templating-data')), 'w') as i_fh:
            i_fh.write(pprint.pformat(i_manifest_file_data, indent=2, width=-1))
        with open(os.path.join(output_dir, i_manifest_relative_path,
                               get_target_terraform_filename(object_type, i_manifest_file_data)), 'w') as i_fh:
            i_fh.write(tf_template.render(i_manifest_file_data))

def generate_terraform_identity_mappings(manifest_files, output_dir, input_skeleton_dir, environment_name):
    """ generate object terraform code from yaml manifests """
    tf_template = None
    with open(os.path.join(input_skeleton_dir, "templates", "global-static-identity-mapping.tf.j2"), 'r') as fh:
        tf_template = jinja2.Template(fh.read())

    for i_manifest_file in manifest_files:
        i_mapping_name = pathlib.Path(i_manifest_file).stem
        if i_mapping_name.endswith('-mapping-rules'):
            i_mapping_name = i_mapping_name.removesuffix('-mapping-rules')
        i_template_data = {'rules-file'      : os.path.realpath(i_manifest_file),
                           'environment_name': environment_name,
                           'name'            : i_mapping_name}
        with open(os.path.join(output_dir, '%s-global-static-identity-mapping.json-templating-data' % i_template_data['name']), 'w') as i_fh:
            json.dump({"__mapping-data__": i_template_data}, i_fh, indent=2)
        with open(os.path.join(output_dir, '%s-global-static-identity-mapping.tf' % i_template_data['name']), 'w') as i_fh:
            i_fh.write(tf_template.render(i_template_data))


def main(args):
    """ main loop """
    generate_terraform_common_files(args.output_dir, args.input_terraform_skeleton_dir,
                                    args.environment_name, args.project_root_dir)
    object_type_to_directory = {'project-quota-acl': 'projects-quotas-acls'}
    # generate standard ostack resources
    for i_object_type, i_object_dir in object_type_to_directory.items():
        i_object_basedir = os.path.join(args.input_manifest_dir, i_object_dir)
        i_manifest_files = list(pathlib.Path(i_object_basedir).glob('**/*.yaml'))
        generate_terraform_objects(i_object_type, i_object_basedir, i_manifest_files,
                                   os.path.join(args.output_dir, i_object_dir), args.input_terraform_skeleton_dir)

    # identity mappings are done different way so far
    identity_mapping_manifest_rules_files = list(pathlib.Path(os.path.join(args.input_manifest_dir,
                                                                           'global-static-identity-mappings')).glob('*-mapping-rules.json'))
    generate_terraform_identity_mappings(identity_mapping_manifest_rules_files,
                                         args.output_dir,
                                         args.input_terraform_skeleton_dir,
                                         args.environment_name)


# main() call (argument parsing)
# ---------------------------------------------------------------------------
if __name__ == "__main__":
    AP = argparse.ArgumentParser(epilog=globals().get('__doc__'),
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    AP.add_argument('-O', '--output-dir', type=str, default='terraform-workdir')
    AP.add_argument('-I', '--input-manifest-dir', type=str, required=True)
    AP.add_argument('--input-terraform-skeleton-dir', type=str, default='ci/terraform')
    AP.add_argument('--project-root-dir', type=str, default=os.getcwd())
    AP.add_argument('--environment-name', type=str, required=True, default=None)

    ARGS = AP.parse_args()

    sys.exit(main(ARGS))
