function [ Windowed_E,t_window ] = E_Window( E,t, pos )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
t_window=t-pos;
Windowed_E=zeros(1,length(t_window));
for i=1:length(t)
    Windowed_E(i-pos)=E(i);
end
end

