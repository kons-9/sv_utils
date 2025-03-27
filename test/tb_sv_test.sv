`include "sv_test.svh"
`include "sv_test.svh"

`include "exit.svh"

module tb_sv_test;
    initial begin
        `TEST_START("tb_sv_test.log");
        `DISABLE_FATAL_EXIT

        `TEST_SECTION_START("test_section_1");
        begin
            `TEST_EXPECTED(1, 1, "1 == 1");
            `TEST_UNEXPECTED(1, 2, "1 != 2");
        end

        `TEST_SECTION_START("test_section_2");
        begin
            `TEST_EXPECTED(1, 1, "1 == 1");
            `TEST_UNEXPECTED(1, 1, "1 != 1"); // failed
            `TEST_EXPECTED(1, 1, "1 == 1");  // This line should be skipped
        end

        `TEST_RESULT();
    end
endmodule
