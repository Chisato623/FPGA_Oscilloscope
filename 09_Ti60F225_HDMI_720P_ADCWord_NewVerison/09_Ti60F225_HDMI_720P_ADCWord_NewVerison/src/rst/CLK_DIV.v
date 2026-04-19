module CLK_DIV#(
	parameter	P_DIV_CNT = 10000    //Max for 65536
)(
	input	i_clk		,
	input	i_rst		,
	output	o_clk_1K					
);

	reg 		ro_clk_1K	;			
	reg  [15:0]	cnt			;			

	assign	o_clk_1K = ro_clk_1K;

	always@(posedge i_clk,posedge i_rst)
	begin
		if(i_rst)
			cnt <= 0;
		else if(cnt == (P_DIV_CNT >> 1) - 1)
			cnt <= 0;
		else
			cnt <= cnt + 1;
	end
	always@(posedge i_clk,posedge i_rst)
	begin
		if(i_rst)
			ro_clk_1K <= 0;
		else if(cnt == (P_DIV_CNT >> 1) - 1)
			ro_clk_1K <= ~ro_clk_1K;
		else
			ro_clk_1K <= ro_clk_1K;
	end		
endmodule
