# Dockerfile for sqlcmd and openvpn

This docker image is based on [the MS mssql-tools Dockerfile](https://github.com/Microsoft/mssql-docker/blob/master/linux/mssql-tools/Dockerfile) updated to Ubuntu 18.04 for a more recent `openvpn` client.

```
docker build -t sqlcmd .
```

### Test VPN and sqlcmd

You'll need the SQL Server's private IP address

```
docker run --rm -it -v $PWD/../ansble/remote_files:/remote sqlcmd
# Inside docker container
openvpn /remote/remote_files/vpn/configs/demo_user/vpn-server.ovpn &
/opt/mssql-tools/bin/sqlcmd -S $SQL_SERVER_PRIVATE_IP -U SA
```

This will allow you to test the VPN and connectivity to sqlserver
