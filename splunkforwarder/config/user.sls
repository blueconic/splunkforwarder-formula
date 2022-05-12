# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as splunkforwarder with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

splunkforwarder_group:
    group.present:
        - name: group
        - gid: 4005

splunkforwarder_user:
  user.present:
    - name: splunk
    - uid: 4005
    - gid: 4005
    - home: /opt/splunkforwarder
    - usergroup: splunk
    - groups:
      - splunk
    - require:
      - group: splunkforwarder_group

