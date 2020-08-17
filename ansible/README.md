# Ansible

This sets up OpenVPN and MS SQL Server on Ubuntu 18.04 VMs

## Setup


```
pip install ansible
```

Edit [inventory.yml](./inventory.yml)

Edit [group_vars/all.yml](group_vars/all.yml) and remove the `ansible_ssh_private_key_file` line if you did not create the instances with this project's [terraform](../tf).  

Edit [host_vars/vpn-server.yml](host_vars/vpn-server.yml) & [host_vars/sql-server.yml](host_vars/sql-server.yml) to reflect the correct values.

In [host_vars/vpn-server.yml](host_vars/vpn-server.yml) add your desired VPN clients and set the AWS LS Private IP to the correct value for your SQL Server VM.

In [host_vars/sql-server.yml](host_vars/sql-server.yml) set the `sqlserver_sa_password` to your desired `SA` password.   

> NOTE: Rerunning Ansible will ALWAYS RESET THE SA PASSWORD to the value in [host_vars/sql-server.yml](host_vars/sql-server.yml)! Keep this in mind :)

## Deployment

### VPN

```
ansible-playbook -i inventory.yml install_vpn.yml
```

You will get a new directory called `remote_files` with a folder per VPN client defined that contains an OVPN profile.

### MSSQL

```
ansible-playbook -i inventory.yml install_mssql.yml
```

Congrats MS SQL Server is now running. You can reset the SA password by updating [host_vars/sql-server.yml](host_vars/sql-server.yml). 

You can connect to the DB server from the SQL Server VM by running 

```
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA 
```

You can connect to the DB server via VPN by importing the VPN profile into your client or by using the [instructions for the docker file](docker/README.md).