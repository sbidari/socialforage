function [opt_RR,opt_theta]=rr_nc_MC(alpha,tau,B,T_I,Xzero,t_f,list_rho)

len_rho = length(list_rho);
list_theta = -linspace(4,.5,45);
len_theta = length(list_theta);

%--------------% Fixed parameters
len_t = 201;
Nrun = 10^5;

%--------------% initialize
RR = zeros(len_rho,len_theta);
opt_theta = zeros(len_rho,1);
opt_RR = zeros(len_rho,1);

%--------------% Iterate 

parfor k = 1:len_rho
    rho = list_rho(k);
    for ii = 1:len_theta
        theta = list_theta(ii);
        [t,p_T1,p_T2,T1,T2]=exit_time_sde_nc(alpha,B,tau,rho,theta,Nrun,Xzero,len_t,t_f);
        av_r = rho*tau*( trapz(t, (1-exp(-2*t/tau)).*p_T1) + exp(-2*T1/tau)*trapz(t, (1-exp(-(t-T1)/tau)).*p_T2) );
        RR(k,ii) = (av_r - alpha*(T2 + T_I))./(T2 + T_I);
    end
    k
end


for k = 1:len_rho
    R_rho = RR(k,:);
    pos = find(R_rho == max(R_rho));
    opt_theta(k) = list_theta(pos(1));
    opt_RR(k) = R_rho(pos(1));
end

end

