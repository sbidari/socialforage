function [opt_RR,opt_theta,opt_T]=FPE_rr_theta_1D_diff(alpha,tau,n,B,T_I,Xzero,t_f,list_rho)

%--------------% Parameter space to iterate over
list_theta = -linspace(0.5,5,101);
len_rho = length(list_rho);
len_theta = length(list_theta);
%-------------% Numerical Method parameters

dx = 0.1;  L = 20;
t_0 = 0;    dt = 0.005;  t = t_0:dt:t_f;

RR = zeros(len_rho,len_theta);
T = zeros(len_rho,len_theta);
opt_theta = zeros(len_rho,1);
opt_RR = zeros(len_rho,1);
opt_T = zeros(len_rho,1);

parfor k = 1:len_rho
    rho = list_rho(k);
    for ii = 1:len_theta
        theta = list_theta(ii); N = round((L- theta)/dx);
        x = linspace(theta, L, N+1)';
        [p_T,~] = FPE_numn_solve([t,t_f+dt],x,dx,dt,B,alpha,rho,Xzero,L,theta,n,tau);
        % Obtain pdf of the minimum and maximum
        p_t1 = p_T(1:end-1);    T1 = trapz(t,t.*p_t1);
        av_r = rho*tau*( trapz(t, (1-exp(-n*t/tau)).*p_t1));
        RR(k,ii) = (av_r - alpha*(T1 + T_I))./(T1 + T_I);
        T(k,ii) = T1;
    end
end

for k = 1:len_rho
    R_rho = RR(k,:);    T_rho = T(k,:);
    pos = find(R_rho == max(R_rho));
    opt_theta(k) = list_theta(pos(1));
    opt_RR(k) = R_rho(pos(1));
    opt_T(k) = T_rho(pos(1));
end


% figure; hold on;
% plot(list_rho,opt_RR);
% plot(list_rho,opt_theta);
% set(gca,'fontsize',30);
% xlabel('$\rho$','Interpreter','latex');
% ylabel('$RR,\theta$','Interpreter','latex');

end

