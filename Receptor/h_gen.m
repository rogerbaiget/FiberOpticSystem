function h = h_gen(Tb, Ts)

% Generates a rectangular pulse impulse response with the given parameters

% Input parameters:
% Tb: Duration of the bit
% Ts: Sample time

% Output parameters:
% h: generated impulse response

D = round(Tb/Ts);

h = ones(1,D);
    
end