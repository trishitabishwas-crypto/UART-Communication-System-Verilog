
module uart_rx (

    input  wire clk,
    input  wire rst,
    input  wire rx,

    output reg [7:0] rx_data,
    output reg rx_done

);

parameter CLKS_PER_BIT = 4;

reg [15:0] clk_count;
reg [3:0]  bit_index;
reg [7:0]  data_reg;

reg receiving;

always @(posedge clk) begin

    if (rst) begin

        clk_count <= 0;
        bit_index <= 0;
        data_reg  <= 0;
        rx_data   <= 0;
        rx_done   <= 0;
        receiving <= 0;

    end

    else begin

        rx_done <= 0;

        // Detect start bit
        if (!receiving && rx == 0) begin

            receiving <= 1;
            clk_count <= 0;
            bit_index <= 0;

        end

        // Receive data
        else if (receiving) begin

            if (clk_count < CLKS_PER_BIT - 1) begin

                clk_count <= clk_count + 1;

            end

            else begin

                clk_count <= 0;

                if (bit_index < 8) begin

                    data_reg[bit_index] <= rx;
                    bit_index <= bit_index + 1;

                end

                else begin

                    // Stop bit
                    rx_data <= data_reg;
                    rx_done <= 1;
                    receiving <= 0;
                    bit_index <= 0;

                end

            end

        end

    end

end

endmodule
