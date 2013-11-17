# Motion

### Suported OS

* Ubuntu

### Sample pillar

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

# Read More

* http://motion.sourceforge.net/