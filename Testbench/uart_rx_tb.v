
module uart_rx_tb;

reg clk;
reg rst;
reg rx;

wire [7:0] rx_data;
wire rx_done;

uart_rx #(.CLKS_PER_BIT(4)) uut (
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .rx_data(rx_data),
    .rx_done(rx_done)
);

always #5 clk = ~clk;

initial begin
    $dumpfile("uart_rx.vcd");
    $dumpvars(0, uart_rx_tb);

    clk = 0;
    rst = 1;
    rx = 1;

    #20 rst = 0;

    // Test byte 1
    send_byte(8'b10101010);
    #20;

    if (rx_data == 8'b10101010) begin
        $display("TEST 1 PASSED: Expected=10101010 Received=%b", rx_data);
    end
    else begin
        $display("TEST 1 FAILED: Expected=10101010 Received=%b", rx_data);
    end

    // Test byte 2
    send_byte(8'b11001100);
    #20;

    if (rx_data == 8'b11001100) begin
        $display("TEST 2 PASSED: Expected=11001100 Received=%b", rx_data);
    end
    else begin
        $display("TEST 2 FAILED: Expected=11001100 Received=%b", rx_data);
    end

    // Test byte 3
    send_byte(8'b11110000);
    #20;

    if (rx_data == 8'b11110000) begin
        $display("TEST 3 PASSED: Expected=11110000 Received=%b", rx_data);
    end
    else begin
        $display("TEST 3 FAILED: Expected=11110000 Received=%b", rx_data);
    end

    $display("================================");
    $display("       UART RX TEST COMPLETE    ");
    $display("================================");

    $finish;
end


task send_byte(input [7:0] data);
begin
    // Start bit
    rx = 0;
    #40;

    // Data bits - LSB first
    rx = data[0];
    #40;

    rx = data[1];
    #40;

    rx = data[2];
    #40;

    rx = data[3];
    #40;

    rx = data[4];
    #40;

    rx = data[5];
    #40;

    rx = data[6];
    #40;

    rx = data[7];
    #40;

    // Stop bit
    rx = 1;
    #40;
end
endtask
always @(posedge clk) begin
    $display("Time=%0t rx=%b rx_data=%b rx_done=%b bit_index=%0d",
             $time, rx, rx_data, rx_done, uut.bit_index);
end

endmodule

    