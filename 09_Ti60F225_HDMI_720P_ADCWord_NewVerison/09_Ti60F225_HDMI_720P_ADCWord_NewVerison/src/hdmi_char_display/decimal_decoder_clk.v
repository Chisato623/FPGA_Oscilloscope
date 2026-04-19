module decimal_decoder_seq (
    input  wire        clk,           // 时钟信号
    input  wire        reset,         // 复位信号
    input  wire [31:0] binary_input,  // 输入的32位二进制数
    input  wire        start,         // 开始信号
    output reg  [3:0]  units,         // 个位
    output reg  [3:0]  tens,          // 十位
    output reg  [3:0]  hundreds,      // 百位
    output reg  [3:0]  thousands,     // 千位
    output reg  [3:0]  ten_thousands, // 万位
    output reg         done           // 完成信号
);

    // 状态定义

parameter IDLE = 1;
parameter PROCESS = 2;
parameter DONE = 3;

reg [3:0] current_state;
reg [3:0] next_state;

    reg [31:0] temp;       // 临时变量，用于存储二进制数的剩余值
    reg [3:0]  digit_index; // 当前正在处理的十进制位 (0: 个位, 1: 十位, ...)

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // 状态转移逻辑
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (start)
                    next_state = PROCESS;
                else
                    next_state = IDLE;
            end
            PROCESS: begin
                if (digit_index == 5) // 已处理完所有位
                    next_state = DONE;
                else
                    next_state = PROCESS;
            end
            DONE: begin
                next_state = IDLE; // 返回空闲状态
            end
            default: next_state = IDLE;
        endcase
    end

    // 输出和操作逻辑
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            temp           <= 0;
            units          <= 0;
            tens           <= 0;
            hundreds       <= 0;
            thousands      <= 0;
            ten_thousands  <= 0;
            digit_index    <= 0;
            done           <= 0;
        end else begin
            case (current_state)
                IDLE: begin
                    done        <= 0;
                    digit_index <= 0;
                    if (start) begin
                        temp <= binary_input; // 初始化输入值
                        units <= 0;
                        tens  <= 0;
                        hundreds <= 0;
                        thousands <= 0;
                        ten_thousands <= 0;
                    end
                end
                PROCESS: begin
                    // 提取当前最低位
                    case (digit_index)
                        0: units <= temp % 10;
                        1: tens  <= temp % 10;
                        2: hundreds <= temp % 10;
                        3: thousands <= temp % 10;
                        4: ten_thousands <= temp % 10;
                    endcase

                    // 移除最低位
                    temp <= temp / 10;

                    // 更新位索引
                    digit_index <= digit_index + 1;
                end
                DONE: begin
                    done <= 1; // 处理完成
                end
            endcase
        end
    end

endmodule
