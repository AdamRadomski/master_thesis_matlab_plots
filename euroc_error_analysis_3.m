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

%poses_sts = load('/home/radam/out_pos_STS.txt');
poses_lts_no_lc = load('/home/radam/tests/extensive_testing/euroc/no_lc2/out_pos_LTS.txt');
poses_lts_lc = load('/home/radam/tests/extensive_testing/euroc/lc2/out_pos_LTS.txt');


poses_lts_no_lc(:,2:4) = poses_lts_no_lc(:,2:4)-[464980,5.27226e+06,414.087];
poses_lts_lc(:,2:4) = poses_lts_lc(:,2:4)-[464980,5.27226e+06,414.087];

latest_start = FindLatest([poses_lts_no_lc(1,1) poses_lts_lc(1,1)]);
earliest_end = FindEarliest([poses_lts_no_lc(end,1) poses_lts_lc(end,1)]);
earliest_end = earliest_end-1; %otherwise problems
gt = RemoveBefore(latest_start, gt);
gt = RemoveAfter(earliest_end, gt);

poses_lts_no_lc = Align(gt, latest_start, poses_lts_no_lc);
poses_lts_lc = Align(gt, latest_start, poses_lts_lc);

errors_lts_no_lc = gt(:,2:4)-poses_lts_no_lc(:,2:4);
errors_lts_lc = gt(:,2:4)-poses_lts_lc(:,2:4);

errors_magnitude_lts_no_lc = sqrt(diag(errors_lts_no_lc * errors_lts_no_lc'));
errors_magnitude_lts_lc = sqrt(diag(errors_lts_lc * errors_lts_lc'));

quat_err_lts_no_lc = quatmultiply(quatinv(gt(:,5:8)),poses_lts_no_lc(:,5:8));
quat_err_lts_lc = quatmultiply(quatinv(gt(:,5:8)),poses_lts_lc(:,5:8));
axang_err_lts_no_lc = quat2axang(quat_err_lts_no_lc);
axang_err_lts_lc = quat2axang(quat_err_lts_lc);

[r1 r2 r3] = quat2angle(quat_err_lts_no_lc); errors_lts_a_no_lc = [r1 r2 r3]*180/pi;
[r1 r2 r3] = quat2angle(quat_err_lts_lc); errors_lts_a_lc = [r1 r2 r3]*180/pi;

timestamps = gt(:,1);

subplot(8,1,1);
plot(timestamps-timestamps(1), errors_lts_no_lc(:,1))
hold on
plot(timestamps-timestamps(1), errors_lts_lc(:,1))
legend('LTS no LC', 'LTS LC')
title('Error X [m]')
grid on
subplot(8,1,2);
plot(timestamps-timestamps(1), errors_lts_no_lc(:,2))
hold on
plot(timestamps-timestamps(1), errors_lts_lc(:,2))
legend('LTS no LC', 'LTS LC')
title('Error Y [m]')
grid on
subplot(8,1,3);
plot(timestamps-timestamps(1), errors_lts_no_lc(:,3))
hold on
plot(timestamps-timestamps(1), errors_lts_lc(:,3))
legend('LTS no LC', 'LTS LC')
title('Error Z [m]')
grid on
subplot(8,1,4);
plot(timestamps-timestamps(1), errors_magnitude_lts_no_lc)
hold on
plot(timestamps-timestamps(1), errors_magnitude_lts_lc)
legend('LTS no LC', 'LTS LC')
title('Error position magnitude [m]')
grid on
subplot(8,1,5);
plot(timestamps-timestamps(1), errors_lts_a_no_lc(:,1))
hold on
plot(timestamps-timestamps(1), errors_lts_a_lc(:,1))
hold on
legend('LTS no LC', 'LTS LC')
title('Error Yaw [deg]')
grid on
subplot(8,1,6);
plot(timestamps-timestamps(1), errors_lts_a_no_lc(:,2))
hold on
plot(timestamps-timestamps(1), errors_lts_a_lc(:,2))
legend('LTS no LC', 'LTS LC')
title('Error Pitch [deg]')
grid on
subplot(8,1,7);
plot(timestamps-timestamps(1), errors_lts_a_no_lc(:,3))
hold on
plot(timestamps-timestamps(1), errors_lts_a_lc(:,3))
legend('LTS no LC', 'LTS LC')
title('Error Roll [deg]')
grid on
subplot(8,1,8);
plot(timestamps-timestamps(1), axang_err_lts_no_lc(:,4)*180/pi)
hold on
plot(timestamps-timestamps(1), axang_err_lts_lc(:,4)*180/pi)
legend('LTS no LC', 'LTS LC')
title('Error Angle magnitude [deg]')
grid on

RMS_pos_lts_no_lc = sqrt(mean(errors_magnitude_lts_no_lc).^2)
RMS_pos_lts_lc = sqrt(mean(errors_magnitude_lts_lc).^2)
RMS_rot_lts_no_lc = sqrt(mean((axang_err_lts_no_lc(:,4)*180/pi).^2))
RMS_rot_lts_lc = sqrt(mean((axang_err_lts_lc(:,4)*180/pi).^2))


%%

%close all
figure(2)
skip = 1;
plot(timestamps(skip:end)-timestamps(skip), errors_magnitude_lts_no_lc(skip:end))
hold on
plot(timestamps(skip:end)-timestamps(skip), errors_magnitude_lts_lc(skip:end))
legend('LTS no LC', 'LTS LC')
title('Position error magnitude [m]','FontSize',32)
grid on
ylabel('Error magnitude [m]','FontSize',32)
xlabel('Timestamp [s]','FontSize',32)
set(gca,'fontsize',24)


%%
%close all

figure(3)
enlc = errors_magnitude_lts_no_lc;
elc = errors_magnitude_lts_lc;
enlc = enlc(1:2:end);elc = elc(1:2:end);
enlc = enlc(1:2:end);elc = elc(1:2:end);
enlc = enlc(1:2:end);elc = elc(1:2:end);


x = [enlc;
    elc];
g = [ones(size(enlc)); 
    2*ones(size(elc))];
notBoxPlot(x,g,'jitter',0.5)
title('Position error magnitude')
ylabel('Position error magnitude [m]','FontSize',40)
set(gca,'fontsize',18)

