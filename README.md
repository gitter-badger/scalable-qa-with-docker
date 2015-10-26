# scalable-qa-with-docker

[![Join the chat at https://gitter.im/xebia/scalable-qa-with-docker](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/xebia/scalable-qa-with-docker?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

_This clusters is configured to use a significant amount of resources.
Current set up allocates 6 CPU and 6 GB of memory._

####Prerequisites

- Download [data.zip](http://bit.ly/scale-qa-data) and unzip, place in root of this project
- [Vagrant](https://www.vagrantup.com/) + [VirtualBox](https://www.virtualbox.org/)

####Given:

    $ git clone https://github.com/xebia/scalable-qa-with-docker.git
    $ cd scalable-qa-with-docker

####When:

    $ vagrant up

####Then:

You have to start services yourself with ```systemd```, a utility baked into CoreOs designed to stop, start and manage processes defined in [unit files](https://coreos.com/docs/launching-containers/launching/getting-started-with-systemd/), for example let's start jenkins:

    $ sudo systemctl start jenkins

You can follow the progress of services booting when logging on to a core, for example core-01:

    $ vagrant ssh core-01
    $ journalctl -u jenkins.service -f

## Services Provided

_Once a sevice is started below links will point to your local instance of the running service._

### core-01

- docker.service
- gitbucket.service - URL: [GitBucket](http://172.17.8.101:8080) (login:root-root)
- jenkins.service - URL: [Jenkins](http://172.17.8.101:8181)
- petclinic.service - URL: [Petclinic](http://172.17.8.101:8282/petclinic)
- mesos-master.service - URL: [Mesos Master](http://172.17.8.101:5050)
- docker-registry.service - URL: [Docker Registry](http://172.17.8.101:5000/v2/_catalog)
- Selenium Hub.service - URL: [Selenium Hub](http://172.17.8.101:4444/grid/console)

### core-02

- docker.service
- mesos-slave.service
- chrome-debug.service - URL: [Chrome Debug](http://172.17.8.101:4448/grid/console)
