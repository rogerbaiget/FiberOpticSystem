function [ S, N ] = carriersAndPhotons( v,Gamma,N0,alfat,thaur,a,I,V,beta,t,delta )
q=1.6*10^(-19);
S=ones(1,length(t));
N=ones(1,length(t));
for i=2:length(t)
    S(i)=S(i-1)+(v*Gamma*a*(N(i-1)-N0)*S(i-1)-v*alfat*S(i-1)+beta*N(i-1)/thaur)*delta;
    N(i)=N(i-1)+(I(i)/(q*V)-N(i-1)/thaur-v*Gamma*a*(N(i-1)-N0)*S(i-1))*delta;
end
end