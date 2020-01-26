FROM alpine:latest

RUN apk update \
	&& apk add stress-ng

# how many workers to start
# 0 means the count will match how many cpu are present
ENV nworkers=0

# how much load to put on processor (0=none,100=full load)
ENV cpuload=50

# number of seconds to place load on system
ENV timeout=15

# using shell version of CMD so env vars can be overridden (-e)
CMD echo going to use nworkers=${nworkers} to place load=${cpuload} for timeout=${timeout} seconds && stress-ng --cpu ${nworkers} --cpu-method all --cpu-load ${cpuload} --timeout ${timeout}

