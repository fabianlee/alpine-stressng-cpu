OWNER := fabianlee
PROJECT := alpine-stressng-cpu
VERSION := 1.0.0
OPV := $(OWNER)/$(PROJECT):$(VERSION)

# builds docker image
docker-build:
	sudo docker build -f Dockerfile -t $(OPV) .

## cleans docker image
clean:
	sudo docker image rm $(OPV) | true

## runs container in foreground, using default args
docker-test:
	sudo docker run -it --rm $(OPV)

## runs container in foreground, override entrypoint to use use shell
docker-test-cli:
	sudo docker run -it --rm --entrypoint "/bin/sh" $(OPV)

## no cpu limits, places 50% load across all host processors
docker-run: 
	sudo docker run -it --rm -e nworkers=0 -e cpuload=50 -e timeout=20 $(OPV)

## limited to equivalent of 1 host cpu, spreads 50% load across all host cpu
docker-run-1cpu-50: 
	sudo docker run -it --rm --cpus=1.0 -e cpuload=50 -e timeout=20 $(OPV)

## limited to equivalent of 2 host cpu, spreads 50% load across all host cpu
docker-run-2cpu-50: 
	sudo docker run -it --rm --cpus=2.0 -e cpuload=50 -e timeout=20 $(OPV)

## limited to equivalent of 1/2 host cpu, spreads 100% load across all host cpu
docker-run-halfcpu-100:
	sudo docker run -it --rm --cpus=0.5 -e cpuload=100 -e timeout=20 $(OPV)

## limited to equivalent of 2 host cpu, spreads 100% load pinned to cpu 0 and 1
docker-run-2cpu-pinned100:
	sudo docker run -it --rm --cpus=2.0 --cpuset-cpus=0,1 -e cpuload=100 -e timeout=20 $(OPV)

## pushes to docker hub
docker-push:
	sudo docker push $(OPV)
