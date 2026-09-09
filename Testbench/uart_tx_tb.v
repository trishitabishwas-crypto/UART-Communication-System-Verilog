module uart_tx_tb;

reg clk;
reg rst;
reg tx_start;
reg [7:0] tx_data;

wire tx;
wire tx_busy;

uart_tx #(.CLKS_PER_BIT(4)) uut (

    .clk(clk),
    .rst(rst),
    .tx_start(tx_start),
    .tx_data(tx_data),
    .tx(tx),
    .tx_busy(tx_busy)
);
always #5 clk = ~clk;
initial begin
    $dumpfile("uart_tx.vcd");
    $dumpvars(0, uart_tx_tb);
    clk = 0;
    rst = 1;
tx_start = 0;
#20 rst = 0;
tx_data = 8'b10101010;
#10 tx_start = 1;
#10 tx_start = 0;

#500 $finish;
end
endmodule