

`timescale 1ns / 1ps

module uart_rx #(
	parameter 		   CLK_FREQ   = 50000000,     //ʱ��Ƶ��
	parameter 		   BAUD_RATE  = 115200,       //������
	parameter          DATA_WIDTH = 8,            //����λ��
	parameter          STOP_WIDTH = 1,            //ֹͣλ�� 1��2
	parameter          CHACK_TYPE = 0             //0 ��У�飻1 ��У�飻2 żУ�飻
)(
	input	                      clk,
	input                         reset,

	input                         uart_rxd,      //���ڽ���RX

	output reg                    uart_rx_en,    //��������ʹ��
	output reg [DATA_WIDTH-1:0]   uart_rx_data	 //���ܵ�����	

    );

localparam BAUD_CNT_MAX        = CLK_FREQ  / BAUD_RATE;  //��λ֮ǰ�Ѿ��������,ֻ��Ҫ����һ��
localparam BAUD_CNT_MAX_HALF   = BAUD_CNT_MAX / 2;      //��λ֮ǰ�Ѿ�������ˣ�ֻ��Ҫ����һ��

reg  		uart_rxd_d0;
reg  		uart_rxd_d1;

reg         rx_flag;

reg [$clog2(BAUD_CNT_MAX)-1:0] 	baud_cnt;  //ʹ��$clog2�����Զ�������Сλ�����ú����ᱻ�ۺϳ���λ��·
reg [3:0]  						bit_cnt;

/*--------------------------------------------------*\
				     CDC process
\*--------------------------------------------------*/
always @(posedge clk) begin
	uart_rxd_d0 <= uart_rxd;
    uart_rxd_d1 <= uart_rxd_d0;
end

/*--------------------------------------------------*\
				    cnt signals
\*--------------------------------------------------*/
always @(posedge clk) begin
	if (reset) 
		baud_cnt <= 13'd0;
	else if (~rx_flag || baud_cnt == BAUD_CNT_MAX)
		baud_cnt <= 13'd0;
	else if (rx_flag) 
		baud_cnt <= baud_cnt + 1'b1;
	else 
		baud_cnt <= baud_cnt;
end

always @(posedge clk ) begin
	if (reset) 
		bit_cnt <= 'd0;
	else if (~rx_flag)
		bit_cnt <= 'd0;
	else if (baud_cnt == BAUD_CNT_MAX)	
		bit_cnt <= bit_cnt + 1'b1;
	else 
		bit_cnt <= bit_cnt;	
end

/*--------------------------------------------------*\
				 uart_rx_data signal
\*--------------------------------------------------*/
//д��1 ��λд��
always @(posedge clk ) begin                       //�м�ʱ�̲��������ݸ����ȶ�
	if (bit_cnt >= 1 && bit_cnt <= DATA_WIDTH && baud_cnt == BAUD_CNT_MAX_HALF) 
		uart_rx_data <= {uart_rxd_d1,uart_rx_data[DATA_WIDTH-1:1]};
	else 
		uart_rx_data <= uart_rx_data;
end

//д��2
/*always @(posedge clk ) begin
	if (bit_cnt >= 1 && bit_cnt <= DATA_WIDTH && baud_cnt == BAUD_CNT_MAX_HALF) 
		uart_rx_data[bit_cnt - 1] <= uart_rxd_d1;
	else 
		uart_rx_data <= uart_rx_data;
end*/

/*--------------------------------------------------*\
				  generate...if...                   
\*--------------------------------------------------*/        
generate                            //������C����������������룬��CHACK_TYPEΪ0��ʱ��ֻ��ִ��101~117��
	if (CHACK_TYPE == 0) begin      //�������ִ��벻�ᱻִ�У������ᱻ�ۺϳɵ�·

		always @(posedge clk) begin
			if (baud_cnt == BAUD_CNT_MAX && bit_cnt == DATA_WIDTH) 
				rx_flag <= 1'b0;
			else if (~uart_rxd_d0 && uart_rxd_d1)
				rx_flag <= 1'b1;
		end

		always @(posedge clk) begin
			if (reset) 
				uart_rx_en <= 1'b0;
			else if (baud_cnt == BAUD_CNT_MAX_HALF + 2 && bit_cnt == DATA_WIDTH) 
				uart_rx_en <= 1'b1;
			else 
				uart_rx_en <= 1'b0;		
		end

	end else if (CHACK_TYPE == 1) begin
		reg rx_chack;

		always @(posedge clk) begin
			if (baud_cnt == BAUD_CNT_MAX && bit_cnt == DATA_WIDTH + 1) 
				rx_flag <= 1'b0;
			else if (~uart_rxd_d0 && uart_rxd_d1)
				rx_flag <= 1'b1;
		end	

		always @(posedge clk) begin
			if (reset) 
				rx_chack <= 1'b0;
			else if (baud_cnt == BAUD_CNT_MAX && bit_cnt == DATA_WIDTH + 1)
				rx_chack <= 1'b0;
			else if (bit_cnt >= 1 && bit_cnt <= DATA_WIDTH + 1 && baud_cnt == BAUD_CNT_MAX_HALF)
				rx_chack <= rx_chack ^ uart_rxd_d1;
		end	

		always @(posedge clk) begin
			if (reset) 
				uart_rx_en <= 1'b0;
			else if (baud_cnt == BAUD_CNT_MAX_HALF + 2 && bit_cnt == DATA_WIDTH + 1 && rx_chack) 
				uart_rx_en <= 1'b1;
			else 
				uart_rx_en <= 1'b0;		
		end	

	end else if (CHACK_TYPE == 2) begin
		reg rx_chack;

		always @(posedge clk) begin
			if (baud_cnt == BAUD_CNT_MAX && bit_cnt == DATA_WIDTH + 1) 
				rx_flag <= 1'b0;
			else if (~uart_rxd_d0 && uart_rxd_d1)
				rx_flag <= 1'b1;
		end

		always @(posedge clk) begin
			if (reset) 
				rx_chack <= 1'b0;
			else if (baud_cnt == BAUD_CNT_MAX && bit_cnt == DATA_WIDTH + 1)
				rx_chack <= 1'b0;
			else if (bit_cnt >= 1 && bit_cnt <= DATA_WIDTH + 1 && baud_cnt == BAUD_CNT_MAX_HALF)
				rx_chack <= rx_chack ^ uart_rxd_d1;
		end	

		always @(posedge clk) begin
			if (reset) 
				uart_rx_en <= 1'b0;
			else if (baud_cnt == BAUD_CNT_MAX_HALF + 2 && bit_cnt == DATA_WIDTH + 1 && ~rx_chack) 
				uart_rx_en <= 1'b1;
			else 
				uart_rx_en <= 1'b0;		
		end
	end
endgenerate

endmodule
