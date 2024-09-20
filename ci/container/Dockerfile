FROM registry.gitlab.ics.muni.cz:443/cloud/g2/custom-terraform-provider-openstack:v1.5.2-0.0.1 as custom-terraform-provider-openstack


FROM ubuntu:jammy

ENV TZ=Europe/Prague
ENV DEBIAN_FRONTEND=noninteractive

COPY *.sh /usr/local/bin/
COPY requirements.* /tmp/
COPY --from=custom-terraform-provider-openstack /root/.terraform.d/plugins/gitlab.ics.muni.cz/cloud/openstack/0.0.1/linux_amd64/terraform-provider-openstack /tmp

RUN /usr/local/bin/install-apt-repo.sh https://apt.releases.hashicorp.com https://apt.releases.hashicorp.com/gpg /etc/apt/trusted.gpg.d/hashicorp.gpg && \
    /usr/local/bin/install-pkgs.sh /tmp/requirements.apt && \
    /usr/local/bin/install-pymodules.sh /tmp/requirements.pip && \
    /usr/local/bin/install-ansiblemodules.sh /tmp/requirements.ansible.yaml && \
    mkdir -p $HOME/.terraform.d/plugins/gitlab.ics.muni.cz/cloud/openstack/0.0.1/linux_amd64 && \
    mv -f /tmp/terraform-provider-openstack $HOME/.terraform.d/plugins/gitlab.ics.muni.cz/cloud/openstack/0.0.1/linux_amd64/terraform-provider-openstack

# Terraform autocomplete
RUN touch ~/.bashrc && terraform -install-autocomplete

