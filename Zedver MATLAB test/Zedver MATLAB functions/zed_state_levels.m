function [top, flat] = zed_state_levels (sign, samples_trigger)
histogram_bins = 256;
sign_hist = zed_histogram(sign, histogram_bins);
lower = 1;
upper = histogram_bins;
for i = 1:histogram_bins
    if(sign_hist(i) > samples_trigger)
        low_bin = i;
        break;
    end
end
for i = histogram_bins:-1:1
    if(sign_hist(i) > samples_trigger)
        high_bin = i;
        break;
    end
end
l_low_bin = low_bin;
l_high_bin = low_bin + floor((high_bin - low_bin)/2);
u_low_bin = l_high_bin;
u_high_bin = high_bin;
l_most_samples = 0;
u_most_samples = 0;
length_l_hist_array = (l_high_bin - l_low_bin);
l_hist_array = zeros(1,length_l_hist_array);

for n = 1 : length_l_hist_array
    l_hist_array(n) = sign_hist(l_low_bin + n - 1);
    if (l_hist_array(n) > l_most_samples)
        l_most_samples = n;
    end
end
length_u_hist_array = (u_high_bin - u_low_bin);
u_hist_array = zeros(1,length_u_hist_array);
for n = 1 : length_u_hist_array
    u_hist_array(n) = sign_hist(u_low_bin + n);
    if (u_hist_array(n) > u_most_samples)
        u_most_samples = n;
    end
end
dy = (upper - lower)/histogram_bins;
l_max = l_most_samples;
u_max = u_most_samples;
flat = lower + dy * (l_low_bin + l_max - 1.5);
top = lower + dy * (u_low_bin + u_max - 1.5);
end