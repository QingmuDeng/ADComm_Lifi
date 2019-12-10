function err = compute_qpsk_error(tx, rx)
    % Find number of errors in real and imaginary components, downsampling the
    % rx signal
    error_real=sign(real(rx))-sign(real(tx));
    error_imag=sign(imag(rx))-sign(imag(tx));
    num_err_real = length(find(error_real~=0));
    num_err_imag = length(find(error_imag~=0));

    % Sum errors and calculate error rate
    err_total = num_err_real + num_err_imag;
    err = err_total/(length(rx)*2);
end