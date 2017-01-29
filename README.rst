
==============
Motion formula
==============

Motion is a program that monitors the video signal from cameras. It is able to detect if a significant part of the picture has changed; in other words, it can detect motion. See more below. 

Sample pillars
==============

.. code-block:: yaml

    motion:
      server:
        source:
          engine: git
          address: git@url.com
          rev: master
        enabled: true
        daemon: on # | if used another service wrapper off
        palette: 0
        quality: 100
        threshold: 1500
        output_normal: on
        control:
          localhost: off
          port: 8080
        authentication:
          username: admin
          password: admin
        devices:
        - webcam:
          point: "/dev/video0"
          localhost: off
          port: 8081

Custom port listening

.. code-block:: yaml

    motion:
      server:
        enabled: true
        webcam:
          localhost: off
          port: 8081
        control:
          localhost: on | means localhost-only
          port: 8080

Authentication 

.. code-block:: yaml

    motion:
      server:
        enabled: true
        authentication:
          username: admin
          password: admin 

Read More
=========

* http://www.lavrsen.dk/foswiki/bin/view/Motion/WebHome
* http://motion.sourceforge.net/