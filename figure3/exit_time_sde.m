function [tsamp,P1_T,P2_T,T1,T2]=exit_time_sde(alpha,B,kappa,tau,rho,theta,Nrun,Xzero,len_t,T_max)

T1exit = zeros(1,Nrun);
T2exit = zeros(1,Nrun);

% Numeric calculation
for i = 1:Nrun
    [t1,t2] = SDE_2D(tau,B,kappa,alpha,rho,theta,Xzero);
    T1exit(i) = t1;
    T2exit(i) = t2;
%     i
end 

T1 = mean(T1exit);
T2 = mean(T2exit);

tsamp = linspace(0,T_max,len_t);
dsamp = tsamp(2)-tsamp(1);
N1bins = hist(T1exit,tsamp); P1_T = N1bins/dsamp/Nrun;
N2bins = hist(T2exit,tsamp); P2_T = N2bins/dsamp/Nrun;

end 