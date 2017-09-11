clear
clc

% GROUND TRUTH
gt= load('/home/radam/ground_truth_euroc.csv'); % DONT TOUCH
gt = gt(:,1:8);

% ESTIMATORS
%poses = load('/home/radam/out_pos_LTS_vision_only.txt');
%poses = load('/home/radam/out_pos_tr_1.txt');
poses = load('/home/radam/out_pos_sts_1.txt');

%poses = load('/home/radam/out_pos_LTS_gps_only.txt');
%poses = load('/home/radam/out_pos_LTS_gps_only_2x_meas.txt');
poses = poses(:,1:8); %only looking at positions.
poses(:,2) = poses(:,2)-464980;
poses(:,3) = poses(:,3)-5.27226e+06;
poses(:,4) = poses(:,4)-414.087;

poses_size = size(poses);
gt_size = size(gt);
interpolated_gt = zeros(poses_size(1), 8);
interpolated_gt(:,1) = poses(:,1);



%interpolate true poses and orientations
found_count = 0;
for i=1:poses_size(1)
    row = poses(i,:);
    timestamp = row(1);
    
    % find 2 closest timestamps in gt
    idx_before = [];
    idx_after = [];
    found = false;
    for j=1:gt_size(1)
       timestamp_gt = gt(j,1);
       if (timestamp_gt > timestamp)
            idx_after = j;
            idx_before = j-1;
            found = true;
            found_count = found_count+1;
            break;
       end
    end
    
    if (~found)
        %timestamp
        break;
    end
    
    timestamp_before = gt(idx_before,1);
    timestamp_after= gt(idx_after,1);
    
    if (abs(timestamp - timestamp_before) > abs(timestamp - timestamp_after))
        interpolated_gt(i,2:end) = gt(idx_after,2:8);
    else
        interpolated_gt(i,2:end) = gt(idx_before,2:8);
    end
    
    
    
%     %interpolate below
%     gt_before = gt(idx_before, 2:end);
%     gt_after = gt(idx_after, 2:end);
%     
%     a = (gt_after-gt_before)/(timestamp_after - timestamp_before);
%     b = gt_before - a*timestamp_before;
%     
%     interpolated_gt(i,2:end) = a*timestamp + b;
end


interpolated_gt = interpolated_gt(1:found_count,:);
poses = poses(1:found_count,:);
errors = interpolated_gt - poses(1:found_count,:);
error_magnitude = sqrt(diag(errors(:,2:4) * errors(:,2:4)'));


% convert orientations to rotation angles
[y_m, p_m, r_m] = quat2angle(poses(:,5:8));
[y_gt, p_gt, r_gt] = quat2angle(interpolated_gt(:,5:8));

y_m = wrapTo360(y_m*180/pi);
p_m = wrapTo360(p_m*180/pi);
r_m = wrapTo360(r_m*180/pi);

y_gt = wrapTo360(y_gt*180/pi);
p_gt = wrapTo360(p_gt*180/pi);
r_gt = wrapTo360(r_gt*180/pi);

angle_error = [y_m-y_gt, p_m - p_gt, r_m - r_gt];

timestamps = poses(1:found_count,1);

subplot(7,1,1);
plot(timestamps, errors(:,2))
title('Error X [m]')
grid on
subplot(7,1,2);
plot(timestamps, errors(:,3))
title('Error Y [m]')
grid on
subplot(7,1,3);
plot(timestamps, errors(:,4))
title('Error Z [m]')
grid on
subplot(7,1,4);
plot(timestamps, error_magnitude)
title('Error position magnitude [m]')
grid on
subplot(7,1,5);
plot(timestamps, angle_error(:,1))
title('Error Yaw [deg]')
grid on
subplot(7,1,6);
plot(timestamps, angle_error(:,2))
title('Error Pitch [deg]')
grid on
subplot(7,1,7);
plot(timestamps, angle_error(:,3))
title('Error Roll [deg]')

RMS = sqrt(mean(error_magnitude).^2)


