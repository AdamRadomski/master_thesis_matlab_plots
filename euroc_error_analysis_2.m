clear
clc
close all

% GROUND TRUTH
gt= load('/home/radam/ground_truth_euroc.csv'); % DONT TOUCH
gt(1:2:end,:) = []; % remove every 2nd row
gt(1:2:end,:) = []; % remove every 2nd row
gt(1:2:end,:) = []; % remove every 2nd row
gt = gt(:,1:8);
gt(:,1) = gt(:,1)/1e9;

% ESTIMATORS
poses_sts = load('/home/radam/tests/extensive_testing/euroc/no_lc/out_pos_STS.txt');
%poses_sts = load('/home/radam/out_pos_STS.txt');
poses_lts_no_lc = load('/home/radam/tests/extensive_testing/euroc/no_lc/out_pos_LTS.txt');
poses_lts_lc = load('/home/radam/out_pos_LTS.txt');

poses_sts(:,2:4) = poses_sts(:,2:4)-[464980,5.27226e+06,414.087];
poses_lts_no_lc(:,2:4) = poses_lts_no_lc(:,2:4)-[464980,5.27226e+06,414.087];
poses_lts_lc(:,2:4) = poses_lts_lc(:,2:4)-[464980,5.27226e+06,414.087];

latest_start = FindLatest([poses_sts(1,1) poses_lts_no_lc(1,1) poses_lts_lc(1,1)]);
earliest_end = FindEarliest([poses_sts(end,1) poses_lts_no_lc(end,1) poses_lts_lc(end,1)]);
earliest_end = earliest_end-1; %otherwise problems
gt = RemoveBefore(latest_start, gt);
gt = RemoveAfter(earliest_end, gt);

poses_sts = Align(gt, latest_start, poses_sts);
poses_lts_no_lc = Align(gt, latest_start, poses_lts_no_lc);
poses_lts_lc = Align(gt, latest_start, poses_lts_lc);

errors_sts = gt(:,2:4)-poses_sts(:,2:4);
errors_lts_no_lc = gt(:,2:4)-poses_lts_no_lc(:,2:4);
errors_lts_lc = gt(:,2:4)-poses_lts_lc(:,2:4);

errors_magnitude_sts = sqrt(diag(errors_sts * errors_sts'));
errors_magnitude_lts_no_lc = sqrt(diag(errors_lts_no_lc * errors_lts_no_lc'));
errors_magnitude_lts_lc = sqrt(diag(errors_lts_lc * errors_lts_lc'));

quat_err_sts = quatmultiply(quatinv(gt(:,5:8)),poses_sts(:,5:8));
quat_err_lts_no_lc = quatmultiply(quatinv(gt(:,5:8)),poses_lts_no_lc(:,5:8));
quat_err_lts_lc = quatmultiply(quatinv(gt(:,5:8)),poses_lts_lc(:,5:8));
axang_err_sts = quat2axang(quat_err_sts);
axang_err_lts_no_lc = quat2axang(quat_err_lts_no_lc);
axang_err_lts_lc = quat2axang(quat_err_lts_lc);

[r1 r2 r3] = quat2angle(quat_err_sts); errors_sts_a = [r1 r2 r3]*180/pi;
[r1 r2 r3] = quat2angle(quat_err_lts_no_lc); errors_lts_a_no_lc = [r1 r2 r3]*180/pi;
[r1 r2 r3] = quat2angle(quat_err_lts_lc); errors_lts_a_lc = [r1 r2 r3]*180/pi;

timestamps = gt(:,1);

subplot(8,1,1);
plot(timestamps, errors_sts(:,1))
hold on
plot(timestamps, errors_lts_no_lc(:,1))
hold on
plot(timestamps, errors_lts_lc(:,1))
legend('STS','LTS no LC', 'LTS LC')
title('Error X [m]')
grid on
subplot(8,1,2);
plot(timestamps, errors_sts(:,2))
hold on
plot(timestamps, errors_lts_no_lc(:,2))
hold on
plot(timestamps, errors_lts_lc(:,2))
legend('STS','LTS no LC', 'LTS LC')
title('Error Y [m]')
grid on
subplot(8,1,3);
plot(timestamps, errors_sts(:,3))
hold on
plot(timestamps, errors_lts_no_lc(:,3))
hold on
plot(timestamps, errors_lts_lc(:,3))
legend('STS','LTS no LC', 'LTS LC')
title('Error Z [m]')
grid on
subplot(8,1,4);
plot(timestamps, errors_magnitude_sts)
hold on
plot(timestamps, errors_magnitude_lts_no_lc)
hold on
plot(timestamps, errors_magnitude_lts_lc)
legend('STS','LTS no LC', 'LTS LC')
title('Error position magnitude [m]')
grid on
subplot(8,1,5);
plot(timestamps, errors_sts_a(:,1))
hold on
plot(timestamps, errors_lts_a_no_lc(:,1))
hold on
plot(timestamps, errors_lts_a_lc(:,1))
hold on
legend('STS','LTS no LC', 'LTS LC')
title('Error Yaw [deg]')
grid on
subplot(8,1,6);
plot(timestamps, errors_sts_a(:,2))
hold on
plot(timestamps, errors_lts_a_no_lc(:,2))
hold on
plot(timestamps, errors_lts_a_lc(:,2))
legend('STS','LTS no LC', 'LTS LC')
title('Error Pitch [deg]')
grid on
subplot(8,1,7);
plot(timestamps, errors_sts_a(:,3))
hold on
plot(timestamps, errors_lts_a_no_lc(:,3))
hold on
plot(timestamps, errors_lts_a_lc(:,3))
legend('STS','LTS no LC', 'LTS LC')
title('Error Roll [deg]')
grid on
subplot(8,1,8);
plot(timestamps, axang_err_sts(:,4)*180/pi)
hold on
plot(timestamps, axang_err_lts_no_lc(:,4)*180/pi)
hold on
plot(timestamps, axang_err_lts_lc(:,4)*180/pi)
legend('STS','LTS no LC', 'LTS LC')
title('Error Angle magnitude [deg]')
grid on

RMS_pos_sts = sqrt(mean(errors_magnitude_sts).^2)
RMS_pos_lts_no_lc = sqrt(mean(errors_magnitude_lts_no_lc).^2)
RMS_pos_lts_lc = sqrt(mean(errors_magnitude_lts_lc).^2)
RMS_rot_sts = sqrt(mean((axang_err_sts(:,4)*180/pi).^2))
RMS_rot_lts_no_lc = sqrt(mean((axang_err_lts_no_lc(:,4)*180/pi).^2))
RMS_rot_lts_lc = sqrt(mean((axang_err_lts_lc(:,4)*180/pi).^2))