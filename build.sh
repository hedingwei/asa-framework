#!/bin/sh
svn up
mvn package
chmod 755 target/jsw/WebAppTemplate/bin/*
