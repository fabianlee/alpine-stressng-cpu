FROM alpine:latest

RUN apk update
RUN apk add stress-ng

# how many workers to start
ENV nworkers=1

# how much load to put on processor (0=none,100=full load)
ENV cpuload=50

# number of seconds to place load on system
ENV timeout=15

# using shell version of CMD so env vars can be overridden (-e)
CMD echo going to use nworkers=${nworkers} to place load=${cpuload} for timeout=${timeout} seconds && stress-ng --cpu ${nworkers} --cpu-method all --cpu-load ${cpuload} --timeout ${timeout}

