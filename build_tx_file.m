function tx_data = build_tx_file(txname, data, pilot_len, rrc, T, packet_len)
    rng(1);
    pilot_seq=sign(sign(randn(pilot_len,1))+1i*sign(randn(pilot_len,1)));
    %ending_seq=sign(sign(randn(ending_len,1))+1i*sign(randn(ending_len,1)));
    
    rng(42);
    rrc = rrc ./ max(rrc);
    curr_size = length(data) + length(pilot_seq);
    dat = [pilot_seq.' data.' zeros(1,packet_len-curr_size)].'; % ending_seq.'].';
    x_us=upsample(dat,T);
    pulse = rrc;
    tx_data=conv(x_us,pulse,'same');
    
    write_usrp_data_file(tx_data,txname)
end