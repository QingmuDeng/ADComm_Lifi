function [encoding] = encodeQam(bitArray)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if mod(length(bitArray),2)~=0
    bitArray=[bitArray.' 0.'];
end
encoding=length(bitArray)/2;
for i=1:length(bitArray)/2
    switch mat2str(bitArray(1+2*(i-1):2*i))
        case '[1 1]'
            encoding(i)=-1-1j;
        case '[1 0]'
            encoding(i)=-1+1j;
        case '[0 1]'
            encoding(i)=1-1j;
        case '[0 0]'
            encoding(i)=1+1j;     
    end
end

