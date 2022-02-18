function [BF] = comp_bf_nc(T1,T2,ntrials)

load('LH_nc.mat','list_theta','list_B','P','T');

% Use uniform prior
theta_min = min(list_theta); theta_max = max(list_theta);  pi_theta = 1/(theta_max-theta_min);
B_min = min(list_B);  B_max = max(list_B);      pi_B = 1/(B_max-B_min);

len_theta = length(list_theta); len_B = length(list_B);
dt = T(2)-T(1);
P_Fn = zeros(len_theta,len_B,ntrials);

for ii = 1:len_theta
    for jj = 1:len_B
        fn = squeeze(P(ii,jj,:,:));
        p_fn =  diag(fn(ceil(T1/dt),ceil(T2/dt)));
        P_Fn(ii,jj,:) = p_fn;
    end
%     ii
end

pr_theta = pi_theta*ones(1,len_theta);
pr_B = pi_B*ones(1,len_B);

A = squeeze(trapz(list_theta,P_Fn.*reshape(pr_theta,numel(pr_theta),1)));
B = trapz(list_B, A.*reshape(pr_B,numel(pr_B),1));
BF = sum(log(B));

end 