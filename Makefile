obj-m		:= fliusb.o

KDIR		?= /lib/modules/$(shell uname -r)/build
PWD		:= $(shell pwd)

EXTRA_CFLAGS		+= -O2 -Wall

#EXTRA_CFLAGS		+= -DDEBUG	# enable debug messages
#EXTRA_CFLAGS		+= -DASYNCWRITE	# enable asynchronous writes
# This flag cannot be set because of the deprecation of init_time function in linux.
# see this comment https://github.com/the-dagger/RaLink-RT3290-Drivers-Ubuntu/issues/1#issuecomment-453875155
#EXTRA_CFLAGS		+= -DSGREAD	# enable scatter-gather reads

all: module cleanup

module:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules

cleanup:
	rm -f *.o .*.cmd *.mod.c; rm -rf .tmp_versions

clean: cleanup
	rm -f *.ko test
