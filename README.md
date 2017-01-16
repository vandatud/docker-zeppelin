# VANDA - Zeppelin Container

_This image is only intended for being part of the VANDA Deap Learning Stack!_ 
Runs [Zeppelin 0.6.2](https://zeppelin.apache.org/docs/0.6.2/) on top of the [phusion/baseimage](https://hub.docker.com/r/phusion/baseimage/) with Ubuntu 16.04 as base system.

## Dockerfile

[`vandatud/zeppelin` Dockerfile](https://github.com/vandatud/docker-zeppelin/blob/master/Dockerfile)

## How to rebuild an extended image

After pull this repository and change the dockerfile build the new image and push it to the DockerHub
```
$ docker build -t vanda-zeppelin /path/to/dockerfile_directory
```

```
$ docker images
REPOSITORY                     TAG                 IMAGE ID            CREATED             SIZE
vanda-zeppelin                 latest              b5454aa510d8        2 hours ago         1.98 GB
```

```
$ docker tag b5454aa510d8 vandatud/zeppelin:latest
```

```
$ docker login
```

```
$ docker push vandatud/zeppelin
```

## How to use this image

Run a new container instance without

```
$ docker run -t -p 8080 --name vanda-zeppelin_inst* vandatud/zeppelin
```

or with an interactive bash session.

```
$ docker run -it -p 8080 --name vanda-zeppelin_inst* vandatud/zeppelin /bin/bash
```

```
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                     NAMES
105287df93ce        vanda-zeppelin      "/sbin/my_init"     About an hour ago   Up About an hour    0.0.0.0:32772->8080/tcp   vanda-zeppelin_inst5
```

Once the container is running you can open the webinterface under the attached host port (i.e. [localhost:32772](http://localhost:32772))