module apb3_slave_memory #(
  // user parameter starts here
  //
  parameter  ADDR_WIDTH  = 16,
  // parameter  DATA_WIDTH  = 8,
  parameter  DATA_WIDTH  = 32,
  parameter  NUM_REG    = 4
) (
  // user logic starts here
  input                       clk,
  input                       resetn,
  input  [ADDR_WIDTH-1:0]     PADDR,
  input                       PSEL,
  input                       PENABLE,
  output                     PREADY,
  input                       PWRITE,
  input   [DATA_WIDTH-1:0]   PWDATA,
  output  [DATA_WIDTH-1:0]   PRDATA,
  output wire                PRDATA_EN,
output        PSLVERROR
);
/////////////////////////////////////////////////////////////////
localparam [1:0]  IDLE   = 2'b00,
              SETUP  = 2'b01,
              ACCESS = 2'b10;

reg [1:0]      busState, 
               busNext;
reg             slaveReady;
// wire             slaveReady;
wire            actWrite,
               actRead;
//////////////////////////////////////////////////////////////////
  always@(posedge clk or negedge resetn)
  begin
    if(!resetn) 
      busState <= IDLE; 
    else
      busState <= busNext; 
  end

  always@(*)
  begin
    case(busState)
      IDLE:
      begin
        if(PSEL && !PENABLE)
            busNext = SETUP;
        else
            busNext = IDLE;
      end
      SETUP:
      begin
        if(PSEL && PENABLE)
            busNext = ACCESS;
        else
            busNext = IDLE;
      end
      ACCESS:
      begin
        if(PREADY)
            busNext = IDLE;
        else
            busNext = ACCESS;
      end
      default:
      begin
          busNext = IDLE;
      end
    endcase
  end


  assign actWrite = PWRITE  && (busState == ACCESS);
  assign actRead  = !PWRITE && (busState == ACCESS);
  assign PSLVERROR = 1'b0; 
  // assign PREADY = slaveReady && (busState !== IDLE);
  assign PREADY = slaveReady && (busState !== IDLE);

  always@ (posedge clk)
  begin
    slaveReady <= actWrite | actRead;
  end
// assign slaveReady = actWrite | actRead;

bram_test u_bram_test
(
    .wdata_a                           (PWDATA                    ),
    .waddr                             (PADDR /4                    ),// 0 4 8 12
    .clk                               (clk                       ),
    .we                                (actWrite                  ),
    // .raddr                             (PADDR  /4                   ),
    .raddr                             (PADDR  /4                   ),
    .re                                (actRead                   ),
    .rdata_b                           (PRDATA                    ),
    .reset                             (~resetn                   ) 
);

reg r_actRead;
always @(posedge clk ) begin
  r_actRead <= actRead;
end
assign PRDATA_EN = r_actRead;
endmodule