`include "color.svh"
`include "color.svh"

`include "sv_test.svh"

module tb_color;
    initial begin
        `TEST_START("tb_color.log");

        `BLACK_COLOR
        $display("BLACK_COLOR");
        `RESET_COLOR

        `RED_COLOR
        $display("RED_COLOR");
        `RESET_COLOR

        `GREEN_COLOR
        $display("GREEN_COLOR");
        `RESET_COLOR

        `YELLOW_COLOR
        $display("YELLOW_COLOR");
        `RESET_COLOR

        `BLUE_COLOR
        $display("BLUE_COLOR");
        `RESET_COLOR

        `MAGENTA_COLOR
        $display("MAGENTA_COLOR");
        `RESET_COLOR

        `CYAN_COLOR
        $display("CYAN_COLOR");
        `RESET_COLOR

        `WHITE_COLOR
        $display("WHITE_COLOR");
        `RESET_COLOR

        `GRAY_COLOR
        $display("GRAY_COLOR");
        `RESET_COLOR

        `BLACK_COLOR
        `GRAY_COLOR
        `WHITE_COLOR
        `BLUE_COLOR
        $display("BLUE_COLOR");
        `RESET_COLOR
        $display("NON COLOR");

        `TEST_RESULT();
    end
endmodule
