clear
clc

in = load('/home/radam/pix4dUTM.txt');

size = size(in);

file = fopen('/home/radam/pix4dUTM_quat.txt', 'w');

for i=1:(size(1)-1)
    row = in(i,:);
    next_row = in(i+1,:);
    
    unwrapping = 0; % 0=false, 1=row, 2=new_row
    if (abs(row(7)) + abs(next_row(7)) > 180 & abs(row(7) + next_row(7)) < 180)
       %r_nr_b = [ row(7), next_row(7)]
       if (row(7) > 0 ) 
           unwrapping = 2;
           next_row(7) = next_row(7)+360;  
       else
           unwrapping = 1;
           row(7) = row(7)+360;
           
       end
       %r_nr_a = [ row(7), next_row(7)]
    end
    
    num_per_meas = 4;
    for j=1:num_per_meas  
        dr = (next_row-row)/num_per_meas;
        
        int_row = row + dr*(j-1);
        angles = int_row(1,5:7);
        if (unwrapping == 1) 
            angles(3) = angles(3)-360;
            %avg1 = angles(3)
        elseif (unwrapping == 2)
            angles(3) = angles(3)-360;
            %avg2 = angles(3)
        end
               
        omega = angles(1);
        phi = angles(2);
        kappa = angles(3);

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

        quat = rotm2quat(Rot);

        fprintf(file, '%f, %f, %f, %f, %f, %f, %f, %f\n',int_row(1)/1e9, int_row(2), int_row(3),int_row(4), quat(1), quat(2), quat(3), quat(4)); 


    end
end


fclose(file);

disp('DONE')
