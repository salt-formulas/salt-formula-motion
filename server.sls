{%- if pillar.motion.server.enabled %}

motion_packages:
  pkg:
  - installed
  - names:
    - motion
    - ffmpeg

/etc/motion/motion.conf:
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

{%- if pillar.motion.server.devices is defined and pillar.motion.server.devices|length > 1 %}
{%- for device in pillar.motion.server.devices %}
/etc/motion/thread{{ loop.index }}.conf:
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
  - enable: True
  - require:
    - pkg: motion_packages
  - watch:  
    - file: /etc/default/motion

{% endif %}