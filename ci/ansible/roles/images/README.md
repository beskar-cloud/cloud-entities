# Ansible role for managing Ostack images

* Role requires following external variables to be specified:
    
    1. `cloud_entities_image_folder` - path to folder with image yaml declarations
    1. `task` - task to perform (value of variable is name of one from possible tasks listed in section `Available tasks`) 

* Example:
`ansible-playbook ci/ansible/images.yml -e cloud_entities_image_folder <DECLARATIONS_FOLDER> -e task=<TASK_NAME>`

### Available tasks:
*  `upload`

    * Task for uploading specified images based on specified image declarations into OpenStack

    * This task works in **2** possible settings:
        
        * It uploads a new image if image under same name is **not** present in OpenStack
        
        * It uploads a new image if `glance_resources_image_name` and `glance_register_image_name` external variables are specified

            * `glance_resources_image_name` variable specifies name of image. It specifies name of the image to upload. The name of the image must be equal to one of the `name` attribute from the **yaml** declarations.
        
            * `glance_register_image_name` variable specifies a name under which an uploaded image will be available in OpenStack

            * Example:
                `ansible-playbook ci/ansible/images.yml -e cloud_entities_image_folder <DECLARATIONS_FOLDER> -e task=upload -e glance_resources_image_name=cirros-0-x86_64 -e glance_register_image_name=new-cirros-0-x86_64`

            * Above example does following:
                
                * It loads and reads image yaml declarations from `<DECLARATIONS_FOLDER>`
                
                * It performs task `upload`

                * It only considers image declaration with `name: cirros-0-x86_64` attribute

                * New image is available in OpenStack under name: `new-cirros-0-x86_64`

            * Described mechanism is used by **image-rotation**

        * Additionally this task computes **sha256** checksum of the **original** downloaded image file and saves it as `pre_upload_sha256sum` attribute into OpenStack image metadata.

            * `pre_upload_sha256sum` attribute is used by **image-rotation** for image freshness checks.