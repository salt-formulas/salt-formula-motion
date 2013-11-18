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
        webcam_port: 8081
        control_port: 8080

## Read More

* http://www.lavrsen.dk/foswiki/bin/view/Motion/WebHome
* http://motion.sourceforge.net/