package exit_impl;
    bit enable_fatal = 1;

    task automatic verilator_compatible_exit(bit status = 0);
        $finish(status);
        if (status)
            $c("exit(1);");
        else
            $c("exit(0);");
    endtask

    task automatic fatal_exit();
        if (enable_fatal)
            $fatal;
    endtask
endpackage

`define DISABLE_FATAL_EXIT_IMPL \
    exit_impl::enable_fatal = 0;
