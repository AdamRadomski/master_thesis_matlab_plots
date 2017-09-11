function [ out_estimator ] = Align( pix4d, start, estimator )
    
    out_estimator= zeros(size(pix4d));
    int = interp1q(estimator(:,1), estimator(:,2:4),pix4d(:,1));
    
    out_estimator(:,1) = pix4d(:,1);
    out_estimator(:,2:4) = int;
    
    %interpolate quaternions. Find quaternion before and after for each
    %timestamp.
    
    [r,c] = size(pix4d);
    for i = 1:r
        timestamp = pix4d(i,1);
        % find timestamp later than given one
        iter = 1;
        while (estimator(iter,1) < timestamp)
           iter = iter+1; 
        end
        
        timestamp_after = estimator(iter,1);
        timestamp_before = estimator(iter-1,1);
        
        quat_after = estimator(iter,5:8);
        quat_before = estimator(iter-1,5:8);      
        
        fraction = (timestamp - timestamp_before)/(timestamp_after- timestamp_before);
        quat_int = quatinterp(quat_before,quat_after, fraction,'slerp');
        
        out_estimator(i, 5:8) = quat_int;
    end   
end

