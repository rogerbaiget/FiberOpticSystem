function [output] = sym_ssf(zfinal,h,beta2,w,input_t,alpha)
    % Split-Step Fourier Algorithm
    %
    % ==Inputs==
    % zfinal = Simulation distance
    % h = Simulation step
    % beta2 = chromatic dispersion parameter
    % w = angular frequency window
    % input_t = Input field in the time domain
    % alpha = Attenuation
    %
    % ==Outputs==
    % output = Output field in the time domain
    %
    
    uf0 = fft(input_t(1,:));
    uf0 = fftshift(uf0);

    op_pulse(1,:)=ifft(input_t);
    
    M = zfinal/h; % Partition Number
    Dh = exp((h/2)*(-alpha/2+(1i/2)*beta2*w.^2)); % Dispersion Exp. operator
    for k = 1:M
         % Propagation
         uf0 = uf0.*Dh;
         u3e = ifft(uf0);
         u3ei = u3e.*conj(u3e);
               
         
         op_pulse=u3e;      
         
    end
    output = op_pulse;
end