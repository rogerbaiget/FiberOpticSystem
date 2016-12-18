function [ Pout ] = Obtain_Pout( S, f, R , v, W, d)
%S = photon density
%f = frequency
%R = Reflectivity
%v = velocity of electrons in a particular medium
%W = cavity width
%d = cavity height
%h = Plank constant
h=6.63*10^(-34);
Pout=((1-R)/2*sqrt(R))*S*v*W*d*h*f;
end