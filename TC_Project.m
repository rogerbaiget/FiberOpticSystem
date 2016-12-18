% TC Project
clc;
clear all;
%% Paths
addpath('Images');
addpath('Laser');
addpath('Modulator');
addpath('Fiber');
addpath('Amplifier');
addpath('Photodetector');
addpath('Menus');
addpath('ModulatorDemo');
addpath('Photodetector\photodetectordemo');
%% Inputs

%% General Paramenters
global general_Rb;
global general_N;
global general_S;
global general_L;
global general_Rs;
global general_Tb;
global general_TW;
global general_Af;
global general_Ts;

%% Laser parameters
global laser_flagmodulate;

%% Modulator parameters
global modulator_modulationType;
global modulator_testSequence;
global modulator_Vpi;
global modulator_Att_in;
global modulator_Att_out;
global modulator_polaritzation;
global modulator_executionRate;
global modulator_E1;
global modulator_E2;




%% FO paramenters
global fiber_L;
global fiber_alpha;
global fiber_D;
global fiber_S;
%% Amplifier parameters
global amplifier_L;
global amplifier_G;
global amplifier_Psat;

%% Photodetector parameters
global photodetector_H;
global photodetector_M; 

%% Variables and Output



%% Modulator Output

global modulator_Eout;
global modulator_Eout_mod;
global modulator_Eout_phase;
global modulator_Pout;
global modulator_Pout_normalized;
global modulator_testSequenceData;
%% FO output

%% Amplifier output

%% Photodetector output
global photodetector_i;
global photodetector_sig;
global photodetector_SNR;
global photodetector_BER;




%% Run
% Execute Simulator
Simulator;


