function [t,k,b]= log_prob_Theta(P,tau,B,kappa,alpha,rho,theta,Xzero,ntrials,len_theta,len_kappa,len_B,T,list_theta,list_B,list_kappa)

[T1,T2] = exit_time_sample_pulse(tau,B,kappa,alpha,rho,theta,Xzero,ntrials);
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
P_Theta = sum(log(P_Fn),4);

[~,I] = max(P_Theta(:));
[row, col, z] = ind2sub(size(P_Theta),I);
t = list_theta(row);
k = list_kappa(col);
b = list_B(z);
end