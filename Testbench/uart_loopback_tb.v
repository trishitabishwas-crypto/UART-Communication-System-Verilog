module uart_loopback_tb;

reg clk;
reg rst;
reg tx_start;
reg [7:0] tx_data;

wire tx;
wire tx_busy;
wire [7:0] rx_data;
wire rx_done;

uart_tx #(.CLKS_PER_BIT(4)) tx_inst (
    .clk(clk),
    .rst(rst),
    .tx_start(tx_start),
    .tx_data(tx_data),
    .tx(tx),
    .tx_busy(tx_busy)
);

uart_rx #(.CLKS_PER_BIT(4)) rx_inst (
    .clk(clk),
    .rst(rst),
    .rx(tx),
    .rx_data(rx_data),
    .rx_done(rx_done)
);

always #5 clk = ~clk;

task send_byte;
    input [7:0] data;
    begin
        tx_data = data;
        tx_start = 1;

        #10;
        tx_start = 0;

        // Wait for this byte to finish
        #400;
    end
endtask

initial begin
    $dumpfile("uart_loopback.vcd");
    $dumpvars(0, uart_loopback_tb);

    clk = 0;
    rst = 1;
    tx_start = 0;
    tx_data = 8'b0;

    #20;
    rst = 0;

    // =========================
    // TEST 1
    // =========================
    send_byte(8'b10101010);

    $display("TEST 1");
    $display("Expected : 10101010");
    $display("Received : %b", rx_data);

    if (rx_data == 8'b10101010)
        $display("PASS");
    else
        $display("FAIL");

    // =========================
    // TEST 2
    // =========================
    send_byte(8'b11001100);

    $display("TEST 2");
    $display("Expected : 11001100");
    $display("Received : %b", rx_data);

    if (rx_data == 8'b11001100)
        $display("PASS");
    else
        $display("FAIL");

    // =========================
    // TEST 3
    // =========================
    send_byte(8'b11110000);

    $display("TEST 3");
    $display("Expected : 11110000");
    $display("Received : %b", rx_data);

    if (rx_data == 8'b11110000)
        $display("PASS");
    else
        $display("FAIL");

    $display("================================");
    $display("      UART LOOPBACK COMPLETE    ");
    $display("================================");

    $finish;
end

endmodule