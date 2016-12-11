clear all
close all

% Simulates the photodetector with an input optical signal generated
% with a rectangular pulse as a conformation pulse. The
% impulse response of the photodetector is also a rectangular pulse.


% Parameters of the photodetector
f = 193e12; % Central frequency: 1550 nm --> 193 THz
responsivity = [ 193e12 ; 0.7]; % responsivity of 0.7 for InGaAs
I_d = 5e-12; % Dark current (A)
K = 0.4; % for InGaAs (for calculation of the noise factor when APD model is used)
M = 1; % Multiplicative factor (1 if it is a PIN photodetector)
Rl = 5000; % Equivalent resistance for thermal noise (Ohms)
T = 100; % Equivalent temperature of the photodetector (Kelvin)
Fa = 3; % Noise figure of the whole receiver
Ts = 1e-11; % sampling time in seconds
Tb = 100e-11; % duration of the bits in seconds
Epulse = 1e-12; % energy of the comformation pulse p(t) in Joules
len = 50; % length of the bit sequence
% ---------------------------------------------------------

[E, bits] = signal_gen(Tb,  Ts, Epulse, 0, len); % Generate an optical signal with square pulses NRZ as
                                                 % conformation pulses
h = h_gen(Tb, Ts); % Generate a low-pass filter as the impulse response of the photodetector
[i, sigma, SNR, BER] = photodetector(E, h, f, responsivity, Tb, Ts, I_d, K, M, Rl, T, Fa, bits, 1);
 
