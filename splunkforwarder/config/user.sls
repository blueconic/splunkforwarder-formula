# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as splunkforwarder with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

splunkforwarder_group:
  group.present:
    - name: {{ splunkforwarder.group }}
    - gid: {{ splunkforwarder.group_id }}

splunkforwarder_user:
  user.present:
    - name: {{ splunkforwarder.user }}
    - uid: {{ splunkforwarder.user_id }}
    - allow_uid_change: True
    - gid: {{ splunkforwarder.group_id }}
    - allow_gid_change: True
    - home: /opt/splunkforwarder
    - usergroup: {{ splunkforwarder.group }}
    - remove_groups: True
    - shellL: /sbin/nologin
    - groups:
      - {{ splunkforwarder.group }}
      {% for group in splunkforwarder.additionalgroups -%}
      - {{ group }}
      {%- endfor %}
    - require:
        - group: splunkforwarder_group

splunkforwarder_home_dir:
  file.directory:
      - name: /opt/splunkforwarder
      - user: splunk
      - group: splunk
      - dir_mode: 750
      - file_mode: 644
