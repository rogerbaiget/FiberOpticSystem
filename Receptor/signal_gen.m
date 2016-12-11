function [E, bits] = signal_gen(Tb,  Ts, Epulse, pulse, len)

% Generates an optical signal with the parameters given

% Input parameters:

% Tb: Bit time
% Ts: Sample time
% Epulse: Energy of the pulse

% pulse: Conformation pulse we want to use
% 0 --> Rectangular pulse NRZ
% 1 --> Rectangular pulse RZ
% 2 --> SRRC pulse NRZ with roll-off factor 0.5
% 3 --> SRRC pulse RZ with roll-off factor 0.5

% length: length (in bits) of the transmitted signal

% -------------------------------------------------------

% Output parameters

% E: generated optical signal in the form:

% / ------Ex (magnitude)---------\
% | ------Ex (phase)    ---------|
% | ------Ey (magnitude)---------|
% \ ------Ey  (phase)   ---------/

% bits: sequence of bits corresponding to the generated signal

% -------------------------------------------------------

% Duration of a bit in samples
D = round(Tb/Ts);

% First, generate randomly the sequence of bits
bits = randi([0,1],1,len);


% Create the matrix that will store the generated optical signal
E = zeros(4, len*D);

% As it is only for testing purposes, we will generate
% signal in x polarization only

if pulse == 0
    
   % Rectangular pulse NRZ
   p = ones(1,D);
   % Normalize to obtain the energy desired
   energy = trapz(p.^2)*Ts;
   p = p*Epulse/energy;

   % Generate the signal
   for i = 0:len-1
    E(1, (D*i+1):(D*(i+1))) = bits(i+1)*p;
   end
   
elseif pulse == 1
   % Rectangular pulse RZ
   
   p = zeros(1,D);
   p(D/4:3*D/4) = 1;
   % Normalize to obtain the energy desired
   energy = trapz(p.^2)*Ts;
   p = p*Epulse/energy;
   
   % Generate the signal
   for i = 0:len-1
    E(1, (D*i+1):(D*(i+1))) = bits(i+1)*p;
   end
        
        
elseif pulse == 2
   % SRRC NRZ
   E = zeros(4,(len+1)*D);
   
   beta = 0.5; % We use a fixed roll-off factor
   
   % SRRC NRZ
   p = (SRRC(-D*Ts:Ts:(D-1)*Ts, beta, D, Ts)).^2;

   % normalize to have unitary energy
   energy = trapz(p)*Ts;
   p = p*Epulse/energy;
   
   
   % generate the signal
   for i = 0:len-1
    E(1, i*D+1:(i+2)*D) = E(1, i*D+1:(i+2)*D) + bits(i+1)*p;
   end
   
   E = E(:,1:len*D);

elseif pulse == 3
    
   % SRRC RZ
   E = zeros(4,(len+1)*D);
   
   beta = 0.5; % We use a fixed roll-off factor
   
   p = SRRC(-D*Ts:Ts:(D-1)*Ts, beta, D/2, Ts).^2;
   
   % normalize to have unitary energy
   energy = trapz(p.^2)*Ts;
   p = p*Epulse/energy;

   % generate the signal
   for i = 0:len-1
    E(1, i*D+1:(i+2)*D) = E(1, i*D+1:(i+2)*D) + bits(i+1)*p;
   end
    E = E(:,1:len*D);

end 

end