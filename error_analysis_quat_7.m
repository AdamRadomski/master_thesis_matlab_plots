clear
clc
close all

%pix4d = load('/home/radam/tests/extensive_testing/pix4dUTM_quat_4.txt'); % DONT TOUCH

pix4d = load('/home/radam/pix4d_long.txt'); % DONT TOUCH
pix4d = pix4d(1:963,:);

% without LC
poses_sts_lc = load('/home/radam/tests/extensive_testing/is_con_sts_working?/con/out_pos_STS.txt');
poses_sts_no_lc = load('/home/radam/tests/extensive_testing/is_con_sts_working?/no_con/out_pos_STS.txt');

% with LC 
poses_lts = load('/home/radam/tests/extensive_testing/is_con_sts_working?/con/out_pos_LTS.txt');

latest_start = FindLatest([poses_sts_lc(1,1) poses_sts_no_lc(1,1) poses_lts(1,1)]);
pix4d = RemoveBefore(latest_start, pix4d);

poses_sts_lc = Align(pix4d, latest_start, poses_sts_lc);
poses_sts_no_lc = Align(pix4d, latest_start, poses_sts_no_lc);
poses_lts = Align(pix4d, latest_start, poses_lts);

errors_sts_lc = pix4d(:,2:4)-poses_sts_lc(:,2:4);
errors_sts_no_lc = pix4d(:,2:4)-poses_sts_no_lc(:,2:4);
errors_lts = pix4d(:,2:4)-poses_lts(:,2:4);

errors_magnitude_sts_lc = sqrt(diag(errors_sts_lc * errors_sts_lc'));
errors_magnitude_sts_no_lc = sqrt(diag(errors_sts_no_lc * errors_sts_no_lc'));
errors_magnitude_lts = sqrt(diag(errors_lts * errors_lts'));

quat_err_sts_lc = quatmultiply(quatinv(pix4d(:,5:8)),poses_sts_lc(:,5:8));
quat_err_sts_no_lc = quatmultiply(quatinv(pix4d(:,5:8)),poses_sts_no_lc(:,5:8));
quat_err_lts = quatmultiply(quatinv(pix4d(:,5:8)),poses_lts(:,5:8));
axang_err_sts_lc = quat2axang(quat_err_sts_lc);
axang_err_sts_no_lc = quat2axang(quat_err_sts_no_lc);
axang_err_lts = quat2axang(quat_err_lts);

timestamps = pix4d(:,1);
timestamps = timestamps-timestamps(1);

con_t_err = [
1471012632717361664 -0.727487 0.0822006 001.06557
1471012635677361664 0.205215 0.597256 0.175721
1471012648877361664 -0.0179903 000.211908 000.678356
1471012652637361664 -0.224328 001.20597 00.567736
1471012656637361664 -1.25295 0.729049 0.716531
1471012660637361664 -2.56732 0.703151 01.09308
1471012664637361664 04.41846 -1.13047 0.671026
1471012668637361664 -3.68733 -2.94591 0.601527
1471012672637361664 001.96299 0-12.4088 -0.218735
1471012680637361664 9.19598 -1.8536 04.1492
1471012684637361664 4.13545 3.08352 2.55885
1471012688637361664 0.574419 08.60604 03.26963
1471012692637361664 -0.336152 00.739007 001.34951
1471012696637361664 0.0197834 003.95372 001.39671
1471012700637361664 00-2.43051 0003.99488 -0.0794156
1471012704637361664 -2.13218 02.42002 0.607548
1471012708637361664 003.95891 00.724003 -0.909965
1471012716637361664 0.0631595 00-1.3247 0.0814373
1471012724637361664 -6.52737 -2.77082 -0.29171
1471012728637361664 -2.87113 0.299144 01.44303
1471012732637361664 -1.24777 0-2.2782 0.263325
1471012736637361664 -0.591161 0-2.06487 00.210997
1471012740637361664 0-2.09864 0-4.85672 -0.532372
1471012744637361664 0.381307 01.19243 0.544643
1471012748637361664 -0.711478 00.499375 0.0945127
1471012752637361664 01.02906 0.196781 0.431036
1471012756637361664 -0.777805 001.93083 -0.175166
1471012760637361664 -1.05009 01.75855 00.84298
1471012764637361664 0.481637 0.661345 00.12367
1471012768637361664 0-2.91203 0.0794658 001.32244
1471012772637361664 00.636788 0-3.24032 -0.627548
1471012776637361664 01.02126 -1.69608 0.998178
1471012780637361664 0-2.07745 -0.419761 001.04713
1471012784637361664 002.4762 0-5.0444 0.989934
1471012788637361664 0-2.83148 0-3.22679 -0.171439
1471012792637361664 00-1.16403 -0.0167678 0-0.171279
1471012796637361664 01.20749 02.97307 0.643628
1471012800637361664 00.385723 002.71451 -0.585372
1471012804637361664 001.78186 004.38156 -0.370467
1471012808637361664 00-0.748892 00003.27132 -0.00820521
1471012812637361664 00.210411 -0.976313 00.537857
1471012816637361664 -0.340705 -0.159987 00.491602
1471012820637361664 002.22658 0-1.47846 -0.772844
1471012824637361664 01.78584 0.177731 0.385254
1471012828637361664 001.16018 -0.233139 001.04254
1471012832637361664 00.369071 -0.941749 00.742303
1471012836637361664 02.07775 -1.69281 01.24613
1471012840637361664 -1.21918 -3.96244 0.122087
1471012844637361664 0-4.1508 -4.47682 0.262199
1471012848637361664 00-2.04475 00001.7755 -0.0781028
1471012852637361664 -5.61152 -3.00308 0.484299
1471012856637361664 0.430621 01.53193 -1.61475];

con_t_err(:,1) = con_t_err(:,1)/1e9-pix4d(1,1);

con_err = sqrt(diag(con_t_err(:,2:4) * con_t_err(:,2:4)'));
num_con = size(con_t_err(:,1));



subplot(4,1,1);
plot(timestamps, errors_sts_lc(:,1))
hold on
plot(timestamps, errors_sts_no_lc(:,1))
hold on
plot(timestamps, errors_lts(:,1))
hold on
scatter(con_t_err(:,1), closestVal(timestamps, errors_sts_lc(:,1),con_t_err(:,1)), 'x')
legend('STS LC','STS no LC', 'LTS')
title('Error X [m]')
grid on
set(gca,'fontsize',16)
subplot(4,1,2);
plot(timestamps, errors_sts_lc(:,2))
hold on
plot(timestamps, errors_sts_no_lc(:,2))
hold on
plot(timestamps, errors_lts(:,2))
hold on
scatter(con_t_err(:,1), closestVal(timestamps, errors_sts_lc(:,2),con_t_err(:,1)), 'x')
legend('STS LC','STS no LC', 'LTS')
title('Error Y [m]')
grid on
set(gca,'fontsize',16)
subplot(4,1,3);
plot(timestamps, errors_sts_lc(:,3))
hold on
plot(timestamps, errors_sts_no_lc(:,3))
hold on
plot(timestamps, errors_lts(:,3))
hold on
scatter(con_t_err(:,1), closestVal(timestamps, errors_sts_lc(:,3),con_t_err(:,1)), 'x')
legend('STS LC','STS no LC', 'LTS')
title('Error Z [m]')
grid on
set(gca,'fontsize',16)
subplot(4,1,4);
plot(timestamps, errors_magnitude_sts_lc)
hold on
plot(timestamps, errors_magnitude_sts_no_lc)
hold on
plot(timestamps, errors_magnitude_lts)
hold on
scatter(con_t_err(:,1), closestVal(timestamps, errors_magnitude_sts_lc,con_t_err(:,1)), 'x')
legend('STS LC','STS no LC', 'LTS')
title('Error position magnitude [m]')
grid on
xlabel('Timestamp [s]')
set(gca,'fontsize',16)

RMS_pos_sts_lc = sqrt(mean(errors_magnitude_sts_lc).^2)
RMS_pos_sts_no_lc = sqrt(mean(errors_magnitude_sts_no_lc).^2)
RMS_pos_lts = sqrt(mean(errors_magnitude_lts).^2)

%%

figure(2)
scatter(con_t_err(:,1), con_err, 50, 'o', 'filled')
grid on
title('Discrepancy of STS between where it think it is and detected location of the frame')
xlabel('Timestamp [s]')
ylabel('Magnitude of discrepancy [m]')
set(gca,'fontsize',16)


