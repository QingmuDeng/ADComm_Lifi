function [rx_ds, err_rate] = qpsk(txname, rxname, pulseWidth, Fs)
%%
% Read in the received data
read=read_usrp_data_file(rxname);

T = pulseWidth; % Symbol Period
span = 20;
rolloff = 0.5;
pilot_sequence_len = 32;
ending_sequence_len = 32;
seed = 1;
rrc = rcosdesign(rolloff,span,T, 'sqrt');
[startPos endPos] = find_signal_start(seed,pilot_sequence_len,ending_sequence_len,T,rrc,read)
if startPos == 0
    startPos = 1;
end

%%
read_shifted=read(startPos+pilot_sequence_len*T:end);
packet_length = endPos - startPos - pilot_sequence_len*T;
rx_st = read(startPos:startPos+pilot_sequence_len*T);
signal_rx = conv(read_shifted(1:packet_length),rrc,'same');

%%
[phi, f_delta, offset] = compute_phase_offset(signal_rx,Fs);
read_offset=times(signal_rx,offset.');

% Plot real vs imaginary of adjusted rx signal
figure
plot(real(read_offset),imag(read_offset),'.')
title('RX Signal Adjusted for Phase - Re vs Im')
xlabel('Real Component')
ylabel('Imaginary Component')

%%
tx_data = read_usrp_data_file(txname);

% Downsample TX signal to get original signal
tx_pilot = tx_data(1:pilot_sequence_len*T);
tx_data = tx_data(pilot_sequence_len*T:end-ending_sequence_len*T-1);
tx_ds = downsample(tx_data,T);

% Downsample RX signal
rx_ds = downsample(read_offset,T);

plot(real(rx_ds), imag(rx_ds),'.');

length(tx_ds)
length(rx_ds)
err_rate = compute_qpsk_error(tx_ds, rx_ds);
