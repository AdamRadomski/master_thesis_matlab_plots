close all

% POSE

%   interval  sts   lts
pose_con = [
1000, 3.9863, 2.9869
800, 5.3887, 3.1052
650, 4.0257, 3.1011
500, 4.3104, 3.1158
350, 3.5930, 2.9949
200, 3.1048, 3.1246
100, 2.7896, 2.9168];

figure(1)(
plot(pose_con(:,2))
%h1 = axes;
%set(h1, 'Xdir', 'reverse')



%%
clc
clear
close all

load('50_sts.mat');
sts_50 = errors_magnitude_sts;
sts_50 = sts_50(1:2:end);
sts_50 = sts_50(1:2:end);
sts_50 = sts_50(1:2:end);
sts_50 = sts_50(1:2:end);
load('100_sts.mat');
sts_100 = errors_magnitude_sts;
sts_100 = sts_100(1:2:end);
sts_100 = sts_100(1:2:end);
sts_100 = sts_100(1:2:end);
sts_100 = sts_100(1:2:end);
load('200_sts.mat');
sts_200 = errors_magnitude_sts;
sts_200 = sts_200(1:2:end);
sts_200 = sts_200(1:2:end);
sts_200 = sts_200(1:2:end);
sts_200 = sts_200(1:2:end);
load('275_sts.mat');
sts_275 = errors_magnitude_sts;
sts_275 = sts_275(1:2:end);
sts_275 = sts_275(1:2:end);
sts_275 = sts_275(1:2:end);
sts_275 = sts_275(1:2:end);
load('350_sts.mat');
sts_350 = errors_magnitude_sts;
sts_350 = sts_350(1:2:end);
sts_350 = sts_350(1:2:end);
sts_350 = sts_350(1:2:end);
sts_350 = sts_350(1:2:end);
load('500_sts.mat');
sts_500 = errors_magnitude_sts;
sts_500 = sts_500(1:2:end);
sts_500 = sts_500(1:2:end);
sts_500 = sts_500(1:2:end);
sts_500 = sts_500(1:2:end);
load('650_sts.mat');
sts_650 = errors_magnitude_sts;
sts_650 = sts_650(1:2:end);
sts_650 = sts_650(1:2:end);
sts_650 = sts_650(1:2:end);
sts_650 = sts_650(1:2:end);
load('800_sts.mat');
sts_800 = errors_magnitude_sts;
sts_800 = sts_800(1:2:end);
sts_800 = sts_800(1:2:end);
sts_800 = sts_800(1:2:end);
sts_800 = sts_800(1:2:end);
load('1000_sts.mat');
sts_1000 = errors_magnitude_sts;
sts_1000 = sts_1000(1:2:end);
sts_1000 = sts_1000(1:2:end);
sts_1000 = sts_1000(1:2:end);
sts_1000 = sts_1000(1:2:end);
load('100_lts.mat');
lts = errors_magnitude_lts;
lts = lts(1:2:end);
lts = lts(1:2:end);
lts = lts(1:2:end);
lts = lts(1:2:end);

x = [sts_1000;
    sts_800;
    sts_650;
    sts_500;
    sts_350;
    sts_275;
    sts_200;
    sts_100;
    sts_50,
    lts];
g = [ones(size(sts_50)); 
    2*ones(size(sts_50)); 
    3*ones(size(sts_50)); 
    4*ones(size(sts_50)); 
    5*ones(size(sts_50)); 
    6*ones(size(sts_50)); 
    7*ones(size(sts_50)); 
    8*ones(size(sts_50)); 
    9*ones(size(sts_50)); 
    11*ones(size(sts_50))];
notBoxPlot(x,g,'jitter',0.5)
title('Errors as a function of constraint interval')
ylabel('Position error magnitude [m]','FontSize',40)
set(gca,'fontsize',24)

