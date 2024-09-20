# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.6] - 2024-09-16
### Added
- Ansible role: quota propagation from parent project to children

## [1.0.5] - 2024-07-04
### Changed
- CI (infra-deploy) reduce terraform plan verbosity (log identical, stdout reduced)

## [1.0.4] - 2024-07-02
### Added
- Ansible networking-group-projects skips on project tag default-group-project-networking=false
### Changed
- shorten CI job names (prefix ostack -> ost)

## [1.0.3] - 2024-07-02
### Fixed
- workaround openstack_blockstorage_quotaset_v3 terraform resource behavior when defined assigns all values regardless of defaults, see https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/blockstorage_quotaset_v3 for more details

## [1.0.2] - 2023-12-18
### Fixed
- CI refactoring (docker DnD -> podman to increase portability/compatibility with other gitlab runners)

## [1.0.1] - 2023-12-18
### Fixed
- CI fixes (artifact paths, more DRY)

## [1.0.0] - 2023-12-18
### Added
- Initial release
