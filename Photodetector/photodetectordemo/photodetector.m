
function [ i, sig, SNR, BER] = photodetector(E, h, f, responsivity, D, I_d, K, M, Rl, T, Fa, Ts)


% ------------------------------------------------------------------

% Input parameters

% E --> Electric field of the optical pulse coming from the optical fiber
% in the form:

% / ------Ex (magnitude)---------\
% | ------Ex (phase)    ---------|
% | ------Ey (magnitude)---------|
% \ ------Ey   (phase)  ---------/

% h --> Impulse response of the detector in the tempora domain

% f --> central frequency of the carrier (Hz)

% Responsivity --> Responsivity of the material as a function of the
% frequency (A/W)

% / f1 f2 ... \
% \ r1 r2 ... /

% D --> Duration of the symbol (in samples)

% I_d --> Dark current (A)

% K --> For the calculation of noise factor (APD only) (unitless)

% M (for APD only) --> multiplicative gain (if not APD --> M = 1)

% Rl --> Equivalentr resistance for thermal noise (Ohm)

% T --> Equivalent temperature of the photodetector (K)

% Fa --> RF amplifier noise factor 

% Ts --> Sampling time

% ---------------------------------------------------------------------

% Output parameters

% i --> Mean value of the output current (A)

% sig --> standard deviation of the output current (A^2)

% ---------------------------------------------------------------------

% Cte definitions

planck = 6.62606957e-34; % (J*s)
e = 1.60217662e-19; % C
Kb = 1.3806488e-23; % J/K
% ----------------------------------------------------------------------


E_real = sqrt(E(1,:).^2 + E(3,:).^2);

% The integral of the impulse response has to be equal to the electron
% charge
q = trapz(h)*Ts;
h = h*e/q;

% % Compute the fft to obtain the central frequency
% E_spectrum = fft(E_real);
% f_vector = Fs*(0:(L/2))/L; % frequency vector
% 
% % The central frequency will be the frequency corresponding to the maximum
% % of the spectrum
% f = f_vector(E_spectrum == max(E_spectrum)); % f in Hz

% Compute the quantum efficiency and the responsivity for the central
% frequency
r_freq = responsivity(1,:);
resp = responsivity(2,:);
if (sum(r_freq == f) ~= 0)
    r = resp(r_freq==f);
else
    % Interpolate based in the two nearest values
    r = (resp(sum(r_freq<f)) + resp(sum(r_freq<f)+1))/2;
end

nu = planck*f*r/e;

% First step: obtain power from the input electric field

P = abs(E_real).^2;

% Second step: compute the mean value and deviation of the current

i_pin = (nu/(planck*f))*conv(P,h)*Ts;
sig = (nu/(planck*f))*conv(P,h.^2)*Ts;

figure (1)
subplot(2,1,1)
plot(i_pin);
xlabel('sample number (n)');
ylabel('current (A)');
title('Current (PIN fotodetector)');
subplot(2,1,2)
plot(sig);
xlabel('sample number (n)');
ylabel('deviation (A^2)');
title('Current deviation (PIN fotodetector)');

% All what has been done above is valid for PIN photodetectors
% ----------------------------------------------------------------

% Now let's model and APD photodetector

% Compute the noise factor
F = K*M + (1-K)*(2-1/M);



% Compute the noise equivalent bandwidth
B = (1/(2*e^2))*trapz(h.^2)*Ts;

% We can now compute the mean value and the deviation of the current

i = M*(i_pin + I_d);
sig = F*M^2*(sig + 2*e*B*I_d);

% Add thermal noise
sig = sig + 4*Kb*T*B*Fa/Rl;

figure (2)
subplot(2,1,1)
plot(i);
xlabel('sample number (n)');
ylabel('current (A)');
title('Current (APD fotodetector)');
subplot(2,1,2)
plot(sig);
xlabel('sample number (n)');
ylabel('deviation (A^2)');
title('Current deviation (APD fotodetector)');

% -----------------------------------------------------------------

% Generate the eye diagram with the normal function
L = length(i);
samples = normrnd(i(D:D:L), sig(D:D:L));

% figure (3)
% plot(i, 'r');
% hold on;
% plot(D:D:L, samples, 'ob');
% legend('mean value (A)', 'sample value (A)');
% hold off;

eyediagram(samples, 2);


% ------------------------------------------------------------------

% SNR calculation as a function of time (includes APD and PIN)

SNR = ((M*i_pin).^2)./sig;

figure (5)
plot(10*log(SNR));
xlabel('sample number');
ylabel('SNR(dB)');

% -------------------------------------------------------------------

% BER

mu0 = min(i); 
mu1 = max(i);
sig0 = sqrt(min(sig));
sig1 = sqrt(max(sig));

Q = (mu1 - mu0)/(sig1+sig0);
BER = 0.5*erfc(Q/sqrt(2));
fprintf('The BER is %e \n', BER); 


end