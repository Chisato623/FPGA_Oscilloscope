module frequency_measure (
    input  wire       clk,           // FPGA 主时钟
    input  wire       reset,         // 复位信号
    input  wire [7:0] adc_data,      // ADC 采样数据
    output  [31:0] freq_value    // 波形频率值 (kHz)
);

endmodule
