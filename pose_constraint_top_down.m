clc
clear
close all

poses_lts = load('/home/radam/TODOs/how_often_constrain/pose_con/100/out_pos_LTS.txt');

% Use only the first circle
poses_lts = poses_lts(1:2020,:);





con = [00000464884 5.27236e+06 0000482.311
00000464931 5.27238e+06 0000483.919
00000465098 5.27231e+06 000000481.4
00000465101 5.27226e+06 0000488.661
00000465096 5.27219e+06 00000498.02
00000465099 5.27212e+06 0000503.638
00000465146 5.27208e+06 0000516.064
0000465224 5.2721e+06 000526.522
00000465254 5.27216e+06 0000532.844
00000465186 5.27227e+06 0000532.293
00000465118 5.27228e+06 0000531.871
00000465080 5.27224e+06 0000525.891
0000465066 5.2722e+06 000519.891
00000465022 5.27216e+06 0000517.233
00000464968 5.27214e+06 0000519.072
00000464914 5.27216e+06 0000514.598
0000464858 5.2722e+06 0000511.45
00000464869 5.27234e+06 0000507.223
00000464928 5.27237e+06 0000513.908
00000464994 5.27238e+06 0000513.959
00000465048 5.27235e+06 0000512.163
0000465074 5.2723e+06 000512.797
00000465083 5.27225e+06 0000514.919];




figure(1)
plot3(poses_lts(:,2)-4.6480e+05, poses_lts(:,3)-5.2721e+06, poses_lts(:,4))
hold on
scatter3(con(:,1)-4.6480e+05, con(:,2)-5.2721e+06, con(:,3),50,'o','filled')
grid on
xlabel('x [m]')
ylabel('y [m]')
title 'Location of pose constraints'
set(gca,'fontsize',18)

