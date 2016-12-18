function [ Eout ] = ExtintionRatio( e1, e2, fi_u, fi_l, omega, Eo  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Eout = [];
for i = 1:length(Eo)
    A1 = [sqrt(e1+1), 1i*sqrt(1-e1);
        1i*sqrt(1-e1),sqrt(e1+1)];
    A2 = [sqrt(e2+1), 1i*sqrt(1-e2);
        1i*sqrt(1-e2), sqrt(e2+1)];
    
    D = [exp(1i*fi_u(i)), 0;
        0, exp(1i*fi_l(i))];
    x = [Eo(i)*exp(1i*omega);
        0];
    Eout = [Eout , 0.5*A2*D*A1*x];
end

