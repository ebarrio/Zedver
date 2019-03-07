%% Parameters:
clear all, clc, close all
% ADC and input data oscilloscope acquisition
acquisition_rate = 50e3;%Hz
sampling_rate = 250e6;%Hz
top_period = 7600e-9;%s
top_samples_offset = 2000;
histogram_bins = 256;
trigger_bounds = 0;
%Calculated
samples_acquisition = sampling_rate/acquisition_rate;
top_samples = top_period*sampling_rate;
%Transition duration
x1perc = 10; %
x2perc = 90, %
%% Signal generation
signal_template_1 = cast(ones(1,samples_acquisition), 'uint16');
for i = 1:top_samples
    signal_template_1(i+top_samples_offset) = 255;
end
%% Search levels
[top , flat] = zed_state_levels(signal_template_1,0);
top_array = top*(ones(1,length(signal_template_1)));
flat_array = flat*(ones(1,length(signal_template_1)));
%% Transition duration
[tup, tdown] = zed_transition(signal_template_1, x1perc, x2perc);

%% Graphs
figure(1)
hold on
plot(signal_template_1)
plot(flat_array)
plot(top_array)
hold off