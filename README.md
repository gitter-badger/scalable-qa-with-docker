# scalable-qa-with-docker

_This clusters is configured to use a significant amount of resources.
Current set up allocats 6 CPU and 6 GB of memory._

Prerequisites

- [Vagrant](https://www.vagrantup.com/) + [VirtualBox](https://www.virtualbox.org/)

Given:

    $ git clone https://github.com/xebia/scalable-qa-with-docker.git
    $ cd scalable-qa-with-docker

Download https://goo.gl/6tOv2V and unzip, place in root of project.

When:

    $ vagrant up

Then:

    start building!

It can take a while before services are started because docker is downloading images from the docker hub.
Therefor you can follow the progress of services booting when logging on to a core, for example core-02.

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

### core-03

- docker.service
