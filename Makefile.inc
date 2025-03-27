ifndef SV_UTILS
SV_UTILS=1

SV_UTILS_PROJECT_ROOT:=$(shell git rev-parse --show-toplevel)

SV_UTILS_DUMMY_INCLUDE:=-I$(SV_UTILS_PROJECT_ROOT)/include -I$(SV_UTILS_PROJECT_ROOT)/include/dummy
SV_UTILS_SV_INCLUDE:=-I$(SV_UTILS_PROJECT_ROOT)/include -I$(SV_UTILS_PROJECT_ROOT)/include/sv

SV_UTILS_DUMMY_FILES:=$(shell find $(SV_UTILS_PROJECT_ROOT)/include/dummy -name "*.svh")
SV_UTILS_SV_FILES:=$(shell find $(SV_UTILS_PROJECT_ROOT)/include/sv -name "*.svh")
SV_UTILS_TOP_FILES:=$(shell find $(SV_UTILS_PROJECT_ROOT)/include -name "*.svh" | grep -v "include/dummy/" | grep -v "include/sv/")

endif


