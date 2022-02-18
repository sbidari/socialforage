function [BF] = comp_bf_pulse(T1,T2,ntrials)

load('LH_pulse.mat','list_theta','list_B','list_kappa','P','T');

% Use uniform prior
theta_min = min(list_theta); theta_max = max(list_theta);  pi_theta = 1/(theta_max-theta_min);
B_min = min(list_B);  B_max = max(list_B);      pi_B = 1/(B_max-B_min);
kappa_min = min(list_kappa);  kappa_max = max(list_kappa);   pi_kappa = 1/(kappa_max-kappa_min);

len_theta = length(list_theta); len_B = length(list_B); len_kappa = length(list_kappa);
dt = T(2)-T(1);

P_Fn = zeros(len_theta,len_kappa,len_B,ntrials);

for ii = 1:len_theta
    for jj = 1:len_kappa
        for kk = 1:len_B
            fn = squeeze(P(ii,jj,kk,:,:));
            p_fn =  diag(fn(ceil(T1/dt),ceil(T2/dt)));
            P_Fn(ii,jj,kk,:) = p_fn;
        end
    end
%     ii
end

pr_theta = pi_theta*ones(1,len_theta);
pr_B = pi_B*ones(1,len_B);
pr_kappa=pi_kappa*ones(1,len_kappa);

A = squeeze(trapz(list_theta,P_Fn.*reshape(pr_theta,numel(pr_theta),1,1)));
B = squeeze(trapz(list_kappa,A.*reshape(pr_kappa,numel(pr_kappa),1,1)));
C = trapz(list_B, B.*reshape(pr_B,numel(pr_B),1));
BF = sum(log(C));

end 