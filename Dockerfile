# Dockerfile for Nano Server with MySQL.

FROM microsoft/nanoserver

ADD https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-5.7.21-winx64.zip mysql.zip

RUN powershell -command Expand-Archive -Path c:\mysql.zip -DestinationPath C:\ ; \
    ren C:\mysql-5.7.21-winx64 C:\MySQL  ; \
    New-Item -Path C:\MySQL\data -ItemType directory ; \
    C:\MySQL\bin\mysqld.exe --initialize-insecure --console --explicit_defaults_for_timestamp ; \
    C:\MySQL\bin\mysqld.exe --install ; \
    Remove-Item c:\mysql.zip -Force

RUN C:\MySQL\bin\mysql.exe -u root -e "GRANT ALL PRIVILEGES ON *.* TO root@'%' IDENTIFIED BY 'root'; flush privileges;"

ENV MYSQL C:\\MySQL

RUN setx PATH /M %PATH%;C:\MySQL\bin

EXPOSE 3306

CMD ["mysqld.exe"]