clear variables;
clc;

% Constants defined by the text
N = 500000;
distNames = ['Uniform distribution', 'Discrete distribution', 'Exponential distribution', 'Hyper-exponential distribution', 'Hypo-exponential distribution', 'Hyper-Erlang distribution'];
y = [1:N]/N;

%% Uniform distribution between [10, 20]
outUniform = zeros(N, 1);
a_unif = 10;
b_unif = 20;
for i = 1:N
    outUniform(i,1) = a_unif+(b_unif-a_unif)*rand;
end
run(outUniform, 'Uniform distribution');

%% Discrete distribution
% Value, Probability, Cumulative Probability
outDiscrete = zeros(N, 1);
PrDiscrete = [5, 0.2, 0.2; 
    15, 0.6, 0.8; 
    20, 0.2, 1];

for i = 1:N
    rand_n = rand;
    if rand_n < PrDiscrete(1,3)
        outDiscrete(i,1) = PrDiscrete(1,1);
    elseif rand_n < PrDiscrete(2,3)
        outDiscrete(i,1) = PrDiscrete(2,1);
    else
        outDiscrete(i,1) = PrDiscrete(3,1);
    end
end

run(outDiscrete, 'Discrete distribution');

%% Exponential distribution with average 15
outExponential = -log(rand(N,1))/(1/15);
run(outExponential, 'Exponential distribution');

%% Hyper-exponential distribution with two stages (Lambda1=0.1, Lambda2=0.05, p1=0.5)
outHyper = zeros(N, 1);
for i=1:N
    if rand < 0.5
        outHyper(i,1) = -log(rand)/0.1;
    else
        outHyper(i,1) = -log(rand)/0.05;
    end
end

run(outHyper, 'Hyper-exponential distribution');


%% Hypo-exponential distribution with two stages (Lambda1=0.1, Lambda2=0.2)
outHypo = -log(rand(N,1))/0.1 - log(rand(N,1))/0.2;

run(outHypo, 'Hypo-exponential distribution');

%% Hyper-Erlang
outHyperErlang = zeros(N, 1);
PrHyperErlang = [1, 0.02, 0.1, 0.1;
                2, 0.2, 0.4, 0.5;
                3, 0.25, 0.5, 1];

%outHyperErlang = -(log(rand(N,1))+log(rand(N,1))+log(rand(N,1)))/0.5;     
for i = 1:N
    rand_n = rand;
    if rand_n < PrHyperErlang(1,4)
        outHyperErlang(i,1) = -(log(rand))/0.02;
    elseif rand_n < PrHyperErlang(2,4)
        outHyperErlang(i,1) = -(log(rand)+log(rand))/0.2;
    else
        outHyperErlang(i,1) = -(log(rand)+log(rand)+log(rand))/0.25;
    end
end

run(outHyperErlang, 'Hyper-Erlang distribution');

figure('Name', sprintf('Distributions for N=%d', N),'NumberTitle','off');
plot(sort(outUniform), y, '-b', sort(outDiscrete), y, '-r', sort(outExponential),y, '-y', sort(outHyper), y, '-m', sort(outHypo), y, '-g', sort(outHyperErlang), y, '-c');
legend('Uniform', 'Discrete', 'Exponential', 'Hyper-exponential', 'Hypo-exponential', 'Hyper-Erlang');
xlim([0 50])

function run(out, name)
    fprintf("+ %s:\n", name); 
    % Frist moment - mean - average
    m1 =  mean(out);
    fprintf("Average: %f\n", m1);
    
    std = sqrt(var(out));
    % Coefficient of Variation
    cv = std/m1;
    fprintf('Coefficient of Variation: %f\n', cv);
    
    % Useful for debugging
    %name = strcat(name, sprintf(' N=%d', N));
    %figure('Name',name ,'NumberTitle','off');
    %plot(sort(out), [1:N]/N, "-");
end
