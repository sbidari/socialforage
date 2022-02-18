function [RR,list_kappa,list_theta,av_r,av_T1,av_T2,p_1,p_2] = rho4_mc_pulse_rr

%--------------% Parameter space to iterate over
len_kappa = 50; len_theta = 45; len_t = 201; T_max =50;
list_kappa = linspace(.5,10,len_kappa);
list_theta = -linspace(5,.5,len_theta);

%--------------% Fixed parameters

alpha = 1;    B = 1;   tau = 5;   rho = 4;
T_I = 5;   Xzero = [0;0];   Nrun = 10^6;

%--------------% Fixed parameters

av_T1 = zeros(len_theta,len_kappa);
av_T2 = zeros(len_theta,len_kappa);
p_1 = zeros(len_theta,len_kappa,len_t);
p_2 = zeros(len_theta,len_kappa,len_t);
av_r = zeros(len_theta,len_kappa);

%--------------% Iterate 

for ii = 1:len_theta
    theta = list_theta(ii);
    for jj = 1:len_kappa
        kappa = list_kappa(jj);
        [t,p_T1,p_T2,T1,T2]=exit_time_sde(alpha,B,kappa,tau,rho,theta,Nrun,Xzero,len_t,T_max);
        av_T1(ii,jj) = T1;  av_T2(ii,jj) = T2;
        p_1(ii,jj,:) = p_T1;   p_2(ii,jj,:) = p_T2;
        av_r(ii,jj) = rho*tau*( trapz(t, (1-exp(-2*t/tau)).*p_T1) + exp(-2*T1/tau)*trapz(t, (1-exp(-(t-T1)/tau)).*p_T2) );
    end
    ii
end


RR = (av_r - alpha*(av_T2 + T_I))./(av_T2 + T_I);

%--------------% Save and plot

t = linspace(0,T_max,len_t); 
save('diff_rr_rho4.mat','RR','list_kappa','list_theta','av_T1','av_T2','p_1','p_2','av_r','alpha','B','tau','rho','T_I','Xzero','t')

end

