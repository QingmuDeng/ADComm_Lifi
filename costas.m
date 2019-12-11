function x_hat = costas(rx)
    % Implement costas loop for carrier synchronization
    % rx: received signal

    % Initialize Variables
    % alpha ~ beta/10
    alpha = 0.05;
    beta = 0.9;
    psi_hat = 0;
    
    % y_bar[k]=y[k]/|h|
    h_mag = rms(rx);
    y_bar = rx./h_mag;
    
    % Output, corrected estimate
    x_hat = zeros(length(rx),1);
    
    % Error sum
    % sum(l=0,k,e[l])
    e_sum = 0;
    
    % begin costas loop
    % Steps 4-9 in paper
    for k = 1:length(rx)
        % Correct for phase offset
        x_hat(k) = y_bar(k).*exp(1i.*psi_hat);
        
        % Compute error e[k]
        e = -(1./sqrt(2)).*(sign(real(x_hat(k))).*imag(x_hat(k))) + (1./sqrt(2)).*(sign(imag(x_hat(k))).*real(x_hat(k)));
        e_sum = e_sum + e;
        
        % d[k]=Beta*e[k]+alpha*sum(l=0,k,e[l])
        d = (beta.*e) + (alpha.*e_sum);
        
        % psi_hat[k+1] = psi_hat[k]+d[k]
        psi_hat = psi_hat + d;
        
        % Wrap around psi_hat[k+1]
        if psi_hat < -pi
            psi_hat = psi_hat + 2.*pi;
        elseif psi_hat > pi
            psi_hat = psi_hat - 2.*pi;
        end
        
    end
end