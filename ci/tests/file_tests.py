import unittest
import pathlib
import re
import os
import json

import yaml
import jsonschema
from hamcrest import *

import lib

class OpenstackEntitiesYamlFormatTest(lib.OpenstackEntitiesAbstractTests):

    @classmethod
    def setUpClass(self):
        self.yaml_files = [str(file) for file in pathlib.Path(os.path.join("environments", self.environment)).rglob('*/**/*.yaml')]

    def test_valid_yaml_file(self):
        """
        verifies that yaml files are loadable
        if fails returns list of invalid files
        """
        invalid_documents = {}
        for file in self.yaml_files:
            with open(file, "r") as file_handler:
                try:
                    yaml.safe_load_all(file_handler)
                except Exception as e:
                    invalid_documents[file] = {'error': e}
        assert_that(invalid_documents, is_(empty()), "file with yaml extension does not follow yaml syntax (cannot be loaded with yaml.safe_load_all())")

    def test_schema(self):
        """
        verifies that yaml document schema is valid
        if fails returns list of invalid files
        """
        invalid_documents = {}
        for file in self.yaml_files:
            with open(file, "r") as file_handler:
                document = yaml.load(file_handler, Loader=yaml.SafeLoader)
            try:
                catch = re.search(rf".*-(.*).yaml", file)
                if (catch.group(1) in self.schemas):
                    jsonschema.validate(document, self.schemas[catch.group(1)])
            except Exception as e:
                invalid_documents[file] = {'error': e, 'schema': catch.group(1)}
        assert_that(invalid_documents, is_(empty()), "yaml document does not respect it's schema")

    def test_one_document_per_file(self):
        """
        verifies that only one yaml document exists in each file
        if fails returns list of files containing multiple documents
        """
        total_documents_in_file = {}
        for file in self.yaml_files:
            with open(file, "r") as tmp:
                total_documents_in_file[file] = len(list(yaml.safe_load_all(tmp)))
        failed_docs = { file: docs for file, docs in total_documents_in_file.items() if docs != 1}
        assert_that(failed_docs, is_(empty()), "file contains multiple documents (single document expected)")

class OpenstackEntitiesJsonFormatTest(lib.OpenstackEntitiesAbstractTests):

    @classmethod
    def setUpClass(self):
        self.json_files = [str(file) for file in pathlib.Path(os.path.join("environments", self.environment)).rglob('*/**/*.json')]

    def test_valid_file(self):
        """
        verifies that json files are loadable
        if fails returns list of invalid files
        """
        invalid_documents = []
        for file in self.json_files:
            with open(file, "r") as tmp:
                try:
                    json.load(tmp)
                except Exception:
                    invalid_documents.append(file)
        assert_that(invalid_documents, is_(empty()), "json file is invalid")

    def test_schema(self):
        """
        verifies that json document schema is valid
        if fails returns list of invalid files
        """
        invalid_documents = []
        for file in self.json_files:
            with open(file, "r") as file_handler:
                document = json.load(file_handler)
            try:
                catch = re.search(rf".*-(.*-.*).json", file)
                if (catch.group(1) in self.schemas):
                    jsonschema.validate(document, self.schemas[catch.group(1)])
            except Exception:
                invalid_documents.append(file)
        assert_that(invalid_documents, is_(empty()), "json document is invalid")
