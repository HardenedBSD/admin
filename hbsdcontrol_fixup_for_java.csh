#!/bin/sh

hbsdcontrol system mprotect disable /usr/local/openjdk8/bin/java
hbsdcontrol system pageexec disable /usr/local/openjdk8/bin/java
hbsdcontrol system mprotect disable /usr/local/openjdk8/jre/bin/java
hbsdcontrol system pageexec disable /usr/local/openjdk8/jre/bin/java
