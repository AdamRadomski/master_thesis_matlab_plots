clear
clc

%cam = load('/home/radam/hand_eye/camera_aligned.csv');
%tf = load('/home/radam/hand_eye/tf_aligned.csv');

cam = load('/home/radam/out_pos_LTS.txt');
tf = load('/home/radam/pix4dUTM_quat.txt');

errors = cam-tf;
timestamps = cam(1:end,1);
error_magnitude = sqrt(diag(errors(:,2:4) * errors(:,2:4)'));

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
