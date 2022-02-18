% Generate the bubble plots for error in Figure 5.a
clear
Bl=[189,215,231;158,202,225;107,174,214;66,146,198;49,130,189;33,113,181;8,81,156;8,69,148;8,48,107]/255;

load('no couple/fit_nc.mat','actual_B','actual_theta','B_ml','theta_ml')
rse_t = abs(actual_theta-theta_ml)./abs(actual_theta);
rse_b = abs(actual_B-B_ml)./abs(actual_B);
mse_n = (rse_t + rse_b)/2;

load('diffusive/fit_diff.mat','B_ml','kappa_ml','theta_ml','actual_B','actual_theta','actual_kappa')
rse_t = abs(actual_theta-theta_ml)./abs(actual_theta);
rse_b = abs(actual_B-B_ml)./abs(actual_B);
rse_k = abs(actual_kappa-kappa_ml)./abs(actual_kappa);
mse_d = (rse_t + rse_b + rse_k)/3;

load('pulsatile/fit_pulse.mat','B_ml','kappa_ml','theta_ml','actual_B','actual_theta','actual_kappa')
rse_t = abs(actual_theta-theta_ml)./abs(actual_theta);
rse_b = abs(actual_B-B_ml)./abs(actual_B);
rse_k = abs(actual_kappa-kappa_ml)./abs(actual_kappa);
mse_p = (rse_t + rse_b + rse_k)/3;

mse=[mse_n;mse_d;mse_p];

figure;  
bubblechart(actual_B,actual_theta,mse_n,mse_n,'linewidth',1,'MarkerFaceAlpha',1) 
colormap(Bl);  colorbar; caxis([min(mse) max(mse)])
bubblelim('manual')
bubblesize([.1 25]);   % bubblelegend;
xlabel('B','Interpreter','latex')
ylabel('$\theta$','Interpreter','latex')
set(gca,'fontsize',35); box off;  
set(groot,'defaultAxesTickLabelInterpreter','latex');  

figure; 
bubblechart3(actual_B,actual_kappa,actual_theta,mse_d,mse_d,'linewidth',1,'MarkerFaceAlpha',1) 
colormap(Bl);  colorbar; caxis([min(mse) max(mse)])
bubblelim('manual')
bubblesize([.1 25]);   % bubblelegend;
xlabel('B','Interpreter','latex')
ylabel('$\kappa$','Interpreter','latex')
zlabel('$\theta$','Interpreter','latex')
set(gca,'fontsize',30); box off;  
set(groot,'defaultAxesTickLabelInterpreter','latex'); 


figure; 
bubblechart3(actual_B,actual_kappa,actual_theta,mse_p,mse_p,'linewidth',1,'MarkerFaceAlpha',1) 
colormap(Bl);  colorbar; caxis([min(mse) max(mse)])
bubblelim('manual')
bubblesize([.1 25]);   % bubblelegend;
xlabel('B','Interpreter','latex')
ylabel('$\kappa$','Interpreter','latex')
zlabel('$\theta$','Interpreter','latex')
set(gca,'fontsize',30); box off;  
set(groot,'defaultAxesTickLabelInterpreter','latex'); 

