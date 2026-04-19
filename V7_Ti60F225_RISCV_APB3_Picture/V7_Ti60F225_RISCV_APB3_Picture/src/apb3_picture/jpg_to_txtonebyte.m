clc;
clear all;
close all;

pre_img = imread('D:\FPGA_learning\Efinity_Project\Image_Algorithm\Ti60F225_Uart_Image\src\uart_picture\picture4.jpg'); 

[IMG_HIGH,IMG_WIDTH,IMG_N] = size(pre_img);    

fid = fopen('D:\FPGA_learning\Efinity_Project\Image_Algorithm\Ti60F225_Uart_Image\src\uart_picture\picture4_ONEBYTE2.txt','w');      


for i = 1:IMG_HIGH
    for j = 1:IMG_WIDTH
        
        R = pre_img(i,j,1);
        R8 = dec2hex(R,2);
        G = pre_img(i,j,2);
        G8 = dec2hex(G,2);
        B = pre_img(i,j,3);
        B8 = dec2hex(B,2);

        fprintf(fid,'%s\n',R8); 
        fprintf(fid,'%s\n',G8); 
        fprintf(fid,'%s\n',B8); 
    end
end


%{
for i = 1:IMG_HIGH
    for j = 1:IMG_WIDTH

        Gray = pre_img(i,j);
        Gray = dec2hex(Gray,2);
        
        fprintf(fid,'%s\n',Gray); 
    end
end
%}

fclose(fid); 
imshow(pre_img);