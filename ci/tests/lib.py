import unittest
import pathlib
import re
import os
import json

class OpenstackEntitiesAbstractTests(unittest.TestCase):
    environment = os.environ.get('ENVIRONMENT', "stage")
    schemas = {}
    for file in pathlib.Path(os.path.join("ci", "schemas")).rglob('*.json'):
        catch = re.search(rf"schemas\/(.*).json", str(file))
        with open(file, "r") as file_handler:
            schemas[catch.group(1)] = json.load(file_handler)
