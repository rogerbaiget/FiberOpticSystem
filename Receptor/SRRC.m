function y = SRRC(t, beta, D, Ts)

% Returns the square-root raised cosine at times t

% Input parameters:
% t: times in which we sample
% beta : roll-off factor
% D : duration of a symbol (in samples)
% Ts: sampling time

T = D*Ts; % symbol time

y = zeros(1, length(t));

for i = 1:length(t)

    if abs(t(i)) <= (1-beta)*T/2 

        y(i) = 1;

    elseif (abs(t(i)) > (1-beta)*T/2 ) && (abs(t(i)) <= (1+beta)*T/2)

        y(i) = 0.5*(1+cos(pi*(1/(beta*T))*(abs(t(i))-(1-beta)*T/2)));

    else

        y(i) = 0;

    end

end

y = sqrt(y);

end
