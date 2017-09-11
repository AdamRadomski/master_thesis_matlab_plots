
%STS angle 0.00209252788917641, 0.198359205085684, 0.968254037020792, -0.152096570894117
%pix4d angle 0.186225, -0.014770, 0.141163, 0.972201


quat_wrong = [0.186225, -0.014770, 0.141163, 0.972201];

[y, p, r ] = quat2angle(quat_wrong,'xyz')

angles = [y,p,r]*180/pi



quat_test = angle2quat(y,p,r,'xyz')



%%

angles = [-16.2637    1.3671  158.5080]/180*pi;
%angles = [360-16.2637    1.3671  158.5080]/180*pi;

quat_ver1 = angle2quat(angles(1), angles(2), angles(3), 'xyz')
quat_ver2 = angle2quat(angles(1), angles(2), angles(3), 'xzy')
quat_ver3 = angle2quat(angles(1), angles(2), angles(3), 'yxz')
quat_ver4 = angle2quat(angles(1), angles(2), angles(3), 'yzx')
quat_ver5 = angle2quat(angles(1), angles(2), angles(3), 'zxy')
quat_ver6 = angle2quat(angles(1), angles(2), angles(3), 'zyx')
%quat_ver7 = angle2quat(angles(1), angles(2), angles(3), 'xyz')
%quat_ver8 = angle2quat(angles(1), angles(2), angles(3), 'xyz')

%%


[yaw, pitch, roll ] = quat2angle([0.00209252788917641, 0.198359205085684, 0.968254037020792, -0.152096570894117],'xyz'); a1 = [yaw,pitch,roll]*180/pi
[yaw, pitch, roll ] = quat2angle([0.00209252788917641, 0.198359205085684, 0.968254037020792, -0.152096570894117],'xzy'); a1 = [yaw,pitch,roll]*180/pi
[yaw, pitch, roll ] = quat2angle([0.00209252788917641, 0.198359205085684, 0.968254037020792, -0.152096570894117],'yxz'); a1 = [yaw,pitch,roll]*180/pi
[yaw, pitch, roll ] = quat2angle([0.00209252788917641, 0.198359205085684, 0.968254037020792, -0.152096570894117],'yzx'); a1 = [yaw,pitch,roll]*180/pi
[yaw, pitch, roll ] = quat2angle([0.00209252788917641, 0.198359205085684, 0.968254037020792, -0.152096570894117],'zxy'); a1 = [yaw,pitch,roll]*180/pi
[yaw, pitch, roll ] = quat2angle([0.00209252788917641, 0.198359205085684, 0.968254037020792, -0.152096570894117],'zyx'); a1 = [yaw,pitch,roll]*180/pi







%%


angles = [-16.2637    1.3671  158.5080]/180*pi;




T_B_C = [ 0.9997043,   0.00875142, -0.02268738, -0.01507056,
             -0.00852631,  0.99991364,  0.01000032, -0.15685871,
             0.02277294, -0.00980392,  0.99969259,  0.08125101,
                     0.,          0.,          0.,          1.];
                 
                 
Rot = T_B_C(1:3,1:3);
eulZYX = rotm2eul(Rot)

%%

omega = -16;
phi = 1.36;
kappa = 158.5;

cw = cos(omega * pi / 180.0);
cp = cos(phi * pi / 180.0);
ck = cos(kappa * pi/ 180.0);
sw = sin(omega * pi / 180.0);
sp = sin(phi * pi / 180.0);
sk = sin(kappa * pi/ 180.0);

R_match_conventions = [1 0 0 ; 0 -1 0 ; 0 0 -1];
R = [cp * ck, cw * sk + sw*sp*ck, sw*sk-cw*sp*ck
     -cp*sk, cw*ck - sw*sp*sk, sw*ck+cw*sp*sk
     sp, -sw*cp, cw*cp];
 
 Rot = (R_match_conventions*R)';
 
 rotm2quat(Rot)


