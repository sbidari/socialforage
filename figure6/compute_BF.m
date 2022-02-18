
clear;

% Generate trial data for testing
%change these for different data sets
tau = 5;   rho = 2;  alpha = 1; ntrials = 50;    Xzero = [0 0];

kappa_min = 0;  kappa_max = 5;
theta_min = -4; theta_max = -.5;
B_min = 0;  B_max = 4;

% Initialize
iter  = 300;
BF_nc = nan(iter,1); BF_diff = nan(iter,1);   BF_pulse = nan(iter,1);
store_B = nan(iter,1);   store_theta = nan(iter,1); store_kappa = nan(iter,1);

for nn = 1:(iter/3)
    theta = rand*(theta_max - theta_min)+theta_min;
    B = rand*(B_max-B_min)+B_min;
    [T1,T2] = exit_time_sample_nc(alpha,theta,tau,B,rho,Xzero,ntrials);
    bf_n = comp_bf_nc(T1,T2,ntrials);
    bf_d = comp_bf_diff(T1,T2,ntrials);
    bf_p = comp_bf_pulse(T1,T2,ntrials);
    BF_nc(nn) = bf_n;  BF_diff(nn) = bf_d;  BF_pulse(nn) = bf_p;
    store_B(nn) = B;   
    store_theta(nn) = theta;
    nn
end

for nn = (iter/3)+1:2*(iter/3)
    theta = rand*(theta_max - theta_min)+theta_min;
    kappa = rand*(kappa_max - kappa_min)+kappa_min;
    B =  rand*(B_max-B_min)+B_min;
    [T1,T2] = exit_time_sample_diff(tau,B,kappa,alpha,rho,theta,Xzero,ntrials);
    bf_n = comp_bf_nc(T1,T2,ntrials);
    bf_d = comp_bf_diff(T1,T2,ntrials);
    bf_p = comp_bf_pulse(T1,T2,ntrials);
    BF_nc(nn) = bf_n;  BF_diff(nn) = bf_d;  BF_pulse(nn) = bf_p;
    store_B(nn) = B;    store_theta(nn) = theta;    store_kappa(nn) = kappa;
    nn
end

for nn = 2*(iter/3)+1:iter
    theta = rand*(theta_max - theta_min)+theta_min;
    kappa = rand*(kappa_max - kappa_min)+kappa_min;
    B = rand*(B_max-B_min)+B_min;
    [T1,T2] =  exit_time_sample_pulse(tau,B,kappa,alpha,rho,theta,Xzero,ntrials);
    bf_n = comp_bf_nc(T1,T2,ntrials);
    bf_d = comp_bf_diff(T1,T2,ntrials);
    bf_p = comp_bf_pulse(T1,T2,ntrials);
    BF_nc(nn) = bf_n;  BF_diff(nn) = bf_d;  BF_pulse(nn) = bf_p;
    store_B(nn) = B;    store_theta(nn) = theta;    store_kappa(nn) = kappa;
    nn
end

save('BF_n50.mat','BF_nc','BF_diff','BF_pulse','ntrials','store_theta','store_kappa','store_B')




