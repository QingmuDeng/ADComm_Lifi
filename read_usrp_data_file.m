function  y = read_usrp_data_file(filename)
% read data from a file called rx.dat
% created by rx_samples_to_file, or the file sink
% in gnuradio-companion.
% You have to ensure that the program that saves data from the usrp 
% and writes it to the file writes data as  complex
%  floating point numbers. e.g. --format float  for rx_samples_from_file
% and complex for gnuradio companion file sink

    f1 = fopen(filename, 'r');
    tmp = fread(f1,'float32');
    fclose(f1);
    y = tmp(1:2:end)+1i*tmp(2:2:end);
    
end