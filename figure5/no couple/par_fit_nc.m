
clear;
load('LH_nc.mat','list_theta','list_B','P','T');

theta_min = -4; theta_max = -.5;
B_min = 0.1;  B_max = 4;

% Generate trial data for testing
tau = 5;   rho = 2;  alpha = 1;   Xzero = [0 0];
ntrials = 100; % [50;100;500];
iterations = 100;

len_theta = length(list_theta); len_B = length(list_B);

theta_ml = zeros(iterations,length(ntrials));
B_ml = zeros(iterations,length(ntrials));

actual_B = zeros(iterations,length(ntrials));
actual_theta = zeros(iterations,length(ntrials));

for n = 1:length(ntrials)
    for mm = 1:iterations
        theta = rand*(theta_max - theta_min)+theta_min;
        B = rand*(B_max-B_min)+B_min;
        
        actual_B(mm,n) = B;
        actual_theta(mm,n) = theta;
        
        [t,b]= log_prob_Theta(P,tau,B,alpha,rho,theta,Xzero,ntrials(n),len_theta,len_B,T,list_theta,list_B);
        theta_ml(mm,n) = t;
        B_ml(mm,n) = b;
        mm
    end
    n
end

save('fit_nc.mat','B_ml','theta_ml','actual_B','actual_theta','ntrials')