PROJECT := alpine-stressng-cpu
## the number of processors is returned by nproc utility
## can place better load if we know how many workers to use
NPROC := $(shell nproc)


docker-build: 
	sudo docker build -f Dockerfile -t $(PROJECT) .

clean:
	sudo docker stop $(PROJECT) >/dev/null 2>&1 | true
	sudo docker rm $(PROJECT) >/dev/null 2>&1 | true
	sudo docker image rm $(PROJECT) | true

docker-rm:
	## ignore errors when line begins with '-'
	sudo docker stop $(PROJECT) >/dev/null 2>&1 | true
	sudo docker rm $(PROJECT) >/dev/null 2>&1 | true

## no cpu limits, places 50% load across all host processors
docker-run: docker-rm docker-build
	@echo "------------------------------"
	@echo "There are $(NPROC) processors available, but using --cpu 0 which means all processors"
	@echo "------------------------------"
	sudo docker run -it -e nworkers=0 -e cpuload=50 -e timeout=20 $(PROJECT)

## limited to equivalent of 1 host cpu, spreads 50% load across all host cpu
docker-run-1cpu-50: 
	sudo docker run -it --cpus=1.0 -e cpuload=50 -e timeout=20 $(PROJECT)

## limited to equivalent of 2 host cpu, spreads 50% load across all host cpu
docker-run-2cpu-50: 
	sudo docker run -it --cpus=2.0 -e cpuload=50 -e timeout=20 $(PROJECT)

## limited to equivalent of 1/2 host cpu, spreads 100% load across all host cpu
docker-run-halfcpu-100:
	sudo docker run -it --cpus=0.5 -e cpuload=100 -e timeout=20 $(PROJECT)

## limited to equivalent of 2 host cpu, spreads 100% load pinned to cpu 0 and 1
docker-run-2cpu-pinned100:
	sudo docker run -it --cpus=2.0 --cpuset-cpus=0,1 -e cpuload=100 -e timeout=20 $(PROJECT)

