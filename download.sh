#!/bin/sh
wget https://www.python.org/ftp/python/3.5.1/python-3.5.1-amd64.exe
cat unattend.xml.in | sed "s|TARGET_DIR|$PWD|" > unattend.xml
./python-3.5.1-amd64.exe /quiet /log install.log
