function [P, bits] = RRC_gen(Tb,  Ts, Epulse, pulse, beta, len)

% Generates an optical signal with the parameters given, using
% as conformation pulse a Root Raised Cosine

% Input parameters

% Tb: Bit time

% Ts: Sample time

% Epulse: Energy of the pulse

% pulse: Conformation pulse we want to use
% 0 --> RRC pulse NRZ
% 1 --> RRC pulse RZ

% Beta: roll-off factor

% length: length (in bits) of the transmitted signal

% -------------------------------------------------------
% Output parameters

% P: generated optical power signal

% bits: sequence of bits corresponding to the generated signal
% -------------------------------------------------------

% Duration of a bit in samples
D = round(Tb/Ts);

% First, generate randomly the sequence of bits
bits = randi([0,1],1,len);


% Create the matrix that will store the generated optical signal
P = zeros(1,(len+1)*D);

% As it is only for testing purposes, we will generate
% signal in x polarization only
if pulse == 0
    
   % SRRC NRZ
   p = (SRRC(-D*Ts:Ts:(D-1)*Ts, beta, D, Ts)).^2;

   % normalize to have unitary energy
   energy = trapz(p)*Ts;
   p = p*Epulse/energy;
   
   % generate the signal
   for i = 0:len-1
    P(i*D+1:(i+2)*D) = P(i*D+1:(i+2)*D) + bits(i+1)*p;
   end
   
   P = P(1:len*D);

elseif pulse == 1
    
   % SRRC RZ
     
   p = SRRC(-D*Ts:Ts:(D-1)*Ts, beta, D/2, Ts).^2;
   
   % normalize to have unitary energy
   energy = trapz(p.^2)*Ts;
   p = p*Epulse/energy;

   % generate the signal
   for i = 0:len-1
    P(i*D+1:(i+2)*D) = P(i*D+1:(i+2)*D) + bits(i+1)*p;
   end
    P = P(1:len*D);

end 

end