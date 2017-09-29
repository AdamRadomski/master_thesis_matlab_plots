clear
clc
close all

sts = load('/home/radam/tests/runtime/STS.txt'); % DONT TOUCH
lts = load('/home/radam/tests/runtime/LTS.txt'); % DONT TOUCH

sts = sts/1000;
lts = lts/1000;

x = [sts;lts];
g = [ones(size(sts)); 2*ones(size(lts))];
notBoxPlot(x,g,'jitter',0.5)
title('Estimators runtime')
ylabel('Runtime [ms]','FontSize',40)
ylim([0 12000])
grid on

set(gca,'fontsize',18)

mean_sts = mean(sts)
mean_lts = mean(lts)