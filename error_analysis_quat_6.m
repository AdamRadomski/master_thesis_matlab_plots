clear
clc
close all

pix4d = load('/home/radam/tests/extensive_testing/pix4dUTM_quat_4.txt'); % DONT TOUCH

% without LC
poses_sts = load('/home/radam/tests/extensive_testing/no_interaction_even_longer_gps/with_lc/out_pos_STS.txt');
poses_lts_no_lc = load('/home/radam/tests/new_fw/LC_no_GPS/out_pos_LTS.txt');

% with LC 
poses_lts_lc = load('/home/radam/tests/new_fw/no_LC_with_GPS/out_pos_LTS.txt');

% GPS
gps = load('/home/radam/tests/extensive_testing/no_interaction_even_longer_gps/GPS_STS.txt');

for i=1:3246
   if (poses_lts_lc(i,1) > pix4d(2004,1))

      i 
      break
   end
end
%%

latest_start = FindLatest([poses_sts(1,1) poses_lts_no_lc(1,1) poses_lts_lc(1,1)]);
pix4d = RemoveBefore(latest_start, pix4d);

poses_sts = Align(pix4d, latest_start, poses_sts);
poses_lts_no_lc = Align(pix4d, latest_start, poses_lts_no_lc);
poses_lts_lc = Align(pix4d, latest_start, poses_lts_lc);

gps_int = interp1q(gps(:,1)/1e9, gps(:,2:4),pix4d(:,1));
gps = [pix4d(:,1), gps_int];

errors_sts = pix4d(:,2:4)-poses_sts(:,2:4);
errors_lts_no_lc = pix4d(:,2:4)-poses_lts_no_lc(:,2:4);
errors_lts_lc = pix4d(:,2:4)-poses_lts_lc(:,2:4);
errors_gps = pix4d(:,2:4) - gps(:,2:4);

errors_magnitude_sts = sqrt(diag(errors_sts * errors_sts'));
errors_magnitude_lts_no_lc = sqrt(diag(errors_lts_no_lc * errors_lts_no_lc'));
errors_magnitude_lts_lc = sqrt(diag(errors_lts_lc * errors_lts_lc'));
errors_magnitude_gps = sqrt(diag(errors_gps * errors_gps'));

quat_err_sts = quatmultiply(quatinv(pix4d(:,5:8)),poses_sts(:,5:8));
quat_err_lts_no_lc = quatmultiply(quatinv(pix4d(:,5:8)),poses_lts_no_lc(:,5:8));
quat_err_lts_lc = quatmultiply(quatinv(pix4d(:,5:8)),poses_lts_lc(:,5:8));
axang_err_sts = quat2axang(quat_err_sts);
axang_err_lts_no_lc = quat2axang(quat_err_lts_no_lc);
axang_err_lts_lc = quat2axang(quat_err_lts_lc);

[r1 r2 r3] = quat2angle(quat_err_sts); errors_sts_a = [r1 r2 r3]*180/pi;
[r1 r2 r3] = quat2angle(quat_err_lts_no_lc); errors_lts_a_no_lc = [r1 r2 r3]*180/pi;
[r1 r2 r3] = quat2angle(quat_err_lts_lc); errors_lts_a_lc = [r1 r2 r3]*180/pi;

timestamps = pix4d(:,1);

subplot(8,1,1);
plot(timestamps, errors_sts(:,1))
hold on
plot(timestamps, errors_lts_no_lc(:,1))
hold on
plot(timestamps, errors_lts_lc(:,1))
hold on
plot(timestamps, errors_gps(:,1))
legend('STS','LTS no LC', 'LTS LC', 'GPS')
title('Error X [m]')
grid on
subplot(8,1,2);
plot(timestamps, errors_sts(:,2))
hold on
plot(timestamps, errors_lts_no_lc(:,2))
hold on
plot(timestamps, errors_lts_lc(:,2))
hold on
plot(timestamps, errors_gps(:,2))
legend('STS','LTS no LC', 'LTS LC', 'GPS')
title('Error Y [m]')
grid on
subplot(8,1,3);
plot(timestamps, errors_sts(:,3))
hold on
plot(timestamps, errors_lts_no_lc(:,3))
hold on
plot(timestamps, errors_lts_lc(:,3))
hold on
plot(timestamps, errors_gps(:,3))
legend('STS','LTS no LC', 'LTS LC', 'GPS')
title('Error Z [m]')
grid on
subplot(8,1,4);
plot(timestamps, errors_magnitude_sts)
hold on
plot(timestamps, errors_magnitude_lts_no_lc)
hold on
plot(timestamps, errors_magnitude_lts_lc)
hold on
plot(timestamps, errors_magnitude_gps)
legend('STS','LTS no LC', 'LTS LC', 'GPS')
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
RMS_pos_gps = sqrt(mean(errors_magnitude_gps).^2)
RMS_rot_sts = sqrt(mean((axang_err_sts(:,4)*180/pi).^2))
RMS_rot_lts_no_lc = sqrt(mean((axang_err_lts_no_lc(:,4)*180/pi).^2))
RMS_rot_lts_lc = sqrt(mean((axang_err_lts_lc(:,4)*180/pi).^2))


% magnitude plot
figure(2)
plot(timestamps(1000:end), errors_magnitude_lts_no_lc(1000:end))
hold on
plot(timestamps(1000:end), errors_magnitude_lts_lc(1000:end))
legend('LTS no LC', 'LTS LC')
title('Position error magnitude [m]')
grid on
ylabel('Error magnitude [m]')
xlabel('Timestamp [s]')

%boxplot
figure(3)
errors_magnitude_lts_no_lc = errors_magnitude_lts_no_lc(1:2:end);
errors_magnitude_lts_no_lc = errors_magnitude_lts_no_lc(1:2:end);
errors_magnitude_lts_lc = errors_magnitude_lts_lc(1:2:end);
errors_magnitude_lts_lc = errors_magnitude_lts_lc(1:2:end);

x = [errors_magnitude_lts_no_lc;errors_magnitude_lts_lc];
g = [ones(size(errors_magnitude_lts_no_lc)); 2*ones(size(errors_magnitude_lts_lc))];
notBoxPlot(x,g,'jitter',0.5)
title('Position error magnitude')
ylabel('Position error magnitude [m]','FontSize',40)

set(gca,'fontsize',18)


