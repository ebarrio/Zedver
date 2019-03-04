%    Copyright (C)  2019  Eladio Barrio Querol.
%    Permission is granted to copy, distribute and/or modify this document
%    under the terms of the GNU Free Documentation License, Version 1.3
%    or any later version published by the Free Software Foundation;
%    with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
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
%% Signal generation
signal_template = cast(zeros(1,samples_acquisition), 'uint16');
for i = 1:top_samples
    signal_template(i+top_samples_offset) = 255;
end
figure(1)
plot(signal_template)
upper = histogram_bins;
lower = 1;
%% Histogram
signal = signal_template;
hist_array =zeros(1,histogram_bins);
for n=1:(length(signal))
    hist_array(1,signal(n)+1)=hist_array(1,signal(n)+1)+1; %add 1 into to corresponding bin
end
figure(2)
pause(1)
plot(hist_array)
%% Find the bounds
for i = 1:histogram_bins
    if(hist_array(i) > 0)
        low_bin = i;
        break;
    end
end
for i = histogram_bins:-1:1
    if(hist_array(i) > 0)
        high_bin = i;
        break;
    end
end
%% Slice histogram lower (l) and upper (u)
l_low_bin = low_bin;
l_high_bin = low_bin + floor((high_bin - low_bin)/2);
u_low_bin = l_high_bin;
u_high_bin = high_bin;
l_most_samples = 0;
u_most_samples = 0;
%Lower histogram
length_l_hist_array = (l_high_bin - l_low_bin);
l_hist_array = zeros(1,length_l_hist_array);
for n = 1 : length_l_hist_array
    l_hist_array(n) = hist_array(l_low_bin + n - 1);
    if (l_hist_array(n) > l_most_samples)
        l_most_samples = n;
    end
end
%Upper histogram
length_u_hist_array = (u_high_bin - u_low_bin);
u_hist_array = zeros(1,length_u_hist_array);
for n = 1 : length_u_hist_array
    u_hist_array(n) = hist_array(u_low_bin + n);
    if (u_hist_array(n) > u_most_samples)
        u_most_samples = n;
    end
end
dy = (upper - lower)/histogram_bins;
%% Method 1
l_max = l_most_samples;
u_max = u_most_samples;
flat_signal = lower + dy * (l_low_bin + l_max - 1.5)
top_signal = lower + dy * (u_low_bin + u_max - 1.5)