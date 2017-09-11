clear
clc

pix4d = load('/home/radam/pix4dUTM.txt'); % DONT TOUCH
%poses = load('/home/radam/out_pos.txt');
poses = load('/home/radam/out_pos_LTS.txt'); poses(:,1) = poses(:,1)*1e9;
%poses = load('/home/radam/tests/test STS with gps LTS without until crash and LTS rotates v/out_pos_STS.txt');

poses = poses(100:end,:);

%%
poses_size = size(poses);
pix4d_size = size(pix4d);
interpolated_poses = zeros(poses_size(1), pix4d_size(2));
interpolated_poses(:,1) = poses(:,1);


%%
%interpolate true poses and orientations
found_count = 0;
for i=1:poses_size(1)
    row = poses(i,:);
    timestamp = row(1);
    
    
    % find 2 closest timestamps in pix4d
    idx_before = [];
    idx_after = [];
    found = false;
    for j=1:pix4d_size(1)
       timestamp_pix4d = pix4d(j,1);
       if (timestamp_pix4d > timestamp)
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
    
    timestamp_before = pix4d(idx_before,1);
    timestamp_after= pix4d(idx_after,1);
    pix4d_before = pix4d(idx_before, 2:end);
    pix4d_after = pix4d(idx_after, 2:end);

    a = (pix4d_after-pix4d_before)/(timestamp_after - timestamp_before);
    b = pix4d_before - a*timestamp_before;
    
    interpolated_poses(i,2:end) = a*timestamp + b;
    
end
%%

% convert orientations to yaw/pitch/roll
[y, p, r] = quat2angle(poses(:,5:8));
y = y*180/pi;
p = p*180/pi;
r = r*180/pi;
poses = [poses(:,1:4),y,p,r];

interpolated_poses = interpolated_poses(1:found_count,:);
errors = interpolated_poses - poses(1:found_count,:);
error_magnitude = sqrt(diag(errors(:,2:4) * errors(:,2:4)'));

timestamps = poses(1:found_count,1);

subplot(7,1,1);
plot(timestamps, errors(:,2))
title('Error X')
grid on
subplot(7,1,2);
plot(timestamps, errors(:,3))
title('Error Y')
grid on
subplot(7,1,3);
plot(timestamps, errors(:,4))
title('Error Z')
grid on
subplot(7,1,4);
plot(timestamps, error_magnitude)
title('Error position magnitude')
grid on
grid on
subplot(7,1,5);
plot(timestamps, errors(:,5))
title('Error Yaw')
grid on
subplot(7,1,6);
plot(timestamps, errors(:,6))
title('Error Pitch')
grid on
subplot(7,1,7);
plot(timestamps, errors(:,7))
title('Error Roll')



