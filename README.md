## Neverwinter Nights Enhanced Edition Docker Image

This project provides two ways to build the docker image.  One involves running a script that will download and unpack the dedicated seever, the other uses a Docker multistage build.

#### Docker Multistage build

The Docker Multistage build executes the following:

* Passes an argument NWN_VERSION that represents the head start version
* Creates a builder image that downloads the dedicated server version and unpacks it
* Creates the main image
* Copies the unpacked dedicated server files from the builder image
* Copies the required start stcipts
* Sets environment variables and permissions
* Sets the startup command

Example

`docker build -t nwserver:8152 --build-arg NWN_VERSION=8152 . -f Dockerfile.multistage`

#### Docker Single Stage build

The Docker Single Stage build executes the following:

* Execute script to pull and unpack the dedicated server into a folder (nwserver)
* Execute Docker build
	* Creates the main image
	* Copies the unpacked dedicated server files from the nwserver folder
	* Copies the required start stcipts
	* Sets environment variables and permissions
	* Sets the startup command

Example

`./scripts/get-nwserver.sh 8152`

`docker build -t nwserver:8152  . -f Dockerfile`