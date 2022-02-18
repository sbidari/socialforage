
clear;
load('LH_diff.mat','list_theta','list_B','list_kappa','P','T');

kappa_min = 0;  kappa_max = 6;
theta_min = -4; theta_max = -.5;
B_min = 0;  B_max = 3;

% Generate trial data for testing
tau = 5;   rho = 2;  alpha = 1; Xzero = [0 0];
ntrials =  [50;100;500];
iterations = 100;

len_theta = length(list_theta); len_B = length(list_B); len_kappa = length(list_kappa);

theta_ml = zeros(iterations,length(ntrials));
kappa_ml = zeros(iterations,length(ntrials));
B_ml = zeros(iterations,length(ntrials));

actual_B = zeros(iterations,length(ntrials));
actual_theta = zeros(iterations,length(ntrials));
actual_kappa = zeros(iterations,length(ntrials));

for n = 1:length(ntrials)
    for mm = 1:iterations
        theta = rand*(theta_max - theta_min)+theta_min;
        B = rand*(B_max-B_min)+B_min;
        kappa = rand*(kappa_max-kappa_min)+kappa_min;
        
        actual_B(mm,n) = B;
        actual_theta(mm,n) = theta;
        actual_kappa(mm,n) = kappa;
    
        [t,k,b]= log_prob_Theta(P,tau,B,kappa,alpha,rho,theta,Xzero,ntrials(n),len_theta,len_kappa,len_B,T,list_theta,list_B,list_kappa);
        
        theta_ml(mm,n) = t;
        kappa_ml(mm,n) = k;
        B_ml(mm,n) = b;
    end
    n
end

save('fit_diff.mat','B_ml','kappa_ml','theta_ml','actual_B','actual_theta','actual_kappa')
