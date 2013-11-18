# Motion

Motion is a program that monitors the video signal from cameras. It is able to detect if a significant part of the picture has changed; in other words, it can detect motion. See more below. 

## Sample pillars

    motion:
      server:
        enabled: true
        daemon: on # | if used another service wrapper off
        device: "/dev/video0"
        palette: 0
        quality: 100
        threshold: 1500
        output_normal: on

## Sample pillar - custom port listening

    motion:
      server:
        enabled: true
        webcam:
          localhost: off
          port: 8081
        control:
          localhost: on | means localhost-only
          port: 8080

## Sample pillar - authentication 

    motion:
      server:
        enabled: true
        authentication:
          username: admin
          password: admin 

## Read More

* http://www.lavrsen.dk/foswiki/bin/view/Motion/WebHome
* http://motion.sourceforge.net/