`ifndef LOG_SVH
`define LOG_SVH

`include "log_impl.svh"

`define LOG(level, tag, msg, file = `__FILE__, line = `__LINE__) \
    `LOG_IMPL(level, tag, msg, file, line)

`define LOG_VERBOSE(tag, msg) \
    `LOG_VERBOSE_IMPL(tag, msg)

`define LOG_DEBUG(tag, msg) \
    `LOG_DEBUG_IMPL(tag, msg)

`define LOG_INFO(tag, msg) \
    `LOG_INFO_IMPL(tag, msg)

`define LOG_WARN(tag, msg) \
    `LOG_WARN_IMPL(tag, msg)

`define LOG_ERROR(tag, msg) \
    `LOG_ERROR_IMPL(tag, msg)

`define LOG_FATAL(tag, msg) \
    `LOG_FATAL_IMPL(tag, msg)

`endif
