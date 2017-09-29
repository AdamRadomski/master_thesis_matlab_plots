function [ closest_val ] = closestVal( original_times, values, times )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    s_times = size(times);
    closest_val = zeros(s_times);
    closest_val = interp1(original_times, values, times);
end

