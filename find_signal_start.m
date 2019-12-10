function startPos = find_signal_start(seed, len, T, rrc, rx)
    % seed: seed for random number generator for creating pilot sequence
    % len: length of pilot sequence
    % T: symbol period
    % rrc: Root raised cosine
    % rx: raw received signal
    rng(seed);
    start_seq=sign(sign(randn(len,1))+1i*sign(randn(len,1)));
    start_us=upsample(start_seq,T);

    tx_start = conv(start_us, rrc, 'same');

    %Find cross-correlation of received and transmitted signals
    [r, lags]=xcorr(rx,tx_start);

    % Plot Cross-correlation
    plot(lags,abs(r))
    title('Cross Correlation of Rx and Tx')
    % xlim([-10^5 10^5])
    % ylim([-.2 .2])

    % Find the lag where the cross-correlation of rx/tx is greatest
    % This indicates where the signal begins
    startPos = abs(lags(abs(r) == max(abs(r))));
end