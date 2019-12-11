function [encoding] = encodeQam(bitArray)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[r,c]=size(bitArray);
if r<c
    bitArray=bitArray.';
end

if mod(length(bitArray),2)~=0
    bitArray=[bitArray.' 0.'];
end
length(bitArray);
encoding=zeros(length(bitArray)/2,1);
for n=1:length(bitArray)/2
    switch mat2str(bitArray(1+2*(n-1):2*n))
        case '[1;1]'
            encoding(n)=-1-1j;
        case '[1;0]'
            encoding(n)=-1+1j;
        case '[0;1]'
            encoding(n)=1-1j;
        case '[0;0]'
            encoding(n)=1+1j;     
    end
end


