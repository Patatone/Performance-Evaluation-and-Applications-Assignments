clear variables;
clc;

global ro;
global p0;

% Kendall's notation
% Poisson arrival, exponential service time, 1 server, 
% infinite queue and infinite population

%% M/M/1 queue
fprintf("--- <Exercise 1 - M/M/1> ----\n");
% Poisson process arrival rate [job/s]
lambda = 0.9;
% Avg Service [seconds]
D = 1;

% Utilization
U = lambda*D;
fprintf("Utilization: %f\n", U);

% Probability of having 4 jobs in the system
fprintf("P(J=4): %f\n", (1-U)*(U)^4);

% Average number of jobs in the system
fprintf("Average number of jobs in the system: %f\n", U/(1-U));

% Drop rate
fprintf("Drop rate: %f\n", 0);

% Throughput
fprintf("Throughput: %f\n", lambda);

% Average response time and the average time spend in the queue
R = D/(1-U);
fprintf("Average response time: %f sec\n", R);
fprintf("Average time spent in the queue: %f sec\n\n", R-D);

% Kendall's notation
% Poisson arrival, exponential service time, 1 server, 
% Queue capacity for K=6 jobs and infinite population

%% M/M/1/6 queue
fprintf("--- <Exercise 1 - M/M/1/6> ----\n");
k=6;

% Traffic intensity
ro = lambda*D;

% Utilization
U = (ro-ro^(k+1))/(1-ro^(k+1));
fprintf("Utilization: %f\n", U);

% Probability of having 4 jobs in the system
p0 = (1-ro)/(1-ro^(k+1));
p4 = p0*ro^4;
fprintf("P(J=4): %f\n", p4);

% Average number of jobs in the system
N = (ro/(1-ro))-((k+1)*ro^(k+1))/(1-ro^(k+1));
fprintf("Average number of jobs in the system: %f\n", N);

% Throughput and the drop rate
X=lambda*((1-ro^k)/(1-ro^(k+1)));
Dr = lambda*((ro^k-ro^(k+1))/(1-ro^(k+1)));
fprintf("Drop rate: %f\n", Dr);
fprintf("Throughput: %f or %f\n", X, lambda-Dr);

% Average response time and the average time spend in the queue
R = D*((1-(k+1)*(ro^k)+k*ro^(k+1))/((1-ro)*(1-ro^k)));
fprintf("Average response time: %f sec\n", R);
fprintf("Average time spent in the queue: %f sec\n\n", R-D);

% Kendall's notation
% Poisson arrival, exponential service time, 2 server, 
% Queue capacity for K=6 jobs and infinite population

%% M/M/2/6 queue
fprintf("--- <Exercise 2 - M/M/2/6> ----\n");
lambda = 1.8;
c = 2;
k=6;

% Traffic intensity
ro = (lambda*D)/c;

%Probability of having zero job in the system
syms t;
p0 = ((((c*ro)^c)/factorial(c))*((1-ro^(k-c+1))/(1-ro))+symsum((c*ro)^t/factorial(t),t,0,c-1))^(-1);
p0 = double(p0);

% Utilization
% sum from 1 to c and from c+1 to k
U = (1*prob_mmc6(1,c) + 2*prob_mmc6(2,c)) + c*(prob_mmc6(3,c)+prob_mmc6(4,c)+prob_mmc6(5,c)+prob_mmc6(6,c));
%U = symsum(t*prob_mmc6(eval(t),c),t,1,c) + symsum(prob_mmc6(eval(t),c),t,c+1,k);
fprintf("Utilization: %f\n", U/c);

% Probability of having 4 jobs in the system
fprintf("P(J=4): %f\n", prob_mmc6(4,c));

% Average number of jobs in the system
% sum from 1 to k
N = prob_mmc6(1,c)*1+prob_mmc6(2,c)*2+prob_mmc6(3,c)*3+prob_mmc6(4,c)*4+prob_mmc6(5,c)*5+prob_mmc6(6,c)*6;
%N = symsum(prob_mmc6(t,c)*t,t,1,k);
fprintf("Average number of jobs in the system: %f\n", N);

% Throughput and the drop rate
X=lambda*(1-prob_mmc6(k,c));
Dr = lambda*prob_mmc6(k,c);
fprintf("Drop rate: %f\n", Dr);
fprintf("Throughput: %f or %f\n", X, lambda-Dr);

% Average response time and the average time spend in the queue
R = N/(lambda*(1-prob_mmc6(k,c)));
fprintf("Average response time: %f sec\n", R);
fprintf("Average time spent in the queue: %f sec\n\n", R-D);


function probability = prob_mmc6(n, c)
    global p0;
    global ro;
    if n == 0
        probability = p0;
        return;
    end
    if n < c
        probability = (p0/factorial(n))*(c*ro)^n;
    else
        probability = (p0*(c^c)*ro^n)/(factorial(c));
    end
end
