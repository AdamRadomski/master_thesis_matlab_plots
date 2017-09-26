clear
clc
close all


load('STS_con_data2.mat');

magn_sts_s = magn_sts_s(1:2:end);
magn_sts_l = magn_sts_l(1:2:end);
magn_lts_l = magn_lts_l(1:2:end);
timestamps = timestamps(1:2:end);
magn_sts_s = magn_sts_s(1:2:end);
magn_sts_l = magn_sts_l(1:2:end);
magn_lts_l = magn_lts_l(1:2:end);
timestamps = timestamps(1:2:end);
magn_sts_s = magn_sts_s(1:2:end);
magn_sts_l = magn_sts_l(1:2:end);
magn_lts_l = magn_lts_l(1:2:end);
timestamps = timestamps(1:2:end);


figure(1)
plot(timestamps, magn_sts_s, timestamps, magn_lts_l)
figure(2)
plot(timestamps, magn_sts_l, timestamps, magn_lts_l)

figure(3)
x = [magn_sts_s;magn_sts_l;magn_lts_l];
g = [ones(size(magn_sts_s)); 2*ones(size(magn_sts_l)); 3*ones(size(magn_lts_l))];
notBoxPlot(x,g,'jitter',0.5)
title('Errors for estimators')
ylabel('Error magnitude [m]')
xlabel('STS       STS constrained       LTS')


ylabel('Position error magnitude [m]','FontSize',40)
set(gca,'fontsize',18)



%%
close all

x1 = rand(10,1); x2 = 2*rand(15,1); x3 = randn(30,1);
x = [x1;x2;x3];
g = [ones(size(x1)); 2*ones(size(x2)); 3*ones(size(x3))];
%boxplot(x,g)
