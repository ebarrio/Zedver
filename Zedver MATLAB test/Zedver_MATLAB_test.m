% WORK IN PROGRESS %

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
    signal_template(i+top_samples_offset) = round((i*255)/samples_acquisition);
end
figure(1)
plot(signal_template)
%% Histogram
signal = signal_template;
hist_array =zeros(1,histogram_bins);
% Will need later higher and smaller sample
higher_sample_value = 0;
smaller_sample_value = 65535; %16 bits ADC maxium value
higher_sample = 0;
smaller_sample = 0; %16 bits ADC maxium value
for n=1:(length(signal))
    hist_array(1,signal(n)+1)=hist_array(1,signal(n)+1)+1; %add 1 into to corresponding bin
    if(signal(n) > higher_sample_value)
        higher_sample_value = signal(n);
        higher_sample = n;
        break;
    elseif(signal(n) < smaller_sample_value)
        smaller_sample_value = signal(n);
        samller_sample = n;
        break;
    end
end
figure(2)
pause(1)
plot(hist_array)
%% Find the bounds
figure(3)
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



