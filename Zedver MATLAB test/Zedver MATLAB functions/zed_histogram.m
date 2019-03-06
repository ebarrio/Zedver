function [hist] = zed_histogram (data, nbins)
data = cast(data, 'uint16');
hist = zeros(1, nbins);
for n = 1:(length(data))
    hist(1,data(n))=hist(1,data(n))+1;
end
end