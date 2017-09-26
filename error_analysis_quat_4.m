clear
clc
close all

%%
pix4d = load('/home/radam/tests/extensive_testing/pix4dUTM_quat_4.txt'); % DONT TOUCH


% without LC
%poses_sts = load('/home/radam/TODOs/Recordings/STS LTS constraint/independent/out_pos_STS.txt');
%poses_lts = load('/home/radam/TODOs/Recordings/STS LTS constraint/independent/out_pos_LTS.txt');
%pix4d = pix4d(1:1540,:);

% with LC
poses_sts = load('/home/radam/TODOs/Recordings/STS LTS constraint/closing/out_pos_STS.txt');
poses_lts = load('/home/radam/TODOs/Recordings/STS LTS constraint/closing/out_pos_LTS.txt');
pix4d = pix4d(1:1540,:);

latest_start = FindLatest([poses_sts(1,1) poses_lts(1,1)]);
pix4d = RemoveBefore(latest_start, pix4d);

poses_sts = Align(pix4d, latest_start, poses_sts);
poses_lts = Align(pix4d, latest_start, poses_lts);

errors_sts = pix4d(:,2:4)-poses_sts(:,2:4);
errors_lts = pix4d(:,2:4)-poses_lts(:,2:4);

errors_magnitude_sts = sqrt(diag(errors_sts * errors_sts'));
errors_magnitude_lts = sqrt(diag(errors_lts * errors_lts'));

quat_err_sts = quatmultiply(quatinv(pix4d(:,5:8)),poses_sts(:,5:8));
quat_err_lts = quatmultiply(quatinv(pix4d(:,5:8)),poses_lts(:,5:8));
axang_err_sts = quat2axang(quat_err_sts);
axang_err_lts = quat2axang(quat_err_lts);

[r1 r2 r3] = quat2angle(quat_err_sts); errors_sts_a = [r1 r2 r3]*180/pi;
[r1 r2 r3] = quat2angle(quat_err_lts); errors_lts_a = [r1 r2 r3]*180/pi;

timestamps = pix4d(:,1);

subplot(8,1,1);
plot(timestamps, errors_sts(:,1))
hold on
plot(timestamps, errors_lts(:,1))
legend('STS','LTS')
title('Error X [m]')
grid on
subplot(8,1,2);
plot(timestamps, errors_sts(:,2))
hold on
plot(timestamps, errors_lts(:,2))
legend('STS','LTS')
title('Error Y [m]')
grid on
subplot(8,1,3);
plot(timestamps, errors_sts(:,3))
hold on
plot(timestamps, errors_lts(:,3))
legend('STS','LTS')
title('Error Z [m]')
grid on
subplot(8,1,4);
plot(timestamps, errors_magnitude_sts)
hold on
plot(timestamps, errors_magnitude_lts)
legend('STS','LTS')
title('Error position magnitude [m]')
grid on
subplot(8,1,5);
plot(timestamps, errors_sts_a(:,1))
hold on
plot(timestamps, errors_lts_a(:,1))
hold on
legend('STS','LTS')
title('Error Yaw [deg]')
grid on
subplot(8,1,6);
plot(timestamps, errors_sts_a(:,2))
hold on
plot(timestamps, errors_lts_a(:,2))
legend('STS','LTS')
title('Error Pitch [deg]')
grid on
subplot(8,1,7);
plot(timestamps, errors_sts_a(:,3))
hold on
plot(timestamps, errors_lts_a(:,3))
legend('STS','LTS')
title('Error Roll [deg]')
grid on
subplot(8,1,8);
plot(timestamps, axang_err_sts(:,4)*180/pi)
hold on
plot(timestamps, axang_err_lts(:,4)*180/pi)
legend('STS','LTS')
title('Error Angle magnitude [deg]')
grid on

RMS_pos_sts = sqrt(mean(errors_magnitude_sts).^2)
RMS_pos_lts = sqrt(mean(errors_magnitude_lts).^2)
RMS_rot_sts = sqrt(mean((axang_err_sts(:,4)*180/pi).^2))
RMS_rot_lts = sqrt(mean((axang_err_lts(:,4)*180/pi).^2))

