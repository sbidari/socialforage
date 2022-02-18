function [t,b]= log_prob_Theta(P,tau,B,alpha,rho,theta,Xzero,ntrials,len_theta,len_B,T,list_theta,list_B)

[T1,T2] = exit_time_sample_nc(alpha,theta,tau,B,rho,Xzero,ntrials);
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

P_Theta = sum(log(P_Fn),3);

[~,I] = max(P_Theta(:));
[row, col] = ind2sub(size(P_Theta),I);
t = list_theta(row);
b = list_B(col);
end