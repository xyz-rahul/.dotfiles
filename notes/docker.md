# Docker Cheat Sheet

## Dockerfile

A Dockerfile contains instructions for Docker to package an application into an image.

### Building Image from Dockerfile

```bash
docker build -t <repository-name>:<tag> <path>
docker build -t hello-docker:v1.1 .
```

### Start Stop Run Attach a container

```bash
docker  start -i <image-id/tag>         # start a image from local (does not build a image)
docker  run      <image-name/id>        # run a new container
docker  exec     <image-name/id>        # attach session to running container
docker  start    <image-name/id>        # starts a stopped container (previous run by docker run)
docker  stop     <image-name/id>        # stops a running container
```

### Managing Docker Images

```bash
docker image ls
docker image ls -q                      # only print images id
docker image rm <repository-name>:<tag>
docker image tag <image_id> <old-repository-name>:<old-tag> <repository-name>:<tag>

docker image save -o <app-name>.tar     # Save one or more images to a tar archive

docker image load -i <path>.tar         # Load an image from a tar archive

docker image prune <repo-name>          # Remove all dangling images.
# -a also removes all images not referenced by any container.

docker image rm <imageID>
docker image rm $(docker image ls -q)
```

### Container Lifecycle Commands

#### Running a Container

```bash
docker run <image-name/id>
# Run a new container.

# Options:
# -it                                           Interactive mode.
# --name=<name>                                 Assign a name to the container.
# -d                                            Detached mode (runs in the background).
# -p 80:3000                                    Publish a container's port to the host (map port 3000 in container to port 80 on host).
# -v <path-in-host>:<path-in-contianer>         Publish a container's port to the host (map port 3000 in container to port 80 on host).

docker run -it -p 80:3000 -v $(pwd):/root ubuntu
```

#### Listing Containers

```bash
docker ps
# Print running containers.

# Options:
# -a               Show all containers (running and stopped).
```

### Attach to Running Container

    docker exec command interacts with an already running container

```bash
docker exec -it <container-name/id> bash
# Interact with an already running container.

# Options:
# -u <user-name>   Execute the command as a specified user.
# <container-PID>  ID or name of the running container.
docker exec -it bash
docker exec -it -u <user-name> <container-PID> bash
```

#### Removing Containers

```bash
docker container remove <repo-name>
docker rm <repo-name>
# Remove a stopped container.

# Options:
# -f               Force the removal of a running container (if container is running).
```

### Logs

```bash
docker logs [OPTIONS] CONTAINER
# Options:
# -f, --follow         Follow log output
# -n, --tail string    Number of lines to show from the end of the logs (default "all")
# -t, --timestamps     Show timestamps
```

## Docker Concepts

- **IMAGE**: A snapshot containing everything needed to run a program.
- **CONTAINER**: A runnable instance of an image.
- **DOCKER DAEMON**: Background service managing Docker containers and images.
- **DOCKER REGISTRY**: Repository for storing Docker images (e.g., Docker Hub).
- **BUILD CONTEXT**: Files available to the Docker daemon during image build.
- **LAYER**: Each instruction creates a new layer; layers are cached.

## Dockerfile Instructions

### Basic Instructions

```dockerfile
FROM <image>
# Set the base image for the new image.
# Example: FROM ubuntu:20.04

WORKDIR <path>
# Set the working directory for subsequent instructions.
# Example: WORKDIR /app

COPY <src> <dest>
# Copy files from host to container.
# Examples:
COPY . /app
COPY src/ /app/src/
COPY file1.txt file2.txt /app/
COPY ["myfile.txt", "/app/"]
COPY ["src/", "/app/src/"]

ADD <src> <dest>
# Copy files and URLs; supports automatic extraction of tar files.
# Examples:
ADD https://example.com/file.tar.gz /app/
ADD myarchive.tar.gz /app/

RUN <command>
# Execute command in a new layer; used for installations.
# Examples:
RUN apt-get update && apt-get install -y python3
RUN pip install -r requirements.txt

ENTRYPOINT <command>
# The ENTRYPOINT specifies a command that will always be executed when the container starts.
# Examples:
ENTRYPOINT ["python3", "app.py"]
ENTRYPOINT ["/usr/bin/myapp"]

CMD <command>
# The CMD specifies arguments that will be fed to the ENTRYPOINT.
# Examples:
CMD ["python3", "app.py"]
CMD ["npm", "start"]

ENV <key>=<value>
# Set environment variables in the container.
# Examples:
ENV APP_ENV=production
ENV DATABASE_URL="postgres://user:password@db:5432/mydb"

EXPOSE <port>
# Document the ports the container listens on at runtime.
# Examples:
EXPOSE 8080
EXPOSE 80 443

USER <username|UID>
# Specify the username or UID for the container processes.
# Examples:
USER appuser
USER 1001

VOLUME <path>
# Create a mount point for external volumes.
# Examples:
VOLUME ["/data"]
VOLUME /mnt/data

ARG <name>
# Define build-time variables for the Dockerfile.
# Examples:
ARG VERSION=1.0
ARG NODE_VERSION=14

LABEL <key>=<value>
# Add metadata to the image for organization.
# Examples:
LABEL maintainer="you@example.com"
LABEL version="1.0" description="My application"

SHELL <shell>
# Specify the shell for the RUN command.
# Examples:
SHELL ["/bin/bash", "-c"]
SHELL ["/bin/sh", "-c"]
```

### Note on ENTRYPOINT and CMD

The `ENTRYPOINT` specifies a command that will always be executed when the container starts. It cannot be overridden and is typically set to `/bin/sh -c`. However, there is no default `CMD`.

The `CMD` specifies arguments that will be fed to the `ENTRYPOINT`.

When you run Docker like this:
```bash
        docker run -i -t ubuntu bash
```
the entrypoint is the default:
```bash
        /bin/sh -c,
```
the image is ubuntu and the CMD is bash which is fed to image.


## Volumes

```bash
docker volume create <vol-name>
docker volume inspect <vol-name>
```

### Example

```bash
docker volume create app-data
docker volume inspect app-data
# Output:
# [
#     {
#         "CreatedAt": "2024-09-19T17:42:22Z",
#         "Driver": "local",
#         "Labels": null,
#         "Mountpoint": "/var/lib/docker/volumes/app-data/_data",
#         "Name": "app-data",
#         "Options": null,
#         "Scope": "local"
#     }
# ]
```

### Using Volumes

```bash
docker run -it -v <vol|host-filesystem>:<container-path> ubuntu
docker run -it -v app-data:/home/app <image>
```

## Sharing Source Code with Container (Development)

```bash
docker run -it -v $(pwd):<container-path> ubuntu
```

## Docker Copy

```bash
docker cp [OPTIONS] CONTAINER:SRC_PATH DEST_PATH|-
docker cp [OPTIONS] SRC_PATH | - CONTAINER:DEST_PATH
# Copy files/folders between a container and the local filesystem

docker cp path/to/file_or_directory_on_host container_name:path/to/file_or_directory_in_container
# Copy a file or directory from the host to a container:

docker cp container_name:path/to/file_or_directory_in_container path/to/file_or_directory_on_host
# Copy a file or directory from a container to the host:

docker cp --follow-link path/to/symlink_on_host container_name:path/to/file_or_directory_in_container
# Copy a file or directory from the host to a container, following symlinks.

cat archive.tar | docker cp - my_container:/path/in/container/
# Extract a tar archive from stdin into a container.

docker cp my_container:/path/in/container/ - | tar -xvf -
# Create a tar archive from a container and stream it to stdout.
```

## Shell Form vs Exec Form

- **Shell Form**:

  ```dockerfile
  COPY <source> <destination>
  ```

  - Uses the shell to execute the command, supports shell features.

- **Exec Form**:
  ```dockerfile
  COPY ["<source>", "<destination>"]
  ```
  - Directly executes the command as an array of arguments, preferred for clarity.

## Docker Compose

```bash
docker-compose build
docker-compose up
# Options:
# -d detach
# --no-cache                  do not use cache

docker-compose ps

docker-compose down
docker-compose down --rmi all                             # Remove all images
docker-compose down --rmi local                           # Safely remove each 'image' in turn
```

## Docker Network

```bash
docker run -it --network mynetwork ubuntu                # (by default bridge)
docker run -it --network host ubuntu                     # connect directly to host network
docker run -it --network none ubuntu                     # isolation

# Note:
# containers on the same network can communicate but will not connect to host. Use:
docker run -it -p <host-port>:<docker-bridge-port> <image>

docker network ls                                          # List existing networks
docker network create netName                              # Create a network
docker network rm netName                                  # Remove network
docker network inspect                                     # Show network details
docker network connect networkName containerName           # Connect container to a network
docker network disconnect networkName containerName        # Disconnect network from container
```

## Commit Docker Container

```bash
docker commit <container_id> <repository>:<tag>
```
