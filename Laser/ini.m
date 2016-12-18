function [ L,N0,thaur,alfas,beta,a,Gamma,f,n1,W,d,fase ] = ini( void )
L=5*10^-4;          %Cavity longitude
N0=1.25*10^18;      %transparency level
thaur=10^-9;        %carrier lifetime
alfas=1000;         %scattering losses
beta=10^(-2);       %spontaneous emission coeficient
a=4.5455e-21;       %gain coefficient
Gamma=0.6;          %Ear/Etot
f=973*10^12;        %frequency
n1=2.618;           %refractive index
W=10^(-5);          %cavity width
d=10^(-6);          %cavity height
fase=pi/4;          %E phase
% confirma = 'f';     %auxiliar for ifs
% %  if I<q*V*Nth/thaur
% %         disp('canvia algun valor tenint en compte que ha de cumplir: I<q*V*Nth/thaur.'); %obligatory condition for a LASER
% %     else
% while true
%     confirma = input('quieres cambiar el valor de alguna variable? <y/n>:','s');
%     if confirma == 'y'
%         while true
%             confirma = input(strcat('¿quieres cambiar el valor de la longitud de la cavidad? (L=',num2str(L),'m^3) <y/n>:'),'s');
%             if confirma == 'y'
%                 L = input('nuevo valor de L:');
%                 confirma = 'f';
%                 break;
%             elseif confirma == 'n'
%                 confirma = 'f';
%                 break;
%             end
%         end
%         while true
%             confirma = input(strcat('¿quieres cambiar el valor de la densidad de treshold de la portadora? (N0=',num2str(N0),'m^-3) <y/n>:'),'s');
%             if confirma == 'y'
%                 N0 = input('nuevo valor de N0:');
%                 confirma = 'f';
%                 break;
%             elseif confirma == 'n'
%                 confirma = 'f';
%                 break;
%             end
%         end
%         while true
%             confirma = input(strcat('¿quieres cambiar el valor del tiempo de vida de la portadora? (thaur=',num2str(thaur),'s) <y/n>:'),'s');
%             if confirma == 'y'
%                 thaur = input('nuevo valor de thaur:');
%                 confirma = 'f';
%                 break;
%             elseif confirma == 'n'
%                 confirma = 'f';
%                 break;
%             end
%         end
%         while true
%             confirma = input(strcat('¿quieres cambiar el valor de las pérdidas por scattering? (alfas=',num2str(alfas),'m^-1) <y/n>:'),'s');
%             if confirma == 'y'
%                 alfas = input('nuevo valor de alfas:');
%                 confirma = 'f';
%                 break;
%             elseif confirma == 'n'
%                 confirma = 'f';
%                 break;
%             end
%         end
%         while true
%             confirma = input(strcat('¿quieres cambiar el valor del coeficiente de emisión espontánea? (beta=',num2str(beta),') <y/n>:'),'s');
%             if confirma == 'y'
%                 beta = input('nuevo valor de beta:');
%                 confirma = 'f';
%                 break;
%             elseif confirma == 'n'
%                 confirma = 'f';
%                 break;
%             end
%         end
%         while true
%             confirma = input(strcat('¿quieres cambiar el valor de la frecuencia? (f=',num2str(f),'Hz) <y/n>:'),'s');
%             if confirma == 'y'
%                 f = input('nuevo valor de f:');
%                 confirma = 'f';
%                 break;
%             elseif confirma == 'n'
%                 confirma = 'f';
%                 break;
%             end
%         end
%         while true
%             confirma = input(strcat('¿quieres cambiar el valor de la Reflectividad? (R=',num2str(R),') <y/n>:'),'s');
%             if confirma == 'y'
%                 R = input('nuevo valor de R:');
%                 confirma = 'f';
%                 break;
%             elseif confirma == 'n'
%                 confirma = 'f';
%                 break;
%             end
%         end
%         while true
%             confirma = input(strcat('¿quieres cambiar el valor del ancho de la cavidad? (W=',num2str(W),'m) <y/n>:'),'s');
%             if confirma == 'y'
%                 W = input('nuevo valor de W:');
%                 confirma = 'f';
%                 break;
%             elseif confirma == 'n'
%                 confirma = 'f';
%                 break;
%             end
%         end
%         while true
%             confirma = input(strcat('¿quieres cambiar el valor de la altura de la cavidad? (d=',num2str(d),'m) <y/n>:'),'s');
%             if confirma == 'y'
%                 d = input('nuevo valor de d:');
%                 confirma = 'f';
%                 break;
%             elseif confirma == 'n'
%                 confirma = 'f';
%                 break;
%             end
%         end
%     elseif confirma == 'n'
%         confirma ='f';
%         break;
%     end
% end