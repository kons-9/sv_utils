`ifndef LOG_IMPL_SVH
`define LOG_IMPL_SVH

`include "color.svh"

package log_impl;
    typedef enum int {
        LOG_LEVEL_VERBOSE = 0,
        LOG_LEVEL_DEBUG = (LOG_LEVEL_VERBOSE + 1),
        LOG_LEVEL_INFO = (LOG_LEVEL_DEBUG + 1),
        LOG_LEVEL_WARN = (LOG_LEVEL_INFO + 1),
        LOG_LEVEL_ERROR = (LOG_LEVEL_WARN + 1),
        LOG_LEVEL_FATAL = (LOG_LEVEL_ERROR + 1)
    } log_level_t;

    parameter log_level_t LOG_LEVEL = LOG_LEVEL_INFO;
    
    function automatic string get_log_level_name(log_level_t level);
        case (level)
            LOG_LEVEL_VERBOSE: get_log_level_name = "VERBOSE";
            LOG_LEVEL_DEBUG: get_log_level_name = "DEBUG";
            LOG_LEVEL_INFO: get_log_level_name = "INFO";
            LOG_LEVEL_WARN: get_log_level_name = "WARN";
            LOG_LEVEL_ERROR: get_log_level_name = "ERROR";
            LOG_LEVEL_FATAL: get_log_level_name = "FATAL";
            default: get_log_level_name = "UNKNOWN";
        endcase
    endfunction

    task automatic print_log(log_level_t level, string tag, string msg, string file, int line);
        // Usage: LOG_INFO("message_tag", "message %d", 1); // => [time] [module_name] [message_tag] message 1
        if (LOG_LEVEL <= level) begin
            if (tag == "")
                $display("%0t [%m] %s [%s:%0d] [%s]", $time, msg, file, line, get_log_level_name(level));
            else
                $display("(%0t) [%m] [%s] %s [%s:%0d] [%s]", $time, tag, msg, file, line, get_log_level_name(level));
        end
    endtask

    task automatic print_color_log(log_level_t level);
        unique case (level)
            LOG_LEVEL_VERBOSE: begin
                `GRAY_COLOR;
            end
            LOG_LEVEL_DEBUG: begin
                `WHITE_COLOR;
            end
            LOG_LEVEL_INFO: begin
                `GREEN_COLOR;
            end
            LOG_LEVEL_WARN: begin
                `YELLOW_COLOR;
            end
            LOG_LEVEL_ERROR: begin
                `RED_COLOR;
            end
            LOG_LEVEL_FATAL: begin
                `RED_COLOR;
            end
        endcase
    endtask

endpackage

`define LOG_IMPL(level, tag, msg, file = `__FILE__, line = `__LINE__) \
    log_impl::print_color_log(level); \
    log_impl::print_log(level, tag, msg, file, line); \
    `RESET_COLOR;

// use macro because it use file and line
`define LOG_VERBOSE_IMPL(tag, msg) \
    `LOG_IMPL(log_impl::LOG_LEVEL_VERBOSE, tag, msg);

`define LOG_DEBUG_IMPL(tag, msg) \
    `LOG_IMPL(log_impl::LOG_LEVEL_DEBUG, tag, msg);

`define LOG_INFO_IMPL(tag, msg) \
    `LOG_IMPL(log_impl::LOG_LEVEL_INFO, tag, msg);

`define LOG_WARN_IMPL(tag, msg) \
    `LOG_IMPL(log_impl::LOG_LEVEL_WARN, tag, msg);

`define LOG_ERROR_IMPL(tag, msg) \
    `LOG_IMPL(log_impl::LOG_LEVEL_ERROR, tag, msg);

`define LOG_FATAL_IMPL(tag, msg) \
    `LOG_IMPL(log_impl::LOG_LEVEL_FATAL, tag, msg); \
    exit_impl::fatal_exit();

`endif
