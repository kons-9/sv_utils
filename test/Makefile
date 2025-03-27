top: run_all_dummy run_all
	@echo "Done."
THIS_DIR:= $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
OUTDIR:=build

include $(THIS_DIR)/../Makefile.inc

DOCKER:=$(shell which docker)
DOCKER_IMAGE:=unprivileged_verilator
DOCKER_IMAGE_TAG:=latest
DOCKER_FLAGS:=--rm -u $(shell id -u):$(shell id -g) \
			  -w $(THIS_DIR) \
			  -v $(SV_UTILS_PROJECT_ROOT):$(SV_UTILS_PROJECT_ROOT)

VERILATOR_VERSION_RELATED_FLAGS:=--quiet --assert --trace
VERILATOR_FLAGS:= -sv -MMD $(VERILATOR_VERSION_RELATED_FLAGS)
VERILATOR_WARNINGS?=-Wall -Wno-PINCONNECTEMPTY -Wno-UNUSED -Wno-WIDTH -Wno-SELRANGE -Wno-DECLFILENAME
VERILATOR_OPTIMIZATION_FLAG?=-O3

ifdef USING_VERILATOR_CPP
VERILATOR_CPP_TESTBENCH_FLAG?=-exe --cc
VERILATOR_FLAGS+=$(VERILATOR_OPTIMIZATION_FLAG) $(VERILATOR_WARNINGS) $(VERILATOR_CPP_TESTBENCH_FLAG)
else
VERILATOR_SV_TESTBENCH_FLAG?=--timing --binary --main
VERILATOR_FLAGS+=$(VERILATOR_OPTIMIZATION_FLAG) $(VERILATOR_WARNINGS) $(VERILATOR_SV_TESTBENCH_FLAG)
endif

VERILATOR_FLAGS+= -Mdir $(OUTDIR)

run_all_dummy: run_dummy_color run_dummy_log run_dummy_sv_test
run_all: run_color run_log run_sv_test

run_dummy_color: build/Vtb_dummy_color
	cd $(OUTDIR) && ./Vtb_dummy_color

run_color: build/Vtb_color
	cd $(OUTDIR) && ./Vtb_color

run_dummy_log: build/Vtb_dummy_log
	cd $(OUTDIR) && ./Vtb_dummy_log

run_log: build/Vtb_log
	cd $(OUTDIR) && ./Vtb_log

run_dummy_sv_test: build/Vtb_dummy_sv_test
	cd $(OUTDIR) && ./Vtb_dummy_sv_test

run_sv_test: build/Vtb_sv_test
	cd $(OUTDIR) && ./Vtb_sv_test

$(OUTDIR)/Vtb_dummy_%: tb_%.sv $(SV_UTILS_DUMMY_FILES) $(SV_UTILS_TOP_FILES)
	$(DOCKER) run $(DOCKER_FLAGS) $(DOCKER_IMAGE):$(DOCKER_IMAGE_TAG) \
		$(VERILATOR_FLAGS) \
		$(SV_UTILS_DUMMY_INCLUDE) \
		--top-module tb_$* \
		$(THIS_DIR)/tb_$*.sv \
		-o Vtb_dummy_$*

$(OUTDIR)/V%: %.sv $(SV_UTILS_SV_FILES) $(SV_UTILS_TOP_FILES)
	$(DOCKER) run $(DOCKER_FLAGS) $(DOCKER_IMAGE):$(DOCKER_IMAGE_TAG) \
		$(VERILATOR_FLAGS) \
		$(SV_UTILS_SV_INCLUDE) \
		--top-module $* \
		$(THIS_DIR)/$*.sv

clean:
	rm -rf $(OUTDIR)
