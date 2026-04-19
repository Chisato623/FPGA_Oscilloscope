`timescale  1ns/1ns
module  bram_read_test
(

    input                               clk                        ,
    input                               reset                      ,
    input                               wr_enable                  ,
    input              [  11:0]         wr_addr                    ,
    input              [   7:0]         wr_data                    ,

    output reg align_rden,
    output             [   7:0]         rd_data                     

);


wire                                    falling_edge               ;

        Falling_edge  u_Falling_edge (
    .clk                               (clk                       ),
    .rst_n                             (~reset                    ),
    .pre_signal                        (wr_enable                 ),
    

    .falling_edge                      (falling_edge              )
        );


        parameter  ENABLE_COUNT = 1280;
        reg [$clog2(ENABLE_COUNT)-1:0] rd_enable_counter; 
        reg rd_enable;

        always @(posedge clk or posedge reset) begin
            if (reset) begin
                rd_enable <= 1'b0;
            end else begin
                if (falling_edge) begin
                    rd_enable <= 1'b1;
                end else  if (rd_enable_counter == ENABLE_COUNT - 1) begin
                    rd_enable <= 1'b0;
                end else begin
                    rd_enable <= rd_enable;
                end
            end
        end
        
        
        always @(posedge clk or posedge reset) begin
            if (reset) begin
                rd_enable_counter <= 1'b0;
            end else begin
                if (rd_enable_counter == ENABLE_COUNT - 1) begin
                    rd_enable_counter <= 'd0;
                end else  if (rd_enable) begin
                    rd_enable_counter <= rd_enable_counter +1;
                end else begin
                    rd_enable_counter <= 0;
                end
            end
        end
        

bram_w8d2048 u_bram_w8d2048
(
    .clk                               (clk                       ),
    .reset                             (reset                     ),

    .rdata_b                           (rd_data                   ),
    .raddr                             (rd_enable_counter       ),
    
    .re                                (rd_enable                 ),
    .raddren                           (rd_enable                 ),
    
    .wdata_a                           (wr_data                   ),
    .waddr                             (wr_addr                   ),
    .we                                (wr_enable                 ),
    .waddren                           (wr_enable                 ),
    .wclke                             (1'b1                      ) 
);


always @(posedge clk ) begin
    align_rden <= rd_enable;
end
endmodule
