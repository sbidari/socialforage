function [opt_RR_HD,opt_theta_HD,list_rho,opt_RR_HP,opt_theta_HP,opt_RR_NC,opt_theta_NC] = sf_comp 
alpha = 1;
tau = 5;
n = 2;
B = 1;
T_I = 5;
Xzero = [0,0];
t_f = 60;
list_rho = linspace(1,10,25);

[opt_RR_HD,opt_theta_HD] = FPE_rr_theta_1D_diff(alpha,tau,n,B/n,T_I,Xzero,t_f,list_rho);

[opt_RR_HP,opt_theta_HP] = FPE_rr_theta_1D_pulse(alpha,tau,n,B,T_I,Xzero,t_f,list_rho);

[opt_RR_NC,opt_theta_NC] = rr_nc_MC(alpha,tau,B,T_I,Xzero,t_f,list_rho);

save('sf_comp.mat','opt_RR_HP','opt_theta_HP','opt_RR_HD','opt_theta_HD','opt_RR_NC','opt_theta_NC','list_rho')

end 

