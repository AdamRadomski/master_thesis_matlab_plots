clear
clc
close all

ram_both = load('/home/radam/RAM_both.txt'); % DONT TOUCH
ram_sts = load('/home/radam/RAM_sts.txt'); % DONT TOUCH

plot((ram_both(:,1)-ram_both(1,1))/1e9,ram_both(:,2)/1000)
hold on
plot((ram_sts(:,1)-ram_sts(1,1))/1e9,ram_sts(:,2)/1000)
grid on
title('Process memory consumption')
xlabel('Timestamp [s]')
ylabel('RAM usage [MB]')
legend('Both estimators', 'STS only')
set(gca,'fontsize',16)
