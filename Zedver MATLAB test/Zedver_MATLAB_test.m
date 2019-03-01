%% Parameters:
clear all, clc, close all
% ADC and input data oscilloscope acquisition
acquisition_rate = 50e3;%Hz
sampling_rate = 250e6;%Hz
top_period = 7600e-9;%s
top_samples_offset = 2000;
histogram_bins = 256;
%Calculated
samples_acquisition = sampling_rate/acquisition_rate;
top_samples = top_period*sampling_rate;
%% Signal generation
signal_template = cast(zeros(1,samples_acquisition), 'uint16');
for i = 1:top_samples
    signal_template(i+top_samples_offset) = 1;
end
%% Histogram
signal = signal_template;
hist_array =zeros(1,histogram_bins);
for n=1:length(signal)
    hist_array(1,signal(n)+1)=hist_array(1,signal(n)+1)+1; %add 1 into to corresponding bin
end
bar(hist_array)
