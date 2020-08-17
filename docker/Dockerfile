# SQL Server Command Line Tools
FROM ubuntu:18.04

LABEL maintainer="SQL Server Engineering Team"

# apt-get and system utilities
RUN apt-get update && apt-get install -y \
	curl apt-transport-https debconf-utils gnupg \
    && rm -rf /var/lib/apt/lists/*

# adding custom MS repository
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN curl https://packages.microsoft.com/config/ubuntu/18.04/mssql-server-2019.list > /etc/apt/sources.list.d/mssql-release-2.list
# install SQL Server drivers and tools
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y unixodbc-dev mssql-tools openvpn
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc"



RUN apt-get -y install locales
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8



CMD /bin/bash 
