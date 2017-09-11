function [ latest ] = FindLatest( timestamps )

    latest = 0;

    for ts = timestamps
       if (latest < ts)
           latest = ts;
       end
    end
end

