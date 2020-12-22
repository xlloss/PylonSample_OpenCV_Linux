PKG_CONF=/home/slash/i.mx8_dir/src/imx8mp/sdk/toolchain/sysroots/x86_64-pokysdk-linux/usr/bin/pkg-config

# Makefile for Basler pylon sample program
.PHONY: all clean

# The program to build
NAME       := openCVGrab

# Installation directories for pylon
PYLON_ROOT ?= /opt/pylon_arm64

# Build tools and flags
LD         := $(CXX)
CPPFLAGS   := $(shell $(PYLON_ROOT)/bin/pylon-config --cflags) $(shell $(PKG_CONF) opencv4 --cflags)
CXXFLAGS   := #e.g., CXXFLAGS=-g -O0 for debugging
LDFLAGS    := $(shell $(PYLON_ROOT)/bin/pylon-config --libs-rpath)
LDLIBS     := $(shell $(PYLON_ROOT)/bin/pylon-config --libs) $(shell $(PKG_CONF) opencv4 --libs-only-L) $(shell $(PKG_CONF) opencv4 --libs-only-l)

# Rules for building
all: $(NAME)

$(NAME): $(NAME).o
	$(LD) $(LDFLAGS) -o $@ $^ $(LDLIBS)

$(NAME).o: $(NAME).cpp
	$(CXX) $(CPPFLAGS) $(CXXFLAGS)  -O2 -c -o $@ $<

clean:
	$(RM) $(NAME).o $(NAME)
