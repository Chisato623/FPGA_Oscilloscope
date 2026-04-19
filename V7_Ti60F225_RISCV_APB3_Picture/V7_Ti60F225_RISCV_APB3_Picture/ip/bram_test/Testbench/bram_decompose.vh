localparam TOTAL_SIZE_A = 16384;
localparam TOTAL_SIZE_B = 16384;
localparam GROUP_COLUMNS       = 1;
parameter DECOMPOSE_WRITE_MODE = "READ_UNKNOWN";
localparam bram_table_size = 7;
localparam bram_table_loop_mode = 0;
localparam bram_mapping_size = 52;
localparam rMux_mapping_A_size = 7;
localparam rMux_mapping_B_size = 7;
localparam wen_sel_mapping_A_size = 7;
localparam wen_sel_mapping_B_size = 7;
localparam data_mapping_table_A_size = 0;
localparam data_mapping_table_B_size = 0;
localparam address_mapping_table_A_size = 0;
localparam address_mapping_table_B_size = 0;


function integer bram_feature_table;
input integer index;//Mode type 
input integer val_; //Address_width, data_width, en_width, reserved 
case (index)
0: bram_feature_table=(val_==0)?9:(val_==1)?20:(val_==2)?2:(val_==3)?2:(val_==4)?0:0;
1: bram_feature_table=(val_==0)?9:(val_==1)?16:(val_==2)?2:(val_==3)?2:(val_==4)?1:0;
2: bram_feature_table=(val_==0)?10:(val_==1)?10:(val_==2)?1:(val_==3)?2:(val_==4)?0:0;
3: bram_feature_table=(val_==0)?10:(val_==1)?8:(val_==2)?1:(val_==3)?2:(val_==4)?1:0;
4: bram_feature_table=(val_==0)?11:(val_==1)?5:(val_==2)?1:(val_==3)?2:(val_==4)?0:0;
5: bram_feature_table=(val_==0)?11:(val_==1)?4:(val_==2)?1:(val_==3)?2:(val_==4)?1:0;
6: bram_feature_table=(val_==0)?12:(val_==1)?2:(val_==2)?1:(val_==3)?2:(val_==4)?1:0;
7: bram_feature_table=(val_==0)?13:(val_==1)?1:(val_==2)?1:(val_==3)?2:(val_==4)?1:0;
   endcase
endfunction  


function integer bram_decompose_table;
input integer index;//Mode type 
input integer val_; //Port A index, Port B Index, Number of Items in Loop, Port A Start, Port B Start, reserved 
case (index)
   0: bram_decompose_table=(val_==0)?   4:(val_==1)?   4:(val_==2)?   8:(val_==3)?   0:(val_==4)?   0:0;
   1: bram_decompose_table=(val_==0)?   4:(val_==1)?   4:(val_==2)?   8:(val_==3)?   0:(val_==4)?   0:0;
   2: bram_decompose_table=(val_==0)?   4:(val_==1)?   4:(val_==2)?   8:(val_==3)?   0:(val_==4)?   0:0;
   3: bram_decompose_table=(val_==0)?   4:(val_==1)?   4:(val_==2)?   8:(val_==3)?   0:(val_==4)?   0:0;
   4: bram_decompose_table=(val_==0)?   4:(val_==1)?   4:(val_==2)?   8:(val_==3)?   0:(val_==4)?   0:0;
   5: bram_decompose_table=(val_==0)?   4:(val_==1)?   4:(val_==2)?   8:(val_==3)?   0:(val_==4)?   0:0;
   6: bram_decompose_table=(val_==0)?   6:(val_==1)?   6:(val_==2)?   4:(val_==3)?   0:(val_==4)?   0:0;
   endcase
endfunction  


function integer bram_mapping_table;
input integer index;//Mode type 
input integer val_;//            Y,              X,              DataA [MSB],    DataA [LSB],    DataA Repeat,   Read MuxA,      Wen0 SelA,      Wen1 SelA,      Byteen A,       DataB [MSB],    DataB [LSB],    DataB Repeat,   Read MuxB,      Wen0 SelB,      Wen1 SelB,      Byteen B,       Addr Width A    Data Width A    Addr Width B    Data Width B    
case (index)
   0: bram_mapping_table=(val_== 0)?   0:(val_== 1)?   0:(val_== 2)?   4:(val_== 3)?   0:(val_== 4)?   0:(val_== 5)?   0:(val_== 6)?   0:(val_== 7)?   0:(val_== 8)?   0:(val_== 9)?   4:(val_==10)?   0:(val_==11)?   0:(val_==12)?   0:(val_==13)?   0:(val_==14)?   0:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
   1: bram_mapping_table=(val_== 0)?   1:(val_== 1)?   0:(val_== 2)?   4:(val_== 3)?   0:(val_== 4)?   0:(val_== 5)?   1:(val_== 6)?   1:(val_== 7)?   1:(val_== 8)?   0:(val_== 9)?   4:(val_==10)?   0:(val_==11)?   0:(val_==12)?   1:(val_==13)?   1:(val_==14)?   1:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
   2: bram_mapping_table=(val_== 0)?   2:(val_== 1)?   0:(val_== 2)?   4:(val_== 3)?   0:(val_== 4)?   0:(val_== 5)?   2:(val_== 6)?   2:(val_== 7)?   2:(val_== 8)?   0:(val_== 9)?   4:(val_==10)?   0:(val_==11)?   0:(val_==12)?   2:(val_==13)?   2:(val_==14)?   2:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
   3: bram_mapping_table=(val_== 0)?   3:(val_== 1)?   0:(val_== 2)?   4:(val_== 3)?   0:(val_== 4)?   0:(val_== 5)?   3:(val_== 6)?   3:(val_== 7)?   3:(val_== 8)?   0:(val_== 9)?   4:(val_==10)?   0:(val_==11)?   0:(val_==12)?   3:(val_==13)?   3:(val_==14)?   3:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
   4: bram_mapping_table=(val_== 0)?   4:(val_== 1)?   0:(val_== 2)?   4:(val_== 3)?   0:(val_== 4)?   0:(val_== 5)?   4:(val_== 6)?   4:(val_== 7)?   4:(val_== 8)?   0:(val_== 9)?   4:(val_==10)?   0:(val_==11)?   0:(val_==12)?   4:(val_==13)?   4:(val_==14)?   4:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
   5: bram_mapping_table=(val_== 0)?   5:(val_== 1)?   0:(val_== 2)?   4:(val_== 3)?   0:(val_== 4)?   0:(val_== 5)?   5:(val_== 6)?   5:(val_== 7)?   5:(val_== 8)?   0:(val_== 9)?   4:(val_==10)?   0:(val_==11)?   0:(val_==12)?   5:(val_==13)?   5:(val_==14)?   5:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
   6: bram_mapping_table=(val_== 0)?   6:(val_== 1)?   0:(val_== 2)?   4:(val_== 3)?   0:(val_== 4)?   0:(val_== 5)?   6:(val_== 6)?   6:(val_== 7)?   6:(val_== 8)?   0:(val_== 9)?   4:(val_==10)?   0:(val_==11)?   0:(val_==12)?   6:(val_==13)?   6:(val_==14)?   6:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
   7: bram_mapping_table=(val_== 0)?   7:(val_== 1)?   0:(val_== 2)?   4:(val_== 3)?   0:(val_== 4)?   0:(val_== 5)?   7:(val_== 6)?   7:(val_== 7)?   7:(val_== 8)?   0:(val_== 9)?   4:(val_==10)?   0:(val_==11)?   0:(val_==12)?   7:(val_==13)?   7:(val_==14)?   7:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
   8: bram_mapping_table=(val_== 0)?   0:(val_== 1)?   1:(val_== 2)?   9:(val_== 3)?   5:(val_== 4)?   0:(val_== 5)?   0:(val_== 6)?   8:(val_== 7)?   8:(val_== 8)?   0:(val_== 9)?   9:(val_==10)?   5:(val_==11)?   0:(val_==12)?   0:(val_==13)?   8:(val_==14)?   8:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
   9: bram_mapping_table=(val_== 0)?   1:(val_== 1)?   1:(val_== 2)?   9:(val_== 3)?   5:(val_== 4)?   0:(val_== 5)?   1:(val_== 6)?   9:(val_== 7)?   9:(val_== 8)?   0:(val_== 9)?   9:(val_==10)?   5:(val_==11)?   0:(val_==12)?   1:(val_==13)?   9:(val_==14)?   9:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  10: bram_mapping_table=(val_== 0)?   2:(val_== 1)?   1:(val_== 2)?   9:(val_== 3)?   5:(val_== 4)?   0:(val_== 5)?   2:(val_== 6)?  10:(val_== 7)?  10:(val_== 8)?   0:(val_== 9)?   9:(val_==10)?   5:(val_==11)?   0:(val_==12)?   2:(val_==13)?  10:(val_==14)?  10:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  11: bram_mapping_table=(val_== 0)?   3:(val_== 1)?   1:(val_== 2)?   9:(val_== 3)?   5:(val_== 4)?   0:(val_== 5)?   3:(val_== 6)?  11:(val_== 7)?  11:(val_== 8)?   0:(val_== 9)?   9:(val_==10)?   5:(val_==11)?   0:(val_==12)?   3:(val_==13)?  11:(val_==14)?  11:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  12: bram_mapping_table=(val_== 0)?   4:(val_== 1)?   1:(val_== 2)?   9:(val_== 3)?   5:(val_== 4)?   0:(val_== 5)?   4:(val_== 6)?  12:(val_== 7)?  12:(val_== 8)?   0:(val_== 9)?   9:(val_==10)?   5:(val_==11)?   0:(val_==12)?   4:(val_==13)?  12:(val_==14)?  12:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  13: bram_mapping_table=(val_== 0)?   5:(val_== 1)?   1:(val_== 2)?   9:(val_== 3)?   5:(val_== 4)?   0:(val_== 5)?   5:(val_== 6)?  13:(val_== 7)?  13:(val_== 8)?   0:(val_== 9)?   9:(val_==10)?   5:(val_==11)?   0:(val_==12)?   5:(val_==13)?  13:(val_==14)?  13:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  14: bram_mapping_table=(val_== 0)?   6:(val_== 1)?   1:(val_== 2)?   9:(val_== 3)?   5:(val_== 4)?   0:(val_== 5)?   6:(val_== 6)?  14:(val_== 7)?  14:(val_== 8)?   0:(val_== 9)?   9:(val_==10)?   5:(val_==11)?   0:(val_==12)?   6:(val_==13)?  14:(val_==14)?  14:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  15: bram_mapping_table=(val_== 0)?   7:(val_== 1)?   1:(val_== 2)?   9:(val_== 3)?   5:(val_== 4)?   0:(val_== 5)?   7:(val_== 6)?  15:(val_== 7)?  15:(val_== 8)?   0:(val_== 9)?   9:(val_==10)?   5:(val_==11)?   0:(val_==12)?   7:(val_==13)?  15:(val_==14)?  15:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  16: bram_mapping_table=(val_== 0)?   0:(val_== 1)?   2:(val_== 2)?  14:(val_== 3)?  10:(val_== 4)?   0:(val_== 5)?   0:(val_== 6)?  16:(val_== 7)?  16:(val_== 8)?   0:(val_== 9)?  14:(val_==10)?  10:(val_==11)?   0:(val_==12)?   0:(val_==13)?  16:(val_==14)?  16:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  17: bram_mapping_table=(val_== 0)?   1:(val_== 1)?   2:(val_== 2)?  14:(val_== 3)?  10:(val_== 4)?   0:(val_== 5)?   1:(val_== 6)?  17:(val_== 7)?  17:(val_== 8)?   0:(val_== 9)?  14:(val_==10)?  10:(val_==11)?   0:(val_==12)?   1:(val_==13)?  17:(val_==14)?  17:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  18: bram_mapping_table=(val_== 0)?   2:(val_== 1)?   2:(val_== 2)?  14:(val_== 3)?  10:(val_== 4)?   0:(val_== 5)?   2:(val_== 6)?  18:(val_== 7)?  18:(val_== 8)?   0:(val_== 9)?  14:(val_==10)?  10:(val_==11)?   0:(val_==12)?   2:(val_==13)?  18:(val_==14)?  18:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  19: bram_mapping_table=(val_== 0)?   3:(val_== 1)?   2:(val_== 2)?  14:(val_== 3)?  10:(val_== 4)?   0:(val_== 5)?   3:(val_== 6)?  19:(val_== 7)?  19:(val_== 8)?   0:(val_== 9)?  14:(val_==10)?  10:(val_==11)?   0:(val_==12)?   3:(val_==13)?  19:(val_==14)?  19:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  20: bram_mapping_table=(val_== 0)?   4:(val_== 1)?   2:(val_== 2)?  14:(val_== 3)?  10:(val_== 4)?   0:(val_== 5)?   4:(val_== 6)?  20:(val_== 7)?  20:(val_== 8)?   0:(val_== 9)?  14:(val_==10)?  10:(val_==11)?   0:(val_==12)?   4:(val_==13)?  20:(val_==14)?  20:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  21: bram_mapping_table=(val_== 0)?   5:(val_== 1)?   2:(val_== 2)?  14:(val_== 3)?  10:(val_== 4)?   0:(val_== 5)?   5:(val_== 6)?  21:(val_== 7)?  21:(val_== 8)?   0:(val_== 9)?  14:(val_==10)?  10:(val_==11)?   0:(val_==12)?   5:(val_==13)?  21:(val_==14)?  21:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  22: bram_mapping_table=(val_== 0)?   6:(val_== 1)?   2:(val_== 2)?  14:(val_== 3)?  10:(val_== 4)?   0:(val_== 5)?   6:(val_== 6)?  22:(val_== 7)?  22:(val_== 8)?   0:(val_== 9)?  14:(val_==10)?  10:(val_==11)?   0:(val_==12)?   6:(val_==13)?  22:(val_==14)?  22:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  23: bram_mapping_table=(val_== 0)?   7:(val_== 1)?   2:(val_== 2)?  14:(val_== 3)?  10:(val_== 4)?   0:(val_== 5)?   7:(val_== 6)?  23:(val_== 7)?  23:(val_== 8)?   0:(val_== 9)?  14:(val_==10)?  10:(val_==11)?   0:(val_==12)?   7:(val_==13)?  23:(val_==14)?  23:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  24: bram_mapping_table=(val_== 0)?   0:(val_== 1)?   3:(val_== 2)?  19:(val_== 3)?  15:(val_== 4)?   0:(val_== 5)?   0:(val_== 6)?  24:(val_== 7)?  24:(val_== 8)?   0:(val_== 9)?  19:(val_==10)?  15:(val_==11)?   0:(val_==12)?   0:(val_==13)?  24:(val_==14)?  24:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  25: bram_mapping_table=(val_== 0)?   1:(val_== 1)?   3:(val_== 2)?  19:(val_== 3)?  15:(val_== 4)?   0:(val_== 5)?   1:(val_== 6)?  25:(val_== 7)?  25:(val_== 8)?   0:(val_== 9)?  19:(val_==10)?  15:(val_==11)?   0:(val_==12)?   1:(val_==13)?  25:(val_==14)?  25:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  26: bram_mapping_table=(val_== 0)?   2:(val_== 1)?   3:(val_== 2)?  19:(val_== 3)?  15:(val_== 4)?   0:(val_== 5)?   2:(val_== 6)?  26:(val_== 7)?  26:(val_== 8)?   0:(val_== 9)?  19:(val_==10)?  15:(val_==11)?   0:(val_==12)?   2:(val_==13)?  26:(val_==14)?  26:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  27: bram_mapping_table=(val_== 0)?   3:(val_== 1)?   3:(val_== 2)?  19:(val_== 3)?  15:(val_== 4)?   0:(val_== 5)?   3:(val_== 6)?  27:(val_== 7)?  27:(val_== 8)?   0:(val_== 9)?  19:(val_==10)?  15:(val_==11)?   0:(val_==12)?   3:(val_==13)?  27:(val_==14)?  27:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  28: bram_mapping_table=(val_== 0)?   4:(val_== 1)?   3:(val_== 2)?  19:(val_== 3)?  15:(val_== 4)?   0:(val_== 5)?   4:(val_== 6)?  28:(val_== 7)?  28:(val_== 8)?   0:(val_== 9)?  19:(val_==10)?  15:(val_==11)?   0:(val_==12)?   4:(val_==13)?  28:(val_==14)?  28:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  29: bram_mapping_table=(val_== 0)?   5:(val_== 1)?   3:(val_== 2)?  19:(val_== 3)?  15:(val_== 4)?   0:(val_== 5)?   5:(val_== 6)?  29:(val_== 7)?  29:(val_== 8)?   0:(val_== 9)?  19:(val_==10)?  15:(val_==11)?   0:(val_==12)?   5:(val_==13)?  29:(val_==14)?  29:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  30: bram_mapping_table=(val_== 0)?   6:(val_== 1)?   3:(val_== 2)?  19:(val_== 3)?  15:(val_== 4)?   0:(val_== 5)?   6:(val_== 6)?  30:(val_== 7)?  30:(val_== 8)?   0:(val_== 9)?  19:(val_==10)?  15:(val_==11)?   0:(val_==12)?   6:(val_==13)?  30:(val_==14)?  30:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  31: bram_mapping_table=(val_== 0)?   7:(val_== 1)?   3:(val_== 2)?  19:(val_== 3)?  15:(val_== 4)?   0:(val_== 5)?   7:(val_== 6)?  31:(val_== 7)?  31:(val_== 8)?   0:(val_== 9)?  19:(val_==10)?  15:(val_==11)?   0:(val_==12)?   7:(val_==13)?  31:(val_==14)?  31:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  32: bram_mapping_table=(val_== 0)?   0:(val_== 1)?   4:(val_== 2)?  24:(val_== 3)?  20:(val_== 4)?   0:(val_== 5)?   0:(val_== 6)?  32:(val_== 7)?  32:(val_== 8)?   0:(val_== 9)?  24:(val_==10)?  20:(val_==11)?   0:(val_==12)?   0:(val_==13)?  32:(val_==14)?  32:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  33: bram_mapping_table=(val_== 0)?   1:(val_== 1)?   4:(val_== 2)?  24:(val_== 3)?  20:(val_== 4)?   0:(val_== 5)?   1:(val_== 6)?  33:(val_== 7)?  33:(val_== 8)?   0:(val_== 9)?  24:(val_==10)?  20:(val_==11)?   0:(val_==12)?   1:(val_==13)?  33:(val_==14)?  33:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  34: bram_mapping_table=(val_== 0)?   2:(val_== 1)?   4:(val_== 2)?  24:(val_== 3)?  20:(val_== 4)?   0:(val_== 5)?   2:(val_== 6)?  34:(val_== 7)?  34:(val_== 8)?   0:(val_== 9)?  24:(val_==10)?  20:(val_==11)?   0:(val_==12)?   2:(val_==13)?  34:(val_==14)?  34:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  35: bram_mapping_table=(val_== 0)?   3:(val_== 1)?   4:(val_== 2)?  24:(val_== 3)?  20:(val_== 4)?   0:(val_== 5)?   3:(val_== 6)?  35:(val_== 7)?  35:(val_== 8)?   0:(val_== 9)?  24:(val_==10)?  20:(val_==11)?   0:(val_==12)?   3:(val_==13)?  35:(val_==14)?  35:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  36: bram_mapping_table=(val_== 0)?   4:(val_== 1)?   4:(val_== 2)?  24:(val_== 3)?  20:(val_== 4)?   0:(val_== 5)?   4:(val_== 6)?  36:(val_== 7)?  36:(val_== 8)?   0:(val_== 9)?  24:(val_==10)?  20:(val_==11)?   0:(val_==12)?   4:(val_==13)?  36:(val_==14)?  36:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  37: bram_mapping_table=(val_== 0)?   5:(val_== 1)?   4:(val_== 2)?  24:(val_== 3)?  20:(val_== 4)?   0:(val_== 5)?   5:(val_== 6)?  37:(val_== 7)?  37:(val_== 8)?   0:(val_== 9)?  24:(val_==10)?  20:(val_==11)?   0:(val_==12)?   5:(val_==13)?  37:(val_==14)?  37:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  38: bram_mapping_table=(val_== 0)?   6:(val_== 1)?   4:(val_== 2)?  24:(val_== 3)?  20:(val_== 4)?   0:(val_== 5)?   6:(val_== 6)?  38:(val_== 7)?  38:(val_== 8)?   0:(val_== 9)?  24:(val_==10)?  20:(val_==11)?   0:(val_==12)?   6:(val_==13)?  38:(val_==14)?  38:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  39: bram_mapping_table=(val_== 0)?   7:(val_== 1)?   4:(val_== 2)?  24:(val_== 3)?  20:(val_== 4)?   0:(val_== 5)?   7:(val_== 6)?  39:(val_== 7)?  39:(val_== 8)?   0:(val_== 9)?  24:(val_==10)?  20:(val_==11)?   0:(val_==12)?   7:(val_==13)?  39:(val_==14)?  39:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  40: bram_mapping_table=(val_== 0)?   0:(val_== 1)?   5:(val_== 2)?  29:(val_== 3)?  25:(val_== 4)?   0:(val_== 5)?   0:(val_== 6)?  40:(val_== 7)?  40:(val_== 8)?   0:(val_== 9)?  29:(val_==10)?  25:(val_==11)?   0:(val_==12)?   0:(val_==13)?  40:(val_==14)?  40:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  41: bram_mapping_table=(val_== 0)?   1:(val_== 1)?   5:(val_== 2)?  29:(val_== 3)?  25:(val_== 4)?   0:(val_== 5)?   1:(val_== 6)?  41:(val_== 7)?  41:(val_== 8)?   0:(val_== 9)?  29:(val_==10)?  25:(val_==11)?   0:(val_==12)?   1:(val_==13)?  41:(val_==14)?  41:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  42: bram_mapping_table=(val_== 0)?   2:(val_== 1)?   5:(val_== 2)?  29:(val_== 3)?  25:(val_== 4)?   0:(val_== 5)?   2:(val_== 6)?  42:(val_== 7)?  42:(val_== 8)?   0:(val_== 9)?  29:(val_==10)?  25:(val_==11)?   0:(val_==12)?   2:(val_==13)?  42:(val_==14)?  42:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  43: bram_mapping_table=(val_== 0)?   3:(val_== 1)?   5:(val_== 2)?  29:(val_== 3)?  25:(val_== 4)?   0:(val_== 5)?   3:(val_== 6)?  43:(val_== 7)?  43:(val_== 8)?   0:(val_== 9)?  29:(val_==10)?  25:(val_==11)?   0:(val_==12)?   3:(val_==13)?  43:(val_==14)?  43:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  44: bram_mapping_table=(val_== 0)?   4:(val_== 1)?   5:(val_== 2)?  29:(val_== 3)?  25:(val_== 4)?   0:(val_== 5)?   4:(val_== 6)?  44:(val_== 7)?  44:(val_== 8)?   0:(val_== 9)?  29:(val_==10)?  25:(val_==11)?   0:(val_==12)?   4:(val_==13)?  44:(val_==14)?  44:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  45: bram_mapping_table=(val_== 0)?   5:(val_== 1)?   5:(val_== 2)?  29:(val_== 3)?  25:(val_== 4)?   0:(val_== 5)?   5:(val_== 6)?  45:(val_== 7)?  45:(val_== 8)?   0:(val_== 9)?  29:(val_==10)?  25:(val_==11)?   0:(val_==12)?   5:(val_==13)?  45:(val_==14)?  45:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  46: bram_mapping_table=(val_== 0)?   6:(val_== 1)?   5:(val_== 2)?  29:(val_== 3)?  25:(val_== 4)?   0:(val_== 5)?   6:(val_== 6)?  46:(val_== 7)?  46:(val_== 8)?   0:(val_== 9)?  29:(val_==10)?  25:(val_==11)?   0:(val_==12)?   6:(val_==13)?  46:(val_==14)?  46:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  47: bram_mapping_table=(val_== 0)?   7:(val_== 1)?   5:(val_== 2)?  29:(val_== 3)?  25:(val_== 4)?   0:(val_== 5)?   7:(val_== 6)?  47:(val_== 7)?  47:(val_== 8)?   0:(val_== 9)?  29:(val_==10)?  25:(val_==11)?   0:(val_==12)?   7:(val_==13)?  47:(val_==14)?  47:(val_==15)?   0:(val_==16)?  11:(val_==17)?   5:(val_==18)?  11:(val_==19)?   5:0;
  48: bram_mapping_table=(val_== 0)?   0:(val_== 1)?   6:(val_== 2)?  31:(val_== 3)?  30:(val_== 4)?   0:(val_== 5)?   0:(val_== 6)?  48:(val_== 7)?  48:(val_== 8)?   0:(val_== 9)?  31:(val_==10)?  30:(val_==11)?   0:(val_==12)?   0:(val_==13)?  48:(val_==14)?  48:(val_==15)?   0:(val_==16)?  12:(val_==17)?   2:(val_==18)?  12:(val_==19)?   2:0;
  49: bram_mapping_table=(val_== 0)?   1:(val_== 1)?   6:(val_== 2)?  31:(val_== 3)?  30:(val_== 4)?   0:(val_== 5)?   1:(val_== 6)?  49:(val_== 7)?  49:(val_== 8)?   0:(val_== 9)?  31:(val_==10)?  30:(val_==11)?   0:(val_==12)?   1:(val_==13)?  49:(val_==14)?  49:(val_==15)?   0:(val_==16)?  12:(val_==17)?   2:(val_==18)?  12:(val_==19)?   2:0;
  50: bram_mapping_table=(val_== 0)?   2:(val_== 1)?   6:(val_== 2)?  31:(val_== 3)?  30:(val_== 4)?   0:(val_== 5)?   2:(val_== 6)?  50:(val_== 7)?  50:(val_== 8)?   0:(val_== 9)?  31:(val_==10)?  30:(val_==11)?   0:(val_==12)?   2:(val_==13)?  50:(val_==14)?  50:(val_==15)?   0:(val_==16)?  12:(val_==17)?   2:(val_==18)?  12:(val_==19)?   2:0;
  51: bram_mapping_table=(val_== 0)?   3:(val_== 1)?   6:(val_== 2)?  31:(val_== 3)?  30:(val_== 4)?   0:(val_== 5)?   3:(val_== 6)?  51:(val_== 7)?  51:(val_== 8)?   0:(val_== 9)?  31:(val_==10)?  30:(val_==11)?   0:(val_==12)?   3:(val_==13)?  51:(val_==14)?  51:(val_==15)?   0:(val_==16)?  12:(val_==17)?   2:(val_==18)?  12:(val_==19)?   2:0;
   endcase
endfunction  


function integer rMux_mapping_table_A;
input integer index;//Mode type 
input integer val_;//            PortA Addr MSB, PortA Addr LSB, DataA[MSB],     DataA[LSB],     MuxSelA[MSB],   MuxSelA[LSB],   Bypass,         
case (index)
   0: rMux_mapping_table_A=(val_== 0)?  13:(val_== 1)?  11:(val_== 2)?   4:(val_== 3)?   0:(val_== 4)?   7:(val_== 5)?   0:(val_== 6)?   0:0;
   1: rMux_mapping_table_A=(val_== 0)?  13:(val_== 1)?  11:(val_== 2)?   9:(val_== 3)?   5:(val_== 4)?   7:(val_== 5)?   0:(val_== 6)?   0:0;
   2: rMux_mapping_table_A=(val_== 0)?  13:(val_== 1)?  11:(val_== 2)?  14:(val_== 3)?  10:(val_== 4)?   7:(val_== 5)?   0:(val_== 6)?   0:0;
   3: rMux_mapping_table_A=(val_== 0)?  13:(val_== 1)?  11:(val_== 2)?  19:(val_== 3)?  15:(val_== 4)?   7:(val_== 5)?   0:(val_== 6)?   0:0;
   4: rMux_mapping_table_A=(val_== 0)?  13:(val_== 1)?  11:(val_== 2)?  24:(val_== 3)?  20:(val_== 4)?   7:(val_== 5)?   0:(val_== 6)?   0:0;
   5: rMux_mapping_table_A=(val_== 0)?  13:(val_== 1)?  11:(val_== 2)?  29:(val_== 3)?  25:(val_== 4)?   7:(val_== 5)?   0:(val_== 6)?   0:0;
   6: rMux_mapping_table_A=(val_== 0)?  13:(val_== 1)?  12:(val_== 2)?  31:(val_== 3)?  30:(val_== 4)?   3:(val_== 5)?   0:(val_== 6)?   0:0;
   endcase
endfunction  


function integer rMux_mapping_table_B;
input integer index;//Mode type 
input integer val_;//            PortB Addr MSB, PortB Addr LSB, DataB[MSB],     DataB[LSB],     MuxSelB[MSB],   MuxSelB[LSB],   Bypass,         
case (index)
   0: rMux_mapping_table_B=(val_== 0)?  13:(val_== 1)?  11:(val_== 2)?   4:(val_== 3)?   0:(val_== 4)?   7:(val_== 5)?   0:(val_== 6)?   0:0;
   1: rMux_mapping_table_B=(val_== 0)?  13:(val_== 1)?  11:(val_== 2)?   9:(val_== 3)?   5:(val_== 4)?   7:(val_== 5)?   0:(val_== 6)?   0:0;
   2: rMux_mapping_table_B=(val_== 0)?  13:(val_== 1)?  11:(val_== 2)?  14:(val_== 3)?  10:(val_== 4)?   7:(val_== 5)?   0:(val_== 6)?   0:0;
   3: rMux_mapping_table_B=(val_== 0)?  13:(val_== 1)?  11:(val_== 2)?  19:(val_== 3)?  15:(val_== 4)?   7:(val_== 5)?   0:(val_== 6)?   0:0;
   4: rMux_mapping_table_B=(val_== 0)?  13:(val_== 1)?  11:(val_== 2)?  24:(val_== 3)?  20:(val_== 4)?   7:(val_== 5)?   0:(val_== 6)?   0:0;
   5: rMux_mapping_table_B=(val_== 0)?  13:(val_== 1)?  11:(val_== 2)?  29:(val_== 3)?  25:(val_== 4)?   7:(val_== 5)?   0:(val_== 6)?   0:0;
   6: rMux_mapping_table_B=(val_== 0)?  13:(val_== 1)?  12:(val_== 2)?  31:(val_== 3)?  30:(val_== 4)?   3:(val_== 5)?   0:(val_== 6)?   0:0;
   endcase
endfunction  


function integer wen_sel_mapping_table_A;
input integer index;//Mode type 
input integer val_;//              PortA Addr MSB,   PortA Addr LSB,   WenSelA[MSB],     WenSelA[LSB],     Bypass,         
case (index)
   0: wen_sel_mapping_table_A=(val_== 0)?  13:(val_== 1)?  11:(val_== 2)?   7:(val_== 3)?   0:(val_== 4)?   0:0;
   1: wen_sel_mapping_table_A=(val_== 0)?  13:(val_== 1)?  11:(val_== 2)?  15:(val_== 3)?   8:(val_== 4)?   0:0;
   2: wen_sel_mapping_table_A=(val_== 0)?  13:(val_== 1)?  11:(val_== 2)?  23:(val_== 3)?  16:(val_== 4)?   0:0;
   3: wen_sel_mapping_table_A=(val_== 0)?  13:(val_== 1)?  11:(val_== 2)?  31:(val_== 3)?  24:(val_== 4)?   0:0;
   4: wen_sel_mapping_table_A=(val_== 0)?  13:(val_== 1)?  11:(val_== 2)?  39:(val_== 3)?  32:(val_== 4)?   0:0;
   5: wen_sel_mapping_table_A=(val_== 0)?  13:(val_== 1)?  11:(val_== 2)?  47:(val_== 3)?  40:(val_== 4)?   0:0;
   6: wen_sel_mapping_table_A=(val_== 0)?  13:(val_== 1)?  12:(val_== 2)?  51:(val_== 3)?  48:(val_== 4)?   0:0;
   endcase
endfunction  


function integer wen_sel_mapping_table_B;
input integer index;//Mode type 
input integer val_;//            PortB Addr MSB, PortB Addr LSB, WenSelB[MSB],   WenSelB[LSB],   Bypass,         
case (index)
   0: wen_sel_mapping_table_B=(val_== 0)?  13:(val_== 1)?  11:(val_== 2)?   7:(val_== 3)?   0:(val_== 4)?   0:0;
   1: wen_sel_mapping_table_B=(val_== 0)?  13:(val_== 1)?  11:(val_== 2)?  15:(val_== 3)?   8:(val_== 4)?   0:0;
   2: wen_sel_mapping_table_B=(val_== 0)?  13:(val_== 1)?  11:(val_== 2)?  23:(val_== 3)?  16:(val_== 4)?   0:0;
   3: wen_sel_mapping_table_B=(val_== 0)?  13:(val_== 1)?  11:(val_== 2)?  31:(val_== 3)?  24:(val_== 4)?   0:0;
   4: wen_sel_mapping_table_B=(val_== 0)?  13:(val_== 1)?  11:(val_== 2)?  39:(val_== 3)?  32:(val_== 4)?   0:0;
   5: wen_sel_mapping_table_B=(val_== 0)?  13:(val_== 1)?  11:(val_== 2)?  47:(val_== 3)?  40:(val_== 4)?   0:0;
   6: wen_sel_mapping_table_B=(val_== 0)?  13:(val_== 1)?  12:(val_== 2)?  51:(val_== 3)?  48:(val_== 4)?   0:0;
   endcase
endfunction  


function integer data_mapping_table_A;
input integer index;// 
data_mapping_table_A = 0; 
endfunction  


function integer data_mapping_table_B;
input integer index;// 
data_mapping_table_B = 0; 
endfunction  


function integer address_mapping_table_A;
input integer index;// 
address_mapping_table_A = 0; 
endfunction  


function integer address_mapping_table_B;
input integer index;// 
address_mapping_table_B = 0; 
endfunction  
