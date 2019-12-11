function [rx_ds, err_rate] = qpsk(txname, rxname, fileSize, T, rrc, Fs, pilot_sequence_len)
%%
% Read in the received data
read=read_usrp_data_file(rxname);

seed = 1;
[tx_pilot, startPos] = find_signal_start(seed,pilot_sequence_len,T,rrc,read);
disp(["Start Position: ", startPos]);
if startPos == 0
    startPos = 1;
end

%%
read_shifted=read(startPos+pilot_sequence_len*T:end);
packet_length = fileSize*T;
rx_pilot = read(startPos:startPos+pilot_sequence_len*T-1);
signal_rx = conv(read_shifted(1:packet_length),rrc,'same');

%%
%
tx_data = read_usrp_data_file(txname);

% Downsample TX signal to get original signal
tx_pilot = downsample(conv(tx_data(1:pilot_sequence_len*T),rrc,'same'),T);
tx_data = tx_data(pilot_sequence_len*T:end-1);
tx_conv = conv(tx_data,rrc,'same');
tx_ds = downsample(tx_conv,T);

% manual_phase_offsets = linspace(0, 2*pi, 16);
% best_phase = 0;
% error_rate = 1;

% pilot_offset = rx_pilot ./ tx_pilot
% pilot_offset

[phi, f_delta, offset] = compute_phase_offset(signal_rx,Fs);

% rx_pilot
% for phase = 1:length(manual_phase_offsets)
%     offset_loop = times(offset,exp(manual_phase_offsets(phase)));
%     offset_loop.'
%     rx_pilot_offset=times(rx_pilot,offset_loop.');
%     rx_pilot_ds = downsample(rx_pilot_offset,T);
%     err_rate = compute_qpsk_error(tx_pilot, rx_pilot_ds);
%     if err_rate < error_rate
%         error_rate = err_rate;
%         best_phase = manual_phase_offsets(phase);
%     end
% end
% 
% best_phase
% final_offset = time(offset,exp(best_phase));
% read_offset=times(signal_rx,final_offset.');
read_offset = times(signal_rx,offset.');
% rx_costas = costas(signal_rx);

% Downsample RX signal
% rx_ds = downsample(rx_costas,T);
rx_ds = downsample(read_offset,T);

% Plot real vs imaginary of adjusted rx signal
figure;
plot(real(read_offset),imag(read_offset),'.')
title('RX Signal Adjusted for Phase - Re vs Im')
xlabel('Real Component')
ylabel('Imaginary Component')
% err_rate = "HAHA";
figure;
plot(real(rx_ds), imag(rx_ds),'.')
err_rate = compute_qpsk_error(tx_ds, rx_ds);
