function [phi, f_delta, offset] = compute_phase_offset(rx, fs, diff)
    % Solve for phi
    % y[k]=x[k]e^j*(f_delta*k+phi)+n[k]
    % x[k]=e^j(pi/4 + m*pi/2)
    % y[k]^4 = e^(j*pi) * e^(4*f_delta*k+4*theta)
    y_norm=rx./rms(abs(rx));
    y_norm_4=y_norm.^4;

    % Find the maximum values of the real and imaginary components of the fft
    % of y[k]^4
    fft_y = fftshift(fft(y_norm_4));
    fft_x = 2*pi*linspace(-fs/2, fs/2*(length(y_norm_4)-1)/length(y_norm_4), length(y_norm_4));
    
    abs_max = max(abs(fft_y));
    real_max = real(fft_y(abs(fft_y)==abs_max));
    im_max = imag(fft_y(abs(fft_y)==abs_max));
%     real_max = max(real(fft_y));  & Don't look at max but look at same
%     location
%     real_min = min(real(fft_y));
%     if abs(real_min) > abs(real_max)
%         real_max = real_min;
%     end
%     im_max = max(imag(fft_y));
%     im_min = min(imag(fft_y));
%     if abs(im_min) > abs(im_max)
%         im_max = im_min;
%     end
    

    figure
    plot(fft_x,abs(fft_y))
    title('phase abs')
    figure
    plot(fft_x,real(fft_y))
    title('phase real')
    figure
    plot(fft_x,imag(fft_y))
    title('phase real')
    % 4*phi + pi = atan(im_max / real_max)
    phi = (atan(im_max/real_max)-diff)% - pi)/4;

    % Find complex exponential to adjust for phase offset
%     f_delta = fft_x(real(fft_y)==real_max)/4; % adjusts for clocks being unsynchronized
    f_delta = fft_x(abs(fft_y)==abs_max)/4;
    k=1:length(rx);
    offset=exp(-1i.*(f_delta.*(k-1).*1/fs+phi));%+pi/4));
end