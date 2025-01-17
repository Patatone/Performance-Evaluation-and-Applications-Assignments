clear variables;
clc;

% Kendall's notation
% Poisson arrival, general service time, 1 server, 
% infinite queue and infinite population

%% M/G/1 queue
fprintf("--- <Exercise 1 - M/G/1> ----\n");
% Arrivals according to a Poisson process of rate [j/s]
lambda = 3;
% Job duration according to an Hyper-Exponential distribution
u1 = 1;
u2 = 10;
p1 = 0.2;
p2 = 0.8;

% Service time
D = p1/u1 + p2/u2;

ro = lambda*D;
m2 = 2*(p1/u1^2+p2/u2^2);

% Remaining time
w = (lambda*m2)/2;
% Queuing time
W = (ro*w)/(1-ro);
% Average Response time
R = D + W + w;
fprintf("Average Response time: %f seconds\n", R);

% Average Number of jobs in the system
N = lambda*R;
fprintf("Number of jobs: %f or %f\n", N, ro+((lambda^2)*m2)/(2*(1-ro)));

% Utilization of the system
fprintf("Utilization: %f\n", D*lambda);


% Kendall's notation
% General arrival, General service time, 2 server, 
% infinite queue and infinite population

clear variables;
%% G/G/2 queue
fprintf("--- <Exercise 2 - G/G/2> ----\n");
% Inter-arrival time distributed according to a uniform distribution between a and b
a = 0.1;
b = 0.2;

m1A = (a+b)/2;
lambda = 1/m1A;
% Coeff. variation of the inter-arrival time
staA = sqrt(((b-a)^2)/12);
ca = staA/m1A;

% Job duration according to an Hyper-Exponential distribution
u1 = 1;
u2 = 10;
p1 = 0.2;
p2 = 0.8;
% Service time (m1V) (mean)
D = p1/u1 + p2/u2;
m2 = 2*(p1/u1^2+p2/u2^2);
% Coeff. variation of the service time
staV = sqrt(m2 - D^2);
cv = staV/D;

ro = D/(2*lambda^-1);
% Approximate Average Response time
R = D+((ca^2+cv^2)/2)*(((ro^2)*D)/(1-ro^2));
fprintf("Approx. Average Response time: %f seconds\n", R);

% Approximate Average Number of jobs in the system
% Little's law
N = lambda*R;
fprintf("Approx. Number of jobs: %f\n", N);

% Utilization of the system
fprintf("Utilization: %f\n", D*lambda);