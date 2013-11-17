{%- if pillar.motion.server.enabled is defined %}

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
  - user: root
  - group: root
  - mode: 644
  - require:
    - pkg: motion_packages

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
    - file: /etc/motion/motion.conf
    - file: /etc/default/motion

{% endif %}