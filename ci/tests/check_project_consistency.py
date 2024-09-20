#!/usr/bin/env python3


import os
import pathlib
import re
import yaml
from hamcrest import *

import lib


class OpenstackEntitiesYamlProjectConsistencyCheck(lib.OpenstackEntitiesAbstractTests):

    @classmethod
    def setUpClass(self):
        self.project_dirs = os.path.join(os.getcwd(), 'environments', str(self.environment), 'openstack', 'projects-quotas-acls')

        self.project_files = []
        self.project_files += [str(filePath) for filePath in pathlib.Path(self.project_dirs).glob("**/*/*.yaml")]

    def test_project_consistency(self):
        for projectFileName in self.project_files:
            with open(projectFileName, "r") as source:
                project = yaml.load(source, Loader=yaml.FullLoader)

            assert_that(
                project['project'],
                has_item('tags'),
                'Project {} does not have tags for resource consumption monitoring.'.format(project['project']['name']))
            assert_that(
                project['project']['tags'],
                not_none(),
                'Project {} does have tags but the list is empty.'.format(project['project']['name']))
            if 'quota' not in project:
                print('Project {} does not have quotas set, will consider it being a placeholder skipping'.format(project['project']['name']))
                continue
            # Verify email is set up
            assert_that(
                project['metadata'],
                has_item('contacts'),
                'Project {} does not have contacts field.'.format(project['project']['name']))

            assert_that(
                project['metadata']['contacts'],
                not_none(),
                'Project {} contact list should contain at least single person.'.format(project['project']['name']))
            if project['metadata']['contacts'] is not None:
                for contact in project['metadata']['contacts']:
                    re_match = re.match("[^@]+@[^@]+\.[^@]+", contact)
                    assert_that(
                        re_match,
                        not_none(),
                        "Project {} contact {} is invalid (does not match email regexp).".format(project['project']['name'], contact))
            # Verify router quota is explicitly set, defaults to 0
            if project['project']['name'] not in ['group-projects','personal-projects']:
                assert_that(
                    project['quota'],
                    has_item('router'),
                    'Project {} does not have a router quota set and defaults to zero'.format(project['project']['name']))
