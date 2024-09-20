#!/usr/bin/env python3


import os
import pathlib
from collections import OrderedDict
from hamcrest import *

import ruamel.yaml

import lib


class OpenstackEntitiesYamlProjectQuotaCheck(lib.OpenstackEntitiesAbstractTests):

    @classmethod
    def setUpClass(self):
        self.project_dirs = os.path.join(os.getcwd(), 'environments', str(self.environment), 'openstack', 'projects-quotas-acls')

        self.project_files = []
        self.project_files += [str(filePath) for filePath in pathlib.Path(self.project_dirs).glob("**/*/*.yaml")]

    def check_port_count(self, quotas):
        if quotas['port'] < (3*quotas['router'] + quotas['instances']):
            return 5*quotas['router'] + quotas['instances']
        return 0

    def check_volume_count(self, quotas):
        if quotas['volumes'] < quotas['instances']:
            return quotas['instances']
        return 0

    def test_project_quotas(self):
        yaml = ruamel.yaml.YAML()  # defaults to round-trip if no parameters given
        yaml.explicit_start = True
        yaml.allow_duplicate_keys = False
        yaml.indent(mapping=2, sequence=4, offset=2)  # follow offsetting of the hiera

        for projectFileName in self.project_files:
            with open(projectFileName, "r") as source:
                project = dict(yaml.load(source))

            try:
                if project['quota'] == {}:
                    continue
                # special unlimited or zeroed project
                if {-1, 0} & {project['quota']['port'], project['quota']['router'], project['quota']['instances']}:
                    continue
            except KeyError:
                continue

            missing_ports = 0
            missing_volumes = 0

            if missing_ports := self.check_port_count(project['quota']):
                project['quota']['port'] = missing_ports
                assert_that(
                    missing_ports,
                    is_(less_than_or_equal_to(0)),
                    'Err. port count in project {name} does not match, extend to: {val}'.format(name=project['project']['name'], val=int(missing_ports)))
            if missing_volumes := self.check_volume_count(project['quota']):
                project['quota']['volumes'] = missing_volumes
                assert_that(
                    missing_volumes,
                    is_(less_than_or_equal_to(0)),
                    'Err. volume count in project {name} does not match, extend to: {val}'.format(name=project['project']['name'], val=int(missing_volumes)))
