%% Parameters:
clear all, clc, close all
% ADC and input data oscilloscope acquisition
acquisition_rate = 50e3;%Hz
sampling_rate = 250e6;%Hz
top_period = 7600e-9;%s
%Calculated
samples_acquisition = sampling_rate/acquisition_rate;
top_samples = top_period*sampling_rate;
