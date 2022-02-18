function [P] = LH_pulse
%Generate and store likelihood under the pulsatile model

%--------------% Parameter space to iterate over
len_kappa = 40; len_theta = 40; len_B = 40;   len_t = 151;

list_kappa = linspace(0,10,len_kappa);
list_theta = -linspace(5,.5,len_theta);
list_B = linspace(0,5,len_B);

T_max  = 75;    t=linspace(0,T_max,len_t+1);     Xzero = [0;0];      Nrun = 10^5;

%--------------% Fixed parameters

alpha = 1;   tau = 5;   rho = 2;   

pj = zeros(len_theta,len_kappa,len_B,len_t,len_t);

parfor ii = 1:len_theta
    theta = list_theta(ii); 
    for jj = 1:len_kappa
        kappa = list_kappa(jj);
        for kk = 1:len_B
            B = list_B(kk);
            [P_joint]=jprob_sde(alpha,B,kappa,tau,rho,theta,Nrun,Xzero,t);
         pj(ii,jj,kk,:,:) = P_joint;
        end
    end 
    ii
end 
P = pj;
T = (t(1:end-1)+t(2:end))/2;

save('LH_pulse.mat','list_theta','list_kappa','list_B','P','T','alpha','tau','rho')

end 

