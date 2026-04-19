`timescale  1ns/1ns
module  auto_trigger #(
    parameter                           ENABLE_COUNT = 1280         
)
(
    input  wire                         clk_40mhz                  ,
    input  wire                         reset                      ,
    
    output reg                          enable                     ,
    output wire        [$clog2(ENABLE_COUNT)-1:0]addr                       ,
    output reg                          flag_1s                     
);
reg [$clog2(ENABLE_COUNT)-1:0] enable_counter; 
assign addr = enable_counter ;

    // parameter  COUNT_MAX1s = 40_000_000;
    parameter  COUNT_MAX1s = 40_000_00;
    reg [$clog2(COUNT_MAX1s)-1:0] counter; 

always @(posedge clk_40mhz or posedge reset) begin
    if (reset) begin
        counter <= 'd0;
        flag_1s <= 1'b0;
    end else begin
        if (counter == COUNT_MAX1s - 1) begin
            counter <= 'd0;     
            flag_1s <= 1'b1;      
        end else begin
            counter <= counter + 1;
            flag_1s <= 1'b0;      
        end
    end
end

            


always @(posedge clk_40mhz or posedge reset) begin
    if (reset) begin
        enable <= 1'b0;
    end else begin
        if (flag_1s) begin
            enable <= 1'b1;
        end else  if (enable_counter == ENABLE_COUNT - 1) begin
                enable <= 1'b0;
        end else begin
            enable <= enable;
        end
    end
end


always @(posedge clk_40mhz or posedge reset) begin
    if (reset) begin
        enable_counter <= 1'b0;
    end else begin
        if (enable_counter == ENABLE_COUNT - 1) begin
            enable_counter <= 'd0;
        end else  if (enable) begin
            enable_counter <= enable_counter +1;
        end else begin
            enable_counter <= 0;
        end
    end
end



endmodule