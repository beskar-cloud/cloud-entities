#!/usr/bin/env python3
"""
check-yaml-lint.py checks and validates yaml files

Script can check for key duplicities and compositional error.
In the end it reports found errors and total number of found errors.

Usage:
    python3 check_yaml_lint.py --path PATH

"""

import os
import re
import pathlib

import ruamel.yaml
from hamcrest import *

import lib 

class OpenstackEntitiesYamlStructureCheck(lib.OpenstackEntitiesAbstractTests):

    @classmethod
    def setUpClass(self):
        self.yaml_parser = ruamel.yaml.YAML(typ="safe")
        self.yaml_parser.allow_duplicate_keys = False
        self.yaml_files = [str(file) for file in pathlib.Path(os.getcwd()).rglob('*/**/*.yaml')]

    def test_key_duplicity(self):
        """Checks if no key duplicities in yaml file are present"""
        err_found = False
        err_output_total = ""       
        for file in self.yaml_files:
            with open(file, "r", encoding="utf-8") as yaml_handle:
                try:
                    self.yaml_parser.load(yaml_handle)
                except ruamel.yaml.constructor.DuplicateKeyError as duplicate_key_err:
                    err_output = str(duplicate_key_err).split("\n")[0:4]
                    err_output = "\n".join(err_output)
                    err_output_total += f'DUPLICATE KEY ERROR in "{file}":\n{err_output}\n\n'
                    err_found = True
                except ruamel.yaml.composer.ComposerError:
                    pass
        assert_that(err_found, is_(False), err_output_total)


    def test_composition_structure(self):
        """Checks if no compositional errors in yaml file are present"""
        err_found = False
        err_output_total = ""
        for file in self.yaml_files:
            with open(file, "r", encoding="utf-8") as yaml_handle:
                try:
                    self.yaml_parser.load(yaml_handle)
                except ruamel.yaml.composer.ComposerError as composer_err:
                    err_output = str(composer_err)
                    err_output_total += f'COMPOSITION ERROR in "{file}":\n{err_output}\n\n'
                    err_found = True
                except ruamel.yaml.constructor.DuplicateKeyError:
                    pass
        assert_that(err_found, is_(False), err_output_total)
