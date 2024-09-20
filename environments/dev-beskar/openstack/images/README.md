# OpenStack image declaration

## Approach

Yaml image description is deployed to OpenStack via ansible code.
Terraform is not used as we want to rotate freshen already existing images.
Image rotation the terraform way is difficult because of:
 * upstream images does not provide long history (almalinux, rockylinux just last version, ubuntu just month or so)
 * upstream images are typically in QCOW2 format but we want to upload them as RAW (for [good reasons](https://docs.ceph.com/en/quincy/rbd/qemu-rbd/#creating-images-with-qemu))
 * image rotation should take place around midnight when there is low cloud traffic

The situation complicates also with fact that we do not want to store images locally, we want to upload images stored upstream.

