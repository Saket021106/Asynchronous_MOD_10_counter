module async_mod_10_counter (
    input clk,
    output [3:0] Q
);

    logic high = 1'b1;
    genvar i;

    wire res = ~(Q[3] & Q[1]);

    generate
        for(i = 0; i < 4; i = i + 1) begin : jk_chain
            if(i == 0) begin
                jk_ff JK (
                    .clk(clk),
                    .j(high),
                    .k(high),
                    .q(Q[i]),
                    .res(res)
                );
            end else begin
                jk_ff JK (
                    .clk(~Q[i-1]),
                    .j(high),
                    .k(high),
                    .q(Q[i]),
                    .res(res)
                );
            end
        end
    endgenerate

endmodule

module jk_ff (
    input clk,
    input res,
    input j,
    input k,
    output reg q = 1'b0
);

    always @(posedge clk or negedge res) begin
        if(!res) begin
            q <= 1'b0;
        end else begin
            case ({j, k})
                2'b00 : q <= q;
                2'b01 : q <= 1'b0;
                2'b10 : q <= 1'b1;
                2'b11 : q <= ~q;
            endcase
        end
    end

endmodule
