function [X, f] = plot_FT(x, fs);
% plots the magnitude of the Fourier transform of the signal x
% which is assumed to originate from a Continous-time signal 
% sampled with frequency fs
% the function returns X and f.
% X contains the frequency response
% f contains the frequency samples


N = length(x);

X = fftshift(fft(x));
f = linspace(-fs/2, fs/2*(length(x)-1)/length(x), length(x));

figure
plot(f, real(X));
title('FFT Real')
figure
plot(f, imag(X));
title('FFT Imaginery')