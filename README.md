# VANDA - Zeppelin Container

_This image is only intended for being part of the VANDA Deap Learning Stack!_ 
Runs [Zeppelin 0.6.2](https://zeppelin.apache.org/docs/0.6.2/) on top of the [phusion/baseimage](https://hub.docker.com/r/phusion/baseimage/) with Ubuntu 16.04 as base system.

## Dockerfile

[`vandatud/zeppelin` Dockerfile](https://github.com/vandatud/docker-zeppelin/blob/master/Dockerfile)

## How to rebuild an extended image

After pulling this repository and changing the Dockerfile first build the new image locally to test it.
Optionally specify the repository and tag at which to save the new image if the build succeeds.
```
$ cd /path/to/Dockerfile
$ docker build -t vandatud/zeppelin:0.1.1 -t vandatud/zeppelin:latest
```

If this Git repository is pushing back to the server, DockerHub will automatically build this image.
For manually push the locally build to the DockerHub use the docker cli.

```
$ docker login
```

```
$ docker push vandatud/zeppelin:0.1.1
```

## How to use this image

Run a new container instance without

```
$ docker run -d -t -P --name vanda-zeppelin_inst vandatud/zeppelin:latest
```

or with an interactive bash session for inspecting the image.

```
$ docker run --rm -t -i -P --name vanda-zeppelin_inst vandatud/zeppelin:latest /sbin/my_init -- bash -l
```

```
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                     NAMES
105287df93ce        vandatud/zeppelin   "/sbin/my_init"     About an hour ago   Up About an hour    0.0.0.0:32772->8080/tcp   vanda-zeppelin_inst
```

Once the container is running you can open the web interface under the attached host port (i.e. [localhost:32772](http://localhost:32772))
