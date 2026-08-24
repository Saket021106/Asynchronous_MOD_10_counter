`timescale 1ns/1ps

module tb_async_mod_10_counter;

    reg clk;
    wire [3:0] Q;

    async_mod_10_counter dut (
        .clk(clk),
        .Q(Q)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_async_mod_10_counter);

        $display("-------------------MOD_10_COUNTER-------------------");
        $monitor("Time = %3d, Dec = %2d, Bin = %b", $time, Q, Q);
        #200;

        $finish;
    end

endmodule
