function [ earliest ] = FindEarliest( timestamps )
    earliest = realmax;

    for ts = timestamps
       if (ts < earliest)
           earliest = ts;
       end
    end
end

