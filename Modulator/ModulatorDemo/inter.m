function [dades_2] = inter(n2, n1, dades)

r = n2/n1;
dades_2 = ones(1,length(dades) * r);
for l = 1:length(dades)
   for u = 1:1:r
       dades_2(u +r*(l-1)) = dades(l);
   end
end