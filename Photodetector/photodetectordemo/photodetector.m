function [ photodetector_i, photodetector_sig, photodetector_SNR, photodetector_BER] = photodetector(E, h, f, responsivity, Tb, Ts, I_d, K, M, Rl, T, Fa, bitsequence, async)


% ------------------------------------------------------------------

% Input parameters

% E --> Electric field of the optical pulse coming from the optical fiber
% in the form:

% / ------Ex (magnitude)---------\
% | ------Ex (phase)    ---------|
% | ------Ey (magnitude)---------|
% \ ------Ey  (phase)   ---------/

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

% Tb --> Bit time

% Ts --> Sampling time

% Bitsequence --> Sequence of bits

% Async --> Boolean value indicating if we want to introduce asynchronies

% ---------------------------------------------------------------------

% Output parameters

% i --> Mean value of the output current (A) as a function of time

% sig --> variance of the output current (A^2) as a function of time

% SNR --> Signal to Noise Ratio as a function of time

% BERmin --> Bit Error Rate with the optimal decision threshold

% ---------------------------------------------------------------------

% Cte definitions

planck = 6.62606957e-34; % (J*s)
e = 1.60217662e-19; % C
Kb = 1.3806488e-23; % J/K

% ----------------------------------------------------------------------

% Duration of a symbol in samples
D = round(Tb/Ts);

% The integral of the impulse response has to be equal to the electron
% charge --> Make sure this is true
q = trapz(h)*Ts;
h = h*e/q;

% Compute the quantum efficiency and the responsivity for the central
% frequency

r_freq = responsivity(1,:);
resp = responsivity(2,:);
if (sum(r_freq == f) ~= 0)
    % If the responsivity is given exactly at the frequency of interest,
    % get it
    r = resp(r_freq==f);
else
    % If the responsivity is not given at the frequency of interest,
    % Interpolate based in the two nearest values
    r = (resp(sum(r_freq<f)) + resp(sum(r_freq<f)+1))/2;
end

nu = planck*f*r/e; % Quantum efficiency


% First step: obtain power from the input electric field
%E_real = sqrt(E(1,:).^2 + E(3,:).^2);
E_real = real(E);
P = abs(E_real).^2;

% figure (1)
% plot(P);
% title('Power signal incident in the photodetector');
% xlabel('Sample number');
% ylabel('Power (Watts)');


% Second step: compute the mean value and deviation of the current
% As the temporal convolutions makes our temporal window wider, we will
% do the convolutions in the Fourier domain and return to the temporal
% domain
N = length(P);
i_pin = abs((nu*Ts/(planck*f))*ifft(fft(P, N).*fft(h, N)));
photodetector_sig = abs((nu*Ts/(planck*f))*ifft(fft(P, N).*fft((h.^2), N)));

% All what has been done above is valid for PIN photodetectors
% ----------------------------------------------------------------

% Now let's model and APD photodetector

% Compute the noise factor
F = K*M + (1-K)*(2-1/M);

% Compute the noise equivalent bandwidth
B = (Ts/(2*e^2))*trapz(h.^2);

% We can now compute the mean value and the deviation of the current
photodetector_i = M*(i_pin + I_d);
photodetector_sig = F*M^2*(photodetector_sig + 2*e*B*I_d);

% Add thermal noise
photodetector_sig = photodetector_sig + 4*Kb*T*B*Fa/Rl;

% figure (2)
% subplot(2,1,1)
% plot(photodetector_i);
% xlabel('sample number (n)');
% ylabel('current (A)');
% title('Current (APD fotodetector)');
% subplot(2,1,2)
% plot(photodetector_sig);
% xlabel('sample number (n)');
% ylabel('deviation (A^2)');
% title('Current deviation (APD fotodetector)');

% -----------------------------------------------------------------

% Sampling times

% we have to differenciate between the cases in which asynchronies exist
% and the case when there's no asynchronies

L = length(photodetector_i);
sampling_vector = D:D:L; % Ideal sampling times. We are making an 
% assumption here: both the conformation pulse and the impulse response 
% are generated in a way in which the ideal sampling time is Tb.

n = 10; % Maximum value of the asynchrony (in samples)

if (async == 1)
    
   % Intoduce a random asynchrony (that can have avalue between -n and n)
   async = randi([-n n],1,length(sampling_vector)-1);
   % To avoid problems, we will suppose that the last value never has
   % asynchrony
   async = [async 0];
   
   sampling_vector = sampling_vector+async;
   
end

% ----------------------------------------------------------------

% Generate the eye diagram with the normal function
samples = normrnd(photodetector_i(sampling_vector), sqrt(photodetector_sig(sampling_vector)));
eyediagram(samples, 2);

% ------------------------------------------------------------------

% SNR calculation as a function of time (includes APD and PIN)

photodetector_SNR = ((M*i_pin).^2)./photodetector_sig;

% figure (4)
% plot(10*log(photodetector_SNR));
% title('SNR of the received signal');
% xlabel('sample number');
% ylabel('SNR(dB)');

% -------------------------------------------------------------------

% BER

% Method 1 (as explained in the report)

% To compute the mean and standard deviation of the zero bits, we compute
% the mean of all the bits corresponding to 0.
samples0 = (bitsequence==0).*(sampling_vector);
samples0(samples0==0) = [];
mu0 = mean(photodetector_i(samples0)); 
sig0 = sqrt(mean(photodetector_sig(samples0)));

% We do the same for the bits 1
samples1 = (bitsequence==1).*(sampling_vector);
samples1(samples1==0) = [];
mu1 = mean(photodetector_i(samples1)); 
sig1 = sqrt(mean(photodetector_sig(samples1)));

% Calculate the BER with the obtained values
Q = (mu1 - mu0)/(sig1+sig0);
photodetector_BER = 0.5*erfc(Q/sqrt(2));
fprintf('The BER is %e \n', photodetector_BER); 


% Method 2 (semianalytic model (as explained in the report))

% We have to make a sweep of the threshold value to see when the mean BER
% is minimum

% We will make a sweep between the maximum value of the '0' samples and
% the minimum value of the '1' sample
minthresh = max(photodetector_i(samples0));
maxthresh = min(photodetector_i(samples1));

% We will try n different thresholds in the range obtained
n = 1000;
pos_thresh = linspace(minthresh, maxthresh, n);

BERmin = 1;
threshold_min = 0;

% Try the different thresholds and compute the mean BER
for j = 1:length(pos_thresh)
    % The BER is simply Q(d/sigma) where d is the distance between 
    % the value and the threshold
    BER0 = qfunc((abs(photodetector_i(samples0)-pos_thresh(j)))./sqrt(photodetector_sig(samples0)));
    BER1 = qfunc((abs(photodetector_i(samples1)-pos_thresh(j)))./sqrt(photodetector_sig(samples1)));
    
    BER = (mean(BER1) + mean(BER0))/2;
    
    if (photodetector_BER < BERmin)
       BERmin = photodetector_BER;
       threshold_min = pos_thresh(j);
    end
    
end

figure(5)
plot(photodetector_i);
hold on;
plot(samples1, photodetector_i(samples1), 'or');
plot(samples0, photodetector_i(samples0), 'ob');
plot(1:length(photodetector_i), threshold_min*ones(1,length(photodetector_i)), 'k');
legend('Received signal','Sample time for 1', 'Sample time for 0', 'Optimal threshold');
xlabel('sample time');
ylabel('Current (A)');
hold off;

fprintf('The BER optimal is %e \n', BERmin); 


end