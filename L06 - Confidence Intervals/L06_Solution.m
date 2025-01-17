clear variables;
clc;

% Number of jobs = K*M  
global N;
N=10000;
% Runs
global K;
K=50;
% Jobs for each run
M=200;

%% Inter-arrival time - Hyper-exponential distribution with two stages (Lambda1=0.1, Lambda2=0.05, p1=0.5)
% Inter-arrival time K runs of M samples each
outHyper = zeros(M,K);
% For each run
for j=1:K
    % For each job in the run 
    for i=1:M
        if rand < 0.5
            outHyper(i,j) = -log(rand)/0.1;
        else
            outHyper(i,j) = -log(rand)/0.05;
        end
    end
end

%% Arrival time
arrivalTime = zeros(M,K);
%arrivalTimeN = zeros(N,1);

% For each run
for j=1:K
    % For each job in the run 
    for i=1:M
        if i == 1
            arrivalTime(i,j) = outHyper(i,j);
        else
            arrivalTime(i,j) = arrivalTime(i-1,j) + outHyper(i,j);
        end
    end  
end

% Set, for each run, the first arrival at time zero
% For each run
%{
for j=1:K
    start_value = arrivalTime(1,j);
    % For each job in the run 
    for i=1:M
        arrivalTime(i,j) = arrivalTime(i,j) - start_value;
    end  
end
%}

%% Service time - Hypo-exponential distribution with two stages (Lambda1=0.1, Lambda2=0.5)
serviceTime = -log(rand(M,K))/0.1 - log(rand(M,K))/0.5;
% Version with all elements in a cloumn
serviceTimeN = serviceTime(:);

%% Completation time
completationTime = zeros(M,K);
% For each run
for j=1:K
    % For each job in the run 
    for i=1:M
        if i == 1
            completationTime(i,j) = arrivalTime(i,j) + serviceTime(i,j);
        else
            completationTime(i,j) = max([arrivalTime(i,j), completationTime(i-1,j)]) + serviceTime(i,j);
        end
    end
end

%% Response time K runs of M samples each
responseTime = completationTime - arrivalTime;
% Version with all elements in a cloumn
responseTimeN = responseTime(:);

%% Generate the arrival and completation curves of one sample "SAMPLE_N"
SAMPLE_N = 1;
y = [1:M];
figure('Name', sprintf('Arrival and Completation curves for sample N=%d', SAMPLE_N),'NumberTitle','off');
plot(arrivalTime(:,SAMPLE_N), y, '-b', completationTime(:,SAMPLE_N), y, '-r');
legend('Arrival', 'Completation');
xlabel('Time') ;
ylabel('Jobs') ;

%% Total time = the last completation time
T = completationTime(end,:) - completationTime(1,:);

%% 95% confidence intervals of Average Service time (S) = (sum of the service time) / (Number of jobs)
fprintf('The 95%% confidence intervals are:\n');
%gamma = 0.95;
% Average service time computed for each run
confidenceIntervalN(serviceTimeN, 'Average Service time');

%% 95% confidence intervals of Average Response time (R) = (sum of the response time) / (Number of jobs)
% Average response time computed for each run
confidenceIntervalN(responseTimeN, 'Average Response time');

%% 95% confidence intervals of Average Number of jobs (NJ) = (sum of the response time) / (Total time)
confidenceIntervalK(sum(responseTime)./T, 'Average Number of jobs');

%% 95% confidence intervals of Utilization (U) = (sum of the service time) / (Total time)
confidenceIntervalK(sum(serviceTime)./T, 'Utilization');

%% 95% confidence intervals of Throughput (X) = (Number of jobs) / (Total time)
confidenceIntervalK(M./T, 'Throughput');

function interval = confidenceIntervalK(times, name)
    global K;
    % Average per run
    xb = sum(times)/K;
    
    s2 = 1/(K-1)*sum((times-xb).^2);
    % I could use also the Normal distribution approximation
    cgN = 1.96;
    
    % Lower average
    lower = xb - cgN*sqrt(s2/K);
    % Upper average
    upper = xb + cgN*sqrt(s2/K);
    interval = [lower, upper];
    fprintf("%s: [%f, %f]\n", name, lower, upper);
end

function interval = confidenceIntervalN(times, name)
    global N;
    
    xb = sum(times)/N;
    s2 = 1/(N-1)*sum((times-xb).^2);
    % I could use also the Normal distribution approximation
    cgN = 1.96;
    
    % Lower average
    lower = xb - cgN*sqrt(s2/N);
    % Upper average
    upper = xb + cgN*sqrt(s2/N);
    interval = [lower, upper];
    fprintf("%s: [%f, %f]\n", name, lower, upper);
end