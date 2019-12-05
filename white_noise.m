rng(42);
N=100000;
% Generate an array of white noise
dat = (sign(randn(N,1))+j*sign(randn(N,1)))*1/sqrt(2);

write_usrp_data_file(dat, 'white_noise.dat');

%read = read_usrp_data_file