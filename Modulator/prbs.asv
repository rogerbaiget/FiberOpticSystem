function [outputSeq] = prbs(N)
%Bit length of the shiftRegister
shiftRegLength = N;
%Start value of the shiftReg
shiftReg = round(rand(1,shiftRegLength));
while max(shiftReg) == 0
    shiftReg = round(rand(1,shiftRegLength));
end
%Generate output
%Note that this only has length 2^n-1 before it starts repeating
for i = 1:2^shiftRegLength-1

%Pull the output of the register (the last bit)
outputSeq(i)= shiftReg(shiftRegLength);

%Feedback (modulo 2) as implemented on pg 351 of Skolnik
c = xor(shiftReg(shiftRegLength),shiftReg(shiftRegLength-1));

%Insert that value in the beginning and shift the rest to the right
shiftReg = [c shiftReg(1:shiftRegLength-1)];
end

%Check to see how uncorrelated the output is.
% plot(xcorr(outputSeq,outputSeq)/max(xcorr(outputSeq,outputSeq)))
