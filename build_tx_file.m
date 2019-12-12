function build_tx_file(txname, data, pilot_len,ending_len, rrc, T)
    rng(1);
    pilot_seq=sign(sign(randn(pilot_len,1))+1i*sign(randn(pilot_len,1)));
    ending_seq=sign(sign(randn(ending_len,1))+1i*sign(randn(ending_len,1)));

    rng(42);
    rrc = rrc ./ max(rrc);
    dat = [pilot_seq.' data.' ending_seq.'].';
    x_us=upsample(dat,T);
    pulse = rrc;
    x=conv(x_us,pulse,'same');

    write_usrp_data_file(x,txname)
end