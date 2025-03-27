`ifndef COLOR_IMPL_SVH
`define COLOR_IMPL_SVH

`define BLACK_COLOR_IMPL $write("\033[30m");
`define RED_COLOR_IMPL $write("\033[31m");
`define GREEN_COLOR_IMPL $write("\033[32m");
`define YELLOW_COLOR_IMPL $write("\033[33m");
`define BLUE_COLOR_IMPL $write("\033[34m");
`define MAGENTA_COLOR_IMPL $write("\033[35m");
`define CYAN_COLOR_IMPL $write("\033[36m");
`define WHITE_COLOR_IMPL $write("\033[37m");
`define GRAY_COLOR_IMPL $write("\033[90m");
`define RESET_COLOR_IMPL $write("\033[0m");

`endif
