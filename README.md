# scalable-qa-with-docker

Are you tired of maintaining all your Jenkins jobs running Selenium WebDriver tests connecting to several Jenkins slaves and the inconsistency of the setup? 
We need to become aware that it's inefficient to keep all the environments, browsers and selenium web drivers up to date manually. 

During this session the attendees will be introduced to setting up scalable and solid Selenium Grids. 
We’ll also teach you how to write maintainable and scalable Selenium / WebDriver tests.

Trough practical examples and exercises the following questions will be answered:

* What makes a good Selenium Grid?
* Do we need to support all browsers?
* What is a good strategy to setup Selenium Grids with multiple teams?
* How to use the Selenium Grid locally?
* How to build and scale the Selenium Grid(s) using Docker?
* How do you write a solid Selenium / WebDriver test using the Selenium Grid?

_This clusters is configured to use a significant amount of resources. 
Current set up allocats 6 CPU and 6 GB of memory._

Prerequisites

- [Vagrant](https://www.vagrantup.com/) + [VirtualBox](https://www.virtualbox.org/)

Given:

    $ git clone https://github.com/mjvdende/continuous-delivery-pipeline.git 
    $ cd continuous-delivery-pipeline

When:

    $ vagrant up

Then:

    start building!

It can take a while before services are started because docker is downloading images from the docker hub.
Therefor you can follow the progress of services booting when logging on to a core, for example core-02.

    $ vagrant ssh core-02
    $ journalctl -u jenkins.service -f

## Services Provided

_Once a sevice is started below links will point to your local instance of the running service._

### core-01

- docker.service
- docker-registry.service - URL: [Docker Registry](http://172.17.8.101:5000)
- docker-registry-web.service - URL: [Docker Registry Web](http://172.17.8.101:8181)
- gitbucket.service - URL: [GitBucket](http://172.17.8.101:8282) (login:root-root)

### core-02

- docker.service
- jenkins.service - URL: [Jenkins](http://172.17.8.102:8888)

## Config 

### Cloud-Config

To start our cluster, we need to provide some config parameters in cloud-config format via the ```*.user-data``` file and set the number of machines in the cluster in ```config.rb```.
For each core a user-data file exists. Our cluster will use an etcd discovery URL to bootstrap the cluster of machines and elect an initial etcd leader. 
Be sure to replace <token> with your own URL from https://discovery.etcd.io/new in each ```*.user-data file```.

    coreos:
        etcd2:
            # generate a new token for each unique cluster from https://discovery.etcd.io/new?size=3
            # specify the initial size of your cluster with ?size=X
            # WARNING: replace each time you 'vagrant destroy'
            discovery: https://discovery.etcd.io/<token>

More about using [cloud-config](https://coreos.com/os/docs/latest/cloud-config.html)

### Add a Service

You can add a serivce yourself to one of the ```*.user-data``` config files. 
Have a look at already defined services for examples. 

    - name: xlview.service
      command: start
      enable: true
      content: |
        [Unit]
        Description=XL View
        After=docker.service
        Requires=docker.service

        [Service]
        TimeoutStartSec=0
        ExecStartPre=-/usr/bin/docker kill xlview
        ExecStartPre=-/usr/bin/docker rm xlview
        ExecStart=/usr/bin/docker run \
                         -p 4516:4516 \
                         --name="xlview" \
                         mjvdende/docker-xlview
        ExecStop=/usr/bin/docker stop xlview

To apply changes to ```*.user-data``` reload vagrant provisioning: 

    vagrant reload --provision

## Todo

- jenkins install plugins git
- automatically replace token in ```*.user-data``` file
