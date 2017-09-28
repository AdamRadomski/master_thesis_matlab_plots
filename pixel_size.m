K_fw = [472.392 0 393.633
        0  472.248 249.407
        0 0 1];
    
K_e = [458.654 0 367.215
       0  457.296 248.375
       0 0 1];
   
p1_fw = [0;0;100];   
p1_e = [0;0;5];

u1_fw = K_fw*p1_fw;
u1_fw = u1_fw/u1_fw(3);

u1_e = K_e*p1_e;
u1_e = u1_e/u1_e(3);


p2_fw = [1;1;100];   
p2_e = [0.1;0.1;5];

u2_fw = K_fw*p2_fw;
u2_fw = u2_fw/u2_fw(3);

u2_e = K_e*p2_e;
u2_e = u2_e/u2_e(3);


dp_fw = p1_fw-p2_fw;
du_fw = u1_fw - u2_fw;

dp_e = p1_e-p2_e;
du_e = u1_e - u2_e;

pix_size_fw = dp_fw(1)/du_fw(1)
pix_size_e = dp_e(1)/du_e(1)


