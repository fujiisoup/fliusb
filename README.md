# Patched fliusb-1.3.2

## About 
This repository is meant to share the software driver for FLI camera patched for linux kernel 4.15.
See http://www.flicamera.com/software/index.html for the details.

## Original README

This directory contains a native driver for FLI USB devices that
should work with any Linux 2.6.x kernel.  The driver creates a
character special file /dev/fliusbi<i>, where i=0,1,2... is the device
number, when a recognized FLI USB device is attached.  The character
special file provides two ways to communicate with FLI USB devices;
through read()/write() system calls or by using ioctl().

Compiling
=========

Use the make command to compile the driver.  This will create the
kernel module fliusb.ko that can then be loaded using the insmod
command.

Compile Options
===============

Compile-time options are controlled by defining the following
preprocessor macros: DEBUG, ASYNCWRITE, and SGREAD.  Each option is
briefly described below.

DEBUG		This option makes the driver more verbose and causes
		it to print a basic description of what it's doing as
		various operations are performed.  This has a negative
		impact on performance but might be useful for
		debugging purposes.

ASYNCWRITE	This enables asynchronous bulk write transfers.  All
		bulk writes will return before any data is actually
		transfered to the FLI USB device.  This makes the
		application unaware of any errors that occur during
		the transfer, although they are logged by the driver.
		Applications will only detect problems with a
		subsequent bulk read attempt.

SGREAD		This allows scatter-gather bulk read transfers.  Bulk
		reads whose size exceeds the size of the driver buffer
		(see the buffersize module parameter below) are done
		with a scatter-gather transfer directly into the
		provided user-space buffer.  The user-space buffer
		must be aligned to a multiple of the endpoint's
		maximum packet size, for example by having the
		application pass a page-aligned buffer.

Module Parameters
=================

buffersize 	The default size of the driver buffer (per FLI USB
		device).  This also acts as the threshold for when
		scatter-gather reads are done, if enabled.

timeout		The default timeout, in milliseconds, for read() and
		write() system calls (ignored by asynchronous writes).

ioctl() Commands
================

The supported ioctl() commands are defined in fliusb_ioctl.h.
Parameters for each command are passed by pointer using the third
argument to the ioctl() system call.  See fliusb_ioctl.h for the
pointer type each command expects.  The commands listed below are
recognized.

FLIUSB_GETRDEPADDR		Get the current USB endpoint address
				used when a read() is performed.

FLIUSB_SETRDEPADDR		Set the USB endpoint address used when
				a read() is performed.

FLIUSB_GETWREPADDR		Get the current USB endpoint address
				used when a write() is performed.

FLIUSB_SETWREPADDR 		Set the USB endpoint address used when
				a write() is performed.

FLIUSB_GETBUFFERSIZE		Get the current buffer size.

FLIUSB_SETBUFFERSIZE		Set the buffer size.

FLIUSB_GETTIMEOUT		Get the current timeout, in milliseconds.

FLIUSB_SETTIMEOUT		Set the current timeout, in milliseconds.

FLIUSB_BULKREAD			Perform a bulk read.

FLIUSB_BULKWRITE		Perform a bulk write.

FLIUSB_GET_DEVICE_DESCRIPTOR	Get the USB device descriptor.
