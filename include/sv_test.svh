`ifndef SV_TEST_SVH
`define SV_TEST_SVH

`include "sv_test_impl.svh"

// interface

`define TEST_SECTION_START(section_name) \
    `TEST_SECTION_START_IMPL(section_name);

`define TEST_START(test_log_path) \
    `TEST_START_IMPL(test_log_path)

`define TEST_EXPECTED(expected, actual, message, file = `__FILE__, line = `__LINE__) \
    `TEST_EXPECTED_IMPL(expected, actual, message, file, line)

`define TEST_UNEXPECTED(unexpected, actual, message, file = `__FILE__, line = `__LINE__) \
    `TEST_UNEXPECTED_IMPL(unexpected, actual, message, file, line)

`define TEST_RESULT() \
    `TEST_RESULT_IMPL()

`endif
