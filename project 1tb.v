`timescale 1ns/1ps

module tb_async_fifo;

    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 4;

    reg wr_clk, rd_clk, rst;
    reg wr_en, rd_en;
    reg [DATA_WIDTH-1:0] din;

    wire [DATA_WIDTH-1:0] dout;
    wire full, empty;

    // DUT
    async_fifo #(DATA_WIDTH, ADDR_WIDTH) dut (
        .wr_clk(wr_clk),
        .rd_clk(rd_clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .din(din),
        .dout(dout),
        .full(full),
        .empty(empty)
    );

    // Clock generation
    initial wr_clk = 0;
    always #5 wr_clk = ~wr_clk;   // 10ns period

    initial rd_clk = 0;
    always #7 rd_clk = ~rd_clk;   // 14ns period

    // Stimulus
    initial begin
        // Initialize
        rst   = 1;
        wr_en = 0;
        rd_en = 0;
        din   = 0;

        #20 rst = 0;

        // -------------------------
        // WRITE PHASE
        // -------------------------
        $display("---- WRITE START ----");
        repeat (12) begin
            @(posedge wr_clk);
            if (!full) begin
                wr_en = 1;
                din = din + 1;
                $display("Time=%0t WRITE: din=%0d full=%b", $time, din, full);
            end else begin
                wr_en = 0;
                $display("Time=%0t FIFO FULL!", $time);
            end
        end
        wr_en = 0;

        // -------------------------
        // READ PHASE
        // -------------------------
        #40;
        $display("---- READ START ----");
        repeat (12) begin
            @(posedge rd_clk);
            if (!empty) begin
                rd_en = 1;
                $display("Time=%0t READ: dout=%0d empty=%b", $time, dout, empty);
            end else begin
                rd_en = 0;
                $display("Time=%0t FIFO EMPTY!", $time);
            end
        end
        rd_en = 0;

        #100;
        $display("---- SIMULATION END ----");
        $stop;
    end

endmodule
