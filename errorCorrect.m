function [original] = errorCorrect(dat)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
[r,c]=size(dat);
if r>c
    dat=dat.';
end

extra=mod(length(dat),7);
seg_num=(length(dat)-extra)/7;

if extra~=0
    dat=[dat zeros(1, extra)];
end

original=[];
for m=1:seg_num
    P1=dat(1+7*(m-1));
    D1=dat(2+7*(m-1));
    P2=dat(3+7*(m-1));
    D2=dat(4+7*(m-1));
    P3=dat(5+7*(m-1));
    D3=dat(6+7*(m-1));
    D4=dat(7+7*(m-1));
    
    
    reP1=mod(D1+D2+D4,2);
    reP2=mod(D1+D3+D4,2);
    reP3=mod(D2+D3+D4,2);
    
    flag_P1=true;
    flag_P2=true;
    flag_P3=true;
    if reP1~=P1
        flag_P1=false;
    end
    if reP2~=P2
        flag_P2=false;
    end
    if reP3~=P3
        flag_P3=false;
    end
    
    flag_total=flag_P1+flag_P2+flag_P3;
    if flag_total<2
        if ~flag_P1 && ~flag_P2 && flag_P3
            D1=~D1;            
        end
        if ~flag_P1 && flag_P2 && ~flag_P3
            D2=~D2;            
        end
        if flag_P1 && ~flag_P2 && ~flag_P3
            D3=~D3;            
        end
        if ~flag_P1 && ~flag_P2 && ~flag_P3
            D4=~D4;            
        end
    end
    
    temp=[D1 D2 D3 D4];
    
    original=[original temp];
end


end

