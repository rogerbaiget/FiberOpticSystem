function [dades, p] = g_sen(tS, N)
mostres = 100;
p = prbs(N);
samples = mostres/2 * (2^N);

switch(tS)
    case 1
        
        r = r_cos(1, mostres);
        dades = zeros(1,samples); 
        
        for i  = 1:length(p)
            if p(i) > 0
                for j = 1+(i-1)*mostres/2:mostres+(i-1)*mostres/2
                    dades(j) = dades(j) + r(j-(i-1)*mostres/2)  ;
                end
            end
        end
    case 2
        
        t =  [0, conv(ones(1,mostres/2), ones(1,mostres/2)), 0];
        t = t/max(t);
        dades = zeros(1,samples); 
        
        for i  = 1:length(p)
            if p(i) > 0
                for j = 1+(i-1)*mostres/2:mostres+(i-1)*mostres/2
                    dades(j) = dades(j) + t(j-(i-1)*mostres/2)  ;
                end
            end
        end
end
figure(1)
plot(dades)
figure(2)
stem(p)