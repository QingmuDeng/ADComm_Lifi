function [decoding] = decodeQam(bitArray)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

decoding=length(bitArray)*2;
for i=1:length(bitArray)
    switch mat2str(bitArray(i))
        case '-1-1i'
            x= 1;
            y= 1;
        case '-1+1i'
            x= 1;
            y= 0;
        case '1-1i'
            x= 0;
            y= 1;
        case '1+1i'
            x= 0;
            y= 0;    
    end
    decoding(1+2*(i-1))= x;
    decoding(2*i)= y;
end

