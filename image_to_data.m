function [bw,dataQ,data] = image_to_data(image, use_hamming)
    im = imread(image);
    bw = im2bw(im,.7);
    [rows, cols] = size(bw);
    data = sign(reshape(bw, 1, []));
    size_data = [de2bi(rows,16, 'left-msb') de2bi(cols,16, 'left-msb')];
    dataS =  horzcat(size_data,data);
    dataH =  addParity(dataS); %hamming code
    if use_hamming
        dataQ = encodeQam(dataH);
    else
        dataQ = encodeQam(dataS);
    end
end