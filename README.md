# VPN protected Microsoft SQL Server on AWS Lightsail

## Terraform

The [tf](./tf) directory contains the Terraform files to create 2 Lightsail VMs.  One for the VPN($5/month), one for the MS SQL Server($10/month).

See [tf/README.md](tf/README.md) for notes and issues.

## Ansible

The [ansible](./ansible) directory contains the Ansible files to provision OpenVPN and MS SQL Server to Ubuntu 18.04 VMs.

See [ansible/README.md](tf/README.md) for notes and issues.

## Docker

The [docker](./docker) directory contains a Dockerfile to build an Ubuntu 18.04 image with `sqlcmd` and `openvpn`. For testing.