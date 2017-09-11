function [ data_out ] = RemoveBefore( latest_timestamp, data )

iter = 1;
timestamp = data(1,1);
while (timestamp < latest_timestamp)
    timestamp = data(iter,1);
    iter = iter+1;
end

data_out = data(iter-1:end,:);

end

