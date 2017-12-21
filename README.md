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

## Neverwinter Nights Enhanced Edition NWNX Docker Image

This project provides a Docker multistage build that adds the NWNX binaries to a nwserver docker image

#### Docker Multistage build

The Docker Multistage build executes the following:

* Passes arguments to specify the following:
    * NWN_VERSION - head start version
    * NWN_TAG - Image tag of the dedicated server base image
    * NWN_VERSION_SUFFIX - If needed a suffix that is appended to the NWN_VERSION if needed to identify the base image
* Creates a builder image that downloads the NWNX bineries for the specified version and unpacks them
* Creates the main imagefrom the specified dedicated server base image
* Copies the unpacked NWNX files from the builder image
* Copies the required start stcipts
* Sets environment variables and permissions
* Sets the startup command

Example
`docker build -t glorwinger/nwserver:8152.bd.i386.nwnx --build-arg NWN_VERSION=8152 --build-arg NWN_TAG=glorwinger/nwserver --build-arg NWN_VERSION_SUFFIX=.bd.i386 . -f Dockerfile`

