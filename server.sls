{%- if pillar.motion.server.enabled %}

motion_packages:
  pkg:
  - installed
  - names:
    - motion
    - ffmpeg

{%- if pillar.motion.server.devices is defined and pillar.motion.server.devices|length == 1 %}

/etc/motion/motion.conf:
  file:
  - managed
  - source: salt://motion/conf/motion.conf
  - template: jinja
  - user: root
  - group: root
  - mode: 644
  - require:
    - pkg: motion_packages

{%- else %}
{%- for cam in pillar.motion.server.devices %}
/etc/motion/thread.conf:
  file:
  - managed
  - source: salt://motion/conf/thread{{ loop.index }}.conf
  - template: jinja
  - user: root
  - group: root
  - mode: 644
  - require:
    - pkg: motion_packages
{%- endfor %}
{%- endif %}

/etc/default/motion:
  file:
  - managed
  - source: salt://motion/conf/motion
  - template: jinja
  - user: root
  - group: root
  - mode: 644
  - require:
    - pkg: motion_packages

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
  - require:
    - pkg: motion_packages
    - file: /etc/default/motion

{% endif %}