function [parity] = addParity(dat)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[r,c]=size(dat);
if r>c
    dat=dat.';
end

extra=mod(length(dat),4);

seg_num=(length(dat)-extra)/4;

extrabits=dat(end-(extra-1):end);

if extra~=0
    dat=[dat zeros(1, extra)];
end
parity=[];
for m=1:seg_num
    D1=dat(1+4*(m-1));
    D2=dat(2+4*(m-1));
    D3=dat(3+4*(m-1));
    D4=dat(4+4*(m-1));
    
    P1=mod(D1+D2+D4,2);
    P2=mod(D1+D3+D4,2);
    P3=mod(D2+D3+D4,2);
    
    temp=[P1 D1 P2 D2 P3 D3 D4];
    
    parity=[parity temp];
end
parity=[parity extrabits];
end

