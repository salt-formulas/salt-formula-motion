{% from "motion/map.jinja" import motion with context %}

{%- if motion.enabled %}

motion_packages:
  pkg:
  - installed
  - names: {{ motion.pkgs }}

motion_user:
  user.present:
  - name: motion
  - system: True
  - home: /opt/motion


/opt/motion:
  file.directory:
  - user: motion
  - group: motion
  - mode: 755
  - makedirs: True
  require:
  - user: motion_user

{%- if motions.source.engine == "git" %}
include:
- git

{{ motion.base_url }}:
  git.latest:
  - target: {{ motion.base_dir }}
  - rev: master
  - require:
    - pkg: git_packages

motion_install:
  cmd.run:
  - name: "autoconf && ./configure && make && make install"
  - cwd: {{ motion.base_dir }}
  - user: root
  - unless: test -d {{ motion.base_dir }}/motion-dist
  - require:
    - git: {{ motion.base_url }}
    - pkg: motion_packages

/usr/local/bin/motion:
  file.symlink:
  - target: {{ motion.base_dir }}/motion
  - require:
    - cmd: motion_install
{%- else %}

{%- endif %}

{{ motion.base_dir }}/motion.conf:
  file:
  - managed
  - source: salt://motion/conf/motion.conf
  - template: jinja
  - defaults:
      localhost: {{ pillar.motion.server.control.localhost }}
  - user: root
  - group: root
  - mode: 644
  - require:
    - pkg: motion_packages
    - cmd: motion_install

{%- if pillar.motion.server.devices is defined and pillar.motion.server.devices|length > 1 %}
{%- for device in pillar.motion.server.devices %}
{{ motion.base_dir }}/thread{{ loop.index }}.conf:
  file:
  - managed
  - source: salt://motion/conf/thread.conf
  - template: jinja
  - user: root
  - defaults:
      port: {{ device.port }}
      target: /tmp/motion/cam{{ loop.index }}
      point: {{ device.point }}
      localhost: {{ device.localhost }}
  - group: root
  - mode: 644
  - require:
    - pkg: motion_packages
{%- endfor %}
{%- endif %}

/var/run/motion:
  file.directory:
  - user: motion
  - group: motion
  - mode: 755
  - makedirs: True
  - require:
    - pkg: motion_packages

motion_service:
  service.running:
  - name: motion
  - enable: True
  - require:
    - cmd: motion_install
  - watch:  
    - file: {{ motion.base_dir }}/conf/motion.conf

{% endif %}