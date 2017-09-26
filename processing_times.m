clear
clc
close all

%STS
fileSTS = fopen('/home/radam/TODOs/1 and 2/isam_app.radam-HP-Z1-Workstation.radam.log.ERROR.STS');

%LTS
fileLTS = fopen('/home/radam/TODOs/1 and 2/isam_app.radam-HP-Z1-Workstation.radam.log.ERROR.LTS');

line = fgets(fileSTS);
line = fgets(fileSTS);
line = fgets(fileSTS);

line = fgets(fileLTS);
line = fgets(fileLTS);
line = fgets(fileLTS);

timesSTS = NaN(5000,1);
iter = 1;

while ~feof(fileSTS)
    line = fgets(fileSTS);
    data = strsplit(line,' ' );
    
    val = str2double(cell2mat(data(7)));
    timesSTS(iter,1) = val;
    iter = iter+1;
    
end

timesLTS = NaN(5000,1);
iter = 1;


while ~feof(fileLTS)
    line = fgets(fileLTS);
    data = strsplit(line,' ' );
    
    val = str2double(cell2mat(data(7)));
    timesLTS(iter,1) = val;
    iter = iter+1;
    
end

sts_mean = nanmean(timesSTS)
lts_mean = nanmean(timesLTS)

figure(1)
plot(1:5000, timesSTS, 1:5000,timesLTS)

figure(2)
boxplot(timesSTS)
figure(3)
boxplot(timesLTS)