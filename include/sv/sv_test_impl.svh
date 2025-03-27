`ifndef SV_TEST_IMPL_SVH
`define SV_TEST_IMPL_SVH

`include "color.svh"
`include "exit.svh"

package sv_test_impl;
    typedef struct {
        int passed_count;
        int failed_count;
        int skipped_count;

        bit test_section_valid;
        string test_section_name;

        bit test_section_skip_flag;

        string test_log_path;
        int fd;
    } test_context_t;

    bit test_context_valid = 0;
    test_context_t test_context;

    task automatic initialize_context();
        if (test_context_valid) begin
            deinitalize_context();
        end
        test_context.passed_count = 0;
        test_context.failed_count = 0;
        test_context.skipped_count = 0;
        test_context.test_section_name = "";
        test_context.test_section_valid = 0;
        test_context.test_log_path = "";
        test_context.fd = 0;

        test_context_valid = 1;
    endtask
    task automatic deinitalize_context();
        if (test_context_valid) begin
            $fclose(test_context.fd);
        end
        test_context_valid = 0;
    endtask

    task automatic test_start(string log_path);
        initialize_context();

        test_context.test_log_path = log_path;
        test_context.fd = $fopen(test_context.test_log_path, "w");
        `GREEN_COLOR
        $display("Test Start: %0s", test_context.test_log_path);
        `RESET_COLOR
    endtask

    task automatic test_result();
        if (test_context.failed_count > 0) begin
            `RED_COLOR
            $display("Test Failed: passed = %0d, failed = %0d, skipped = %0d",
                     test_context.passed_count, test_context.failed_count,
                     test_context.skipped_count);
            $fwrite(test_context.fd, "Test Failed: passed = %0d, failed = %0d, skipped = %0d\n",
                    test_context.passed_count, test_context.failed_count,
                    test_context.skipped_count);
            pre_exit();
            exit_impl::fatal_exit();
        end else begin
            `GREEN_COLOR
            $display("Test Passed\n");
            $fwrite(test_context.fd, "Test Passed\n");
            pre_exit();
            exit_impl::verilator_compatible_exit();
        end
    endtask

    task automatic pre_exit();
        `RESET_COLOR
        deinitalize_context();
    endtask

    task automatic test_section_start(string section_name);
        test_context.test_section_name = section_name;
        test_context.test_section_valid = 1;
        test_context.test_section_skip_flag = 0;
    endtask

    task automatic test_common(bit is_failed, string error_message);
        if (test_context.test_section_valid && test_context.test_section_skip_flag) begin
            test_context.skipped_count++;
            return;
        end

        if (!is_failed) begin
            test_context.passed_count++;
            return;
        end

        test_context.failed_count++;
        test_context.test_section_skip_flag = 1;
        `RED_COLOR
        $display("%s", error_message);
        `RESET_COLOR

        $fwrite(test_context.fd, "%s\n", error_message);
    endtask

    task automatic test_expected(bit is_expected_failed, string expected_str, string actual_str,
                                 string message, string file, int line);
        string section_str = "";

        if (test_context.test_section_valid) begin
            section_str = $sformatf("[%s] ", test_context.test_section_name);
        end
        test_common(is_expected_failed, $sformatf(
                    "%sError: %s, expected = %s, actual = %s(file:%0s line:%0d)",
                    section_str,
                    message,
                    expected_str,
                    actual_str,
                    file,
                    line
                    ));
    endtask

    task automatic test_unexpected(bit is_unexpected_failed, string unexpected_str,
                                   string actual_str, string message, string file, int line);
        string section_str = "";

        if (test_context.test_section_valid) begin
            section_str = $sformatf("[%s] ", test_context.test_section_name);
        end
        test_common(is_unexpected_failed, $sformatf(
                    "%sError: %s, unexpected = %s, actual = %s(file:%0s line:%0d)",
                    section_str,
                    message,
                    unexpected_str,
                    actual_str,
                    file,
                    line
                    ));
    endtask

endpackage

`define TEST_SECTION_START_IMPL(section_name) \
    sv_test_impl::test_section_start(section_name);

`define TEST_START_IMPL(log_path) \
    sv_test_impl::test_start(log_path);

`define TEST_EXPECTED_IMPL(expected, actual, message, file = `__FILE__,
                           line = `__LINE__) \
    sv_test_impl::test_expected(expected != actual, $sformatf("%0h", expected), $sformatf("%0h", actual), message, file, line);

`define TEST_UNEXPECTED_IMPL(unexpected, actual, message, file = `__FILE__,
                             line = `__LINE__) \
    sv_test_impl::test_unexpected(unexpected == actual, $sformatf("%0h", unexpected), $sformatf("%0h", actual), message, file, line);

`define TEST_RESULT_IMPL() \
    sv_test_impl::test_result();

`endif
