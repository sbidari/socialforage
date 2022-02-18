function [N]=jprob_sde(alpha,B,tau,rho,theta,Nrun,Xzero,T)

T1exit = zeros(1,Nrun);
T2exit = zeros(1,Nrun);

% Numeric calculation
for i = 1:Nrun
    [t1,t2] = SDE_nc(tau,B,alpha,rho,theta,Xzero);
    T1exit(i) = t1;
    T2exit(i) = t2;
%     i
end 

[N,~,~] = histcounts2(T1exit,T2exit,T,T,'Normalization','pdf');
N(N==0) = 1e-6;

end 