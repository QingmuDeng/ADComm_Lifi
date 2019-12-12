function [startPos endPos] = find_signal_start(seed, slen, elen, T, rrc, rx)
    % seed: seed for random number generator for creating pilot sequence
    % len: length of pilot sequence
    % T: symbol period
    % rrc: Root raised cosine
    % rx: raw received signal
    rng(seed);
    start_seq=sign(sign(randn(slen,1))+1i*sign(randn(slen,1)));
    ending_seq=sign(sign(randn(elen,1))+1i*sign(randn(elen,1)));
    start_us=upsample(start_seq,T);
    end_us=upsample(ending_seq,T);

    tx_start = conv(start_us, rrc, 'same');

    %Find cross-correlation of received and transmitted signals
    [r, lags]=xcorr(rx,tx_start);

    % Plot Cross-correlation
    plot(lags,abs(r))
    title('Cross Correlation of Rx and Tx Start')
    % xlim([-10^5 10^5])
    % ylim([-.2 .2])

    % Find the lag where the cross-correlation of rx/tx is greatest
    % This indicates where the signal begins
    startPos = abs(lags(abs(r) == max(abs(r))));
    
    tx_end = conv(end_us, rrc, 'same');

    %Find cross-correlation of received and transmitted signals
    [r, lags]=xcorr(rx,tx_end);

    % Plot Cross-correlation
    plot(lags,abs(r))
    title('Cross Correlation of Rx and Tx End')
    % xlim([-10^5 10^5])
    % ylim([-.2 .2])

    % Find the lag where the cross-correlation of rx/tx is greatest
    % This indicates where the signal begins
    endPos = abs(lags(abs(r) == max(abs(r))));
    
    
    
end