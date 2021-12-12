clear variables;
clc;

for i = 1:4 
    run(sprintf('Data%d.txt', i), i);
end

function run(filename, i)
    % The file contains the "Inter arrival time".
    % It measures the time between the arrivals of two jobs
    fprintf('File name: %s\n', filename);
    records = table2array(readtable(filename));
    fprintf('---------------------------\n');
    
    %% First four moments
    %Number of the Inter Arrivals in the file
    N_IA = size(records,1);
    
    % First moment - mean
    m1 = sum(records) / N_IA;
    fprintf('First moment: %f or %f \n', m1, mean(records));
    
    % Second moment - standard deviation
    m2 = sum(records.^2) / N_IA;
    fprintf('Second moment: %f or %f\n', m2, mean(records.^2));
    
    % Third moment
    m3 = sum(records.^3) / N_IA;
    fprintf('Third moment: %f or %f\n', m3, mean(records.^3));
    
    % Fourth moment
    m4 = sum(records.^4) / N_IA;
    fprintf('Fourth moment: %f or %f\n', m4, mean(records.^4));
    fprintf('---------------------------\n');
    
    %% The second, third and fourth centered moments
    % Second centered moments (or Variance)
    cm2 = sum((records - m1).^2)/N_IA;
    varX = m2 - m1^2;
    fprintf('Second centered moment (or variance): %f or %f or %f\n', cm2, varX, var(records));
    
    % Third centered moment
    cm3 = sum((records - m1).^3)/N_IA;
    fprintf('Third centered moment: %f\n', cm3);
    
    % Fourth centered moment
    cm4 = sum((records - m1).^4)/N_IA;
    fprintf('Fourth centered moment: %f\n', cm4);
    fprintf('---------------------------\n');
    
    %% Standard Deviation, The third and fourth standardized moments
    % Standard Deviation
    stdX = sqrt(varX); 
    fprintf('Standard Deviation: %f\n', stdX);
    
    % Third standardized moment
    scm3 = sum(((records - m1)/stdX).^3)/N_IA;
    fprintf('Third standardized moment (or Skewness): %f\n', scm3);
    
    % Fourth standardized moment
    scm4 = sum(((records - m1)/stdX).^4)/N_IA;
    fprintf('Fourth standardized moment: %f\n', scm4);
    fprintf('---------------------------\n');
    
    %% Coefficient of Variation and Kurtosis
    % Coefficient of Variation
    cv = stdX/m1;  
    fprintf('Coefficient of Variation: %f\n', cv);
     
    % Kurtosis
    kurtois = scm4 - 3; 
    fprintf('Kurtosis: %f\n', kurtois);
    fprintf('---------------------------\n');
    
    %% The 10%, 25%, 50%, 75% and 90% percentiles
    % 10 Percentiles of the distribution
    fprintf('10 Percentiles of the distribution: %f or %f\n', my_prctile(records, N_IA, 10), prctile(records, 10));
    
    % 25 Percentiles of the distribution
    fprintf('25 Percentiles of the distribution: %f or %f\n', my_prctile(records, N_IA, 25), prctile(records, 25));
    
    % 50 Percentiles of the distribution
    fprintf('50 Percentiles of the distribution: %f or %f\n', my_prctile(records, N_IA, 50), prctile(records, 50));
    
    % 75 Percentiles of the distribution
    fprintf('75 Percentiles of the distribution: %f or %f\n', my_prctile(records, N_IA, 75), prctile(records, 75));
    
    % 90 Percentiles of the distribution
    fprintf('90 Percentiles of the distribution: %f or %f\n', my_prctile(records, N_IA, 90), prctile(records, 90));
    fprintf('---------------------------\n');
    
    %% The cross-covariance for lags m=1, m=2 and m=3
    ccv1 = sum((records(1:N_IA-1)-m1).*(records(2:N_IA))/(N_IA-1));
    fprintf('cross-covariance for m=1: %f\n', ccv1);
    
    ccv2 = sum((records(1:N_IA-2)-m1).*(records(3:N_IA))/(N_IA-2));
    fprintf('Cross-covariance for m=2: %f\n', ccv2);
    
    ccv3 = sum((records(1:N_IA-3)-m1).*(records(4:N_IA))/(N_IA-3));
    fprintf('Cross-covariance for m=3: %f\n', ccv3);
    
    fprintf('\n');
    
    %% Plotting phase
    figure('Name', filename, 'NumberTitle','off');
    % I have to sort the elements to display well the resoults
    plot(sort(records), [1:N_IA]/N_IA, "+");
end

%% Mine percentile function, linear interpolation
function prctile = my_prctile(records, size, percentage)
    h = (percentage/100) * (size - 1) + 1;
    prctile = records(floor(h)) + (h - floor(h)) * (records(floor(h)+1) - records(floor(h)));
end