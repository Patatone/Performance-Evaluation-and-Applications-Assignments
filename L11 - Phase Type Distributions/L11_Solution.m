clear variables;
clc;

%                    s1 s2 s3 s4 s5 s6 s7
alphaComputing =    [1, 1, 0, 0, 0, 0, 0];
alphaWiFi =         [0, 0, 1, 1, 0, 0, 0];
alpha4G =           [0, 0, 0, 0, 1, 1, 1];

%      s1 s2 s3 s4 s5 s6 s7
Ex = [ 0, 0, 0, 0, 0, 0, 0;
       0, 0, 0, 0, 0, 0, 0;
       0, 0, 0, 0, 0, 0, 0;
       0, 0, 0, 0, 0, 0, 0;
       0, 0, 0, 0, 0, 0, 0;
       0, 0, 0, 0, 0, 0, 0;
       0, 0, 0, 0, 0, 0, 0;
       0, 0, 0, 0, 0, 0, 0;];

%% Compute the system throughput


%% Compute the probability of being Computing, WiFi or 4G

