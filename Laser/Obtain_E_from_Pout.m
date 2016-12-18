function [ E ] = Obtain_E_from_Pout( Pout, fase )
E = sqrt(Pout).*exp(1j*fase);
end