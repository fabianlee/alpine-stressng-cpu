# Summary
Alpine image with stress-ng installed

# Usage

There are three env vars that can be overridden:
  * nworkers - how many workers stress-ng uses
  * cpuload - 0=no load, 100=full cpu load
  * timeout - how many seconds to run test

sudo docker run -it --cpus=1.0 -e nworkers=1 -e cpuload=50 -e timeout=20 alpine-stressng


# Prerequisites
* make utility (sudo apt-get install make)


# Makefile targets
* docker-run (builds docker image, runs with 1 host cpu equiv, 50% load)
* docker-run-2cpu-50 (runs with 2 host cpu equiv, 50% load)
* docker-run-halfcpu-100 (runs with 1/2 host cpu equiv, 100% load)
* docker-run-2cpu-pinned100 (runs with 2 host cpu equiv, 100% load pinned to cpu 0 and 1)
