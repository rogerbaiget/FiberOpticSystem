function [out] = r_cos(T, mostres)
%d_raised_cos = 1 + cos((1/mostres:1/mostres:1) * 10 * pi);
out = 1 + cos((1/mostres:1/mostres:1) * 2*T * pi - pi);