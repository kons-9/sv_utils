`include "log.svh"
`include "log.svh"

`include "sv_test.svh"
`include "exit.svh"

module tb_log;
    initial begin
        `TEST_START("tb_log.log");
        `DISABLE_FATAL_EXIT
        `LOG_VERBOSE("verbose_tag", "verbose");
        `LOG_DEBUG("debug_tag", "debug");
        `LOG_INFO("info_tag", "info");
        `LOG_WARN("warn_tag", "warn");
        `LOG_ERROR("error_tag", "error");
        `LOG_FATAL("fatal_tag", "fatal");
        `TEST_RESULT();
    end
endmodule
