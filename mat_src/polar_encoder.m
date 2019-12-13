clc;
clear;

n = 3;      % 级数
N=2^n;      % 编码长度
R=1/2;      % 码率

S=N*R;      % 信息位所占码长
F=N-S;      % 冻结位所占码长

signal = randi([0,1],1,S);       %信息位比特，随机二进制数
frozen = zeros(1,F);             %固定位比特，规定全为0

EbN0db = 2;  % 1/2:0~2; 1/3: -0.2~1.8; 1/4: -1~1; 1/6: -1.2~0.8
ebn0 = 10.^(EbN0db./10);
%sigma = 1/sqrt(2*rate*en);
noise = ebn0*randn(1, N);

%Bhat = Bhat_para(p, N);
Bhat = [0.9593    0.5472    0.1386    0.1493    0.2575    0.8407    0.2543    0.8143];

[Z_in_order,index] = sort( Bhat );          %将巴氏参数从小到大排列
signal_index = sort( index( 1:S ) );        %前S位作为信息位
frozen_index = sort( index( S+1:end ) );    %后面的作为冻结位

u = zeros(1,N);
u(1, signal_index) = signal;

GN = gen_matrix( n );

encode = mod(u*GN, 2);

