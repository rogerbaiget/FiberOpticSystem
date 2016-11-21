function [ dades, Eout, Eoutmod, Eoutphase, Pout, Po_norm] = mz_mod( dades, Vpi, Ein, e1, e2)
% Ein -> 1 vectors complexos
% Vu : Input voltage signal
% Vl : Input voltage signal
% Vpi: Required driving voltage for a pi radians phase shift
% Ein: Input electric field 
% Eo : Ein modulus
% Ts : Sample time
% Tl : Light sample time
%dades = (rand(1, 10) >= 0.5);
dades = 1 + cos((0.001:0.001:1) * 10 * pi);
%dades = (rand(1,1000)>0.5)-0.2*rand(1,1000);
d2 = inter(length(Ein), length(dades), dades);
samples = 1:length(Ein);
Eo = abs(Ein);

Ts = 10e-3;
Tl = 10e-6;

Vu = d2;
Vl = zeros(1,length(samples)); 

phi_Ein = phase(Ein);
phi_u = pi * Vu/Vpi;
phi_l = pi * Vl/Vpi; 

fase = (phi_u + phi_l) / 2;
arg = (phi_u - phi_l) / 2;

% Eout = Eo .* cos(arg).*exp(1i * fase);
% Eout = Eo .* sin(arg)  .* exp(1i * (fase + pi/2));

Eout_1 = 0.5 * (coupler(e1,e2)* exp(1i * phi_u) - coupler(-e1, -e2)* exp(1i * phi_l) ) .* Eo ;
Eout = Eout_1;

e_12 = e1 * e2;
sqrt_e1_e2 = sqrt((1-e1^2)*(1-e2^2));
ER1 = (1 + e_12 + sqrt_e1_e2) / (1 + e_12 - sqrt_e1_e2);
Eoutabs = abs(Eout);
Phase = phase(Eout);
Po = Eo.^2;
Pout = Po.* cos(arg).^2; 


Eoutmod = Eoutabs;
Eoutphase = fase;
Po_norm = abs(Eout).^2./Eo.^2;


% plot(ER1)
% title('ER1')
disp(10*log10(ER1));


end

