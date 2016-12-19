function [ dades,p, Eout, Eoutmod, Eoutphase, Pout, Pout_norm, ER] = mz_mod(Att_in,Att_out,Vpi, Einx, Einy, e1, e2, mT, tS,N, p)


% We choose the input polarizations, our system allows one per modulator
switch(p)
    case 2 %z-cut  "horitzontal"
        %Calculem dades per Einx
        Eo = abs(Einx);
        phi_Ein = angle(Einx); 
    case 1 %xy-cut "vertical" 
        %Calculem dades per Einy
        Eo = abs(Einy);
        phi_Ein = angle(Einy); 
end

% Modeling for a bad connection or change of medium, it attenuates the
% signal
Eo = (1-Att_in).*(1-Att_out)*Eo;

% Step of generating the input signal, that is the information we want to
% transmit
% First of all we generate a sequence of 2^N -1 pseudo random binary bits
% Then it's convolved with an auxiliary signal, that can be chosen from a
% raised cosine or a sawtooth
% Finally, for matlab operation needs is extended to the Eo input
[dades,p] = g_sen(tS, N);

if(length(Eo)>length(dades))
    dades= interp(dades,round(length(Eo)/length(dades)));
else
    dades= decimate(dades,round(length(dades)/length(Eo)));
end

%Un cop sabem les dades que tenim com a input escollim eñ tipus de
%modulador Mach-Zender que volguem amb les seves característiques.
% Once the information signal is generated we select one of the following
% Mach-Zehnder configurations
switch(mT)
    case 1  
        % Unbalanced drive, it has chirp
        Vu = dades;
        Vl = 0;
        disp('Unbalanced')
    case 2  
        % Balanced drive (by default)
        %Only xy-cut
        %Chirp-free
        Vu = dades;
        Vl = -Vu;
        Vpi = 2*Vpi;
        disp('Balanced Drive')
        
    case 3  
        % Differential drive (recommended only for advanced users)
        % Only z-cut
        % Chirp free if Vu = Vl
        % The relation of Vu and Vl can be selected
        Vu = dades;
        Vl = -Vu;
        disp('Differential Drive')
end

% We calculate the phase, and also the chirp 
% Note: the chirp is not the fase, but e^(j * fase)
phi_u = pi * Vu/Vpi;
phi_l = pi * Vl/Vpi;
fase = (phi_u + phi_l) / 2;
arg = (phi_u - phi_l) / 2;

% Finally we add the ER, using the auxiliary function coupler, that is a
% simple calculation
%Eout = 0.5*1i *( coupler(e1, -e2) * exp(1i * phi_u) + coupler(-e1, e2) * exp(1i * phi_l) .* Eo);

Eout = ExtintionRatio(e1,e2,phi_u,phi_l,0,Eo);

Eout1 = Eout(1,:);
Eout2 = Eout(2,:);
Eout = Eout2;

e_12 = e1 * e2;
sqrt_e1_e2 = sqrt((1-e1^2)*(1-e2^2));
ER = (1 - e_12 + sqrt_e1_e2) / (1 - e_12 - sqrt_e1_e2);

% We separate the output electric field in modulus and phase
Eoutmod = abs(Eout);
Eoutphase = angle(Eout);

% Calculate the output power
Po = Eo.^2;
Pout = Po.* cos(arg).^2;
Pout_norm = abs(Eout).^2./Eo.^2;

% % Plotting scripts
% figure
% subplot(2,2,1)       
% plot(Eo, 'g')
% title('Laser signal')
% 
% subplot(2,2,2)      
% 
% plot(dades, 'r')
% ylim([0 2])
% title('Dades')
% 
% subplot(2,2,3)
% plot(Eoutmod, 'r')
% ylim([0 3])
% title('Eout - Mod')
% 
% subplot(2,2,4)
% plot(fase, 'g')
% title('Eout - Fase')
% 
% figure
% plot(Pout, 'g')
% title('Pout')
% 
% figure
% 
% subplot(2,1,1)
% plot(Pout_norm)
% title('Normalized Output Power')
end

