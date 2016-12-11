clear all
close all

% Simulates the photodetector with an input optical signal generated
% with a Root Raised cosine filters. The impulse response of the 
% photodetector is also a RRC pulse.
% The script makes a sweep of the roll-off factors of both p(t) and h(t)
% to compare the performance of the system.

% Parameters of the photodetector
f = 193e12; % Central frequency: 1550 nm --> 193 THz
responsivity = [ 193e12 ; 0.7]; % for InGaAs
I_d = 0; % Dark current (A)
K = 0.4; % for InGaAs
M = 1; % Multiplicative factor (1 if it is a PIN photodetector)
Rl = 50; % Ohm
T = 273; % K
Fa = 3; % Noise figure if the whole receiver
Ts = 1e-11; % sampling time in seconds
Tb = 100e-11; % duration of the bits in seconds
Epulse = 1e-15; % energy of the comformation pulse p(t) in Joules
len = 50; % length of the bit sequence


sweep = 0.1:0.1:1; % We will make a sweep of the roll off factor 
                   % in steps of 0.1
                   
BER = zeros(length(sweep), length(sweep)); % Matrix to store the BER values
                                           % for the different parameters

for dp = 0.1:0.1:1
    for dh = 0.1:0.1:1
        % dp = roll-off factor of p(t)
        % dh = roll-off factor of h(t)
        [P, bits] = RRC_gen(Tb,  Ts, Epulse, 1, dh, len); % Generate the optical signal (RRC RZ)
        % [E, bits] = RRC_gen(Tb,  Ts, Epulse, 0, dh, len); % Generate the optical signal (RRC NRZ)
        
        D = round(Tb/Ts);
        h = (SRRC(-D*Ts:Ts:(D-1)*Ts, dp, D/2, Ts)).^2; % Generate the impulse response (RRC RZ)
        % h = (SRRC(-D*Ts:Ts:(D-1)*Ts, dp, D, Ts)).^2; % Generate the impulse response (RRC NRZ)
        
        [i, sigma, SNR, BER(round(dp*10),round(dh*10))] = photodetectorSRRC(P(1,:), h, f, responsivity, ...
            Tb, Ts, I_d, K, M, Rl, T, Fa, bits, 0); % Obtain the performance of the system using the
        % photodetector function
        pause
        
    end 
end


figure (1)
% Show the performance for the different values of the roll-off factor
image(0.1:0.1:1, 0.1:0.1:1, BER, 'CDataMapping','scaled');
xlabel('Roll-off factor of p(t)');
ylabel('Roll-off factor of h(t)');
title('BER');
colorbar
