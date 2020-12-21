# Makefile for Basler pylon sample program
.PHONY: all clean

# The program to build
NAME       := openCVGrab

# Installation directories for pylon
PYLON_ROOT ?= /opt/pylon

# Build tools and flags
LD         := $(CXX)
CPPFLAGS   := $(shell $(PYLON_ROOT)/bin/pylon-config --cflags) -I/media/slash/500G/opencv/installation/OpenCV-3.4.8/include
CXXFLAGS   := #e.g., CXXFLAGS=-g -O0 for debugging
LDFLAGS    := $(shell $(PYLON_ROOT)/bin/pylon-config --libs-rpath)
LDLIBS     := $(shell $(PYLON_ROOT)/bin/pylon-config --libs) -L/media/slash/500G/opencv/installation/OpenCV-3.4.8/lib/ -lopencv_core -lopencv_highgui -lopencv_imgcodecs -lopencv_imgproc

# Rules for building
all: $(NAME)

$(NAME): $(NAME).o
	$(LD) $(LDFLAGS) -o $@ $^ $(LDLIBS)

$(NAME).o: $(NAME).cpp
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<

clean:
	$(RM) $(NAME).o $(NAME)
