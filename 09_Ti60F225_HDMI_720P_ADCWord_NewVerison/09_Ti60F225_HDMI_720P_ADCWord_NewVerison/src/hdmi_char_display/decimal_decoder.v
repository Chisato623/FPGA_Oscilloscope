module decimal_decoder (
    input  wire        [  31:0]         binary_input               ,// 输入的32位二进制数
    output reg         [   3:0]         units                      ,// 个位
    output reg         [   3:0]         tens                       ,// 十位
    output reg         [   3:0]         hundreds                   ,// 百位
    output reg         [   3:0]         thousands                  ,// 千位
    output reg         [   3:0]         ten_thousands               // 万位
);

    reg [31:0] temp; // 临时变量，用于存储中间结果

    always @(*) begin
        // 初始化
        temp          = binary_input;
        units         = 0;
        tens          = 0;
        hundreds      = 0;
        thousands     = 0;
        ten_thousands = 0;

        // 提取个位
        units = temp % 10;
        temp  = temp / 10;

        // 提取十位
        tens = temp % 10;
        temp = temp / 10;

        // 提取百位
        hundreds = temp % 10;
        temp     = temp / 10;

        // 提取千位
        thousands = temp % 10;
        temp      = temp / 10;

        // 提取万位
        ten_thousands = temp % 10;
    end

endmodule
