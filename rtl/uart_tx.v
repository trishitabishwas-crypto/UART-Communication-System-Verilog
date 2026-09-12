module uart_tx (
    input wire clk,
    input wire rst,
    input wire tx_start,
    input wire [7:0] tx_data,
    output reg tx,
    output reg tx_busy
);

parameter CLKS_PER_BIT = 5208;

reg [7:0] data_reg;
reg [15:0] clk_count;
reg [3:0] bit_index;

always @(posedge clk) begin

    if (rst) begin
        tx <= 1;
        tx_busy <= 0;
        data_reg <= 0;
        clk_count <= 0;
        bit_index <= 0;
    end

    else if (tx_start && !tx_busy) begin
        data_reg <= tx_data;
        tx_busy <= 1;
        tx <= 0;
        bit_index <= 0;
        clk_count <= 0;
    end

    else if (tx_busy) begin

        if (clk_count < CLKS_PER_BIT - 1) begin
            clk_count <= clk_count + 1;
        end

        else begin
            clk_count <= 0;

            if (bit_index < 8) begin
                tx <= data_reg[bit_index];
                bit_index <= bit_index + 1;
            end

            else begin
                tx <= 1;
                tx_busy <= 0;
            end
        end
    end
end

endmodule