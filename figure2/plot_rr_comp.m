%generate figures 2.a.b.c
clear;

%%define colors here
C = [0,0,0;55,126,184;228,26,28;77,175,74;152,78,163;255,127,0;255,255,51;166,86,40;247,129,191;153,153,153];
C = C/255;

load('sf_comp.mat','opt_RR_HP','opt_theta_HP','opt_RR_HD','opt_theta_HD','opt_RR_NC','opt_theta_NC','list_rho','B','n','alpha','tau')

figure; hold on;
plot(list_rho,opt_RR_HD(1:length(list_rho),1),'linewidth',4,'Color',C(2,:));
plot(list_rho,opt_RR_HP(1:length(list_rho),1),'linewidth',4,'Color',C(3,:));
plot(list_rho,opt_RR_NC(1:length(list_rho),1),'linewidth',4,'Color',C(4,:));
set(gca,'fontsize',30);
xlabel('initial food amount ($\rho$)','Interpreter','latex');
ylabel('$\max(RR)$','Interpreter','latex');
legend('perfect diffusive coupling ($D_{\infty}$)','perfect pulsatile coupling ($P_{\infty}$)','no coupling (NC)','AutoUpdate','off','Interpreter','latex','edgecolor','none')


% Plot patch residence times (rho close to 2)

i=4; t_f=60; dx = 0.1;  L = 20; Xzero = [0; 0];
t_0 = 0;    dt = 0.005;  t = t_0:dt:t_f;

rho = list_rho(i)
theta = opt_theta_HD(i)
N = round((L- theta)/dx);
x = linspace(theta, L, N+1)';
[p_T,~] = FPE_numn_solve([t,t_f+dt],x,dx,dt,B/n,alpha,rho,Xzero,L,theta,n,tau);
p_t1 = p_T(1:end-1);    T1 = trapz(t,t.*p_t1)
figure; hold on;
plot(t,p_t1,'b','linewidth',2);
plot(T1*ones(10,1),linspace(0,1,10),'b--');

theta = opt_theta_HP(i)
N = round((L- theta)/dx);
x = linspace(theta, L, N+1)';
[p_T,f_T] = FPE_numn_solve([t,t_f+dt],x,dx,dt,B,alpha,rho,Xzero,L,theta,n,tau);
p_t1 = 2*(1-f_T).*p_T;  p_t1 = p_t1(1:end-1);    T1 = trapz(t,t.*p_t1)
plot(t,p_t1,'r','linewidth',2);
plot(T1*ones(10,1),linspace(0,1,10),'r--');

set(gca,'fontsize',30);
xlabel('$T$','Interpreter','latex');
ylabel('$p(T)$','Interpreter','latex');
xlim([0 40]);
ylim([0 .2]);


% Plot patch residence times (rho close to 6)

i=14; t_f=60; dx = 0.1;  L = 20;
t_0 = 0;    dt = 0.005;  t = t_0:dt:t_f;

rho = list_rho(i)
theta = opt_theta_HD(i)
N = round((L- theta)/dx);
x = linspace(theta, L, N+1)';
[p_T,~] = FPE_numn_solve([t,t_f+dt],x,dx,dt,B/n,alpha,rho,Xzero,L,theta,n,tau);
p_t1 = p_T(1:end-1);    T1 = trapz(t,t.*p_t1)
figure; hold on;
plot(t,p_t1,'b','linewidth',2);
plot(T1*ones(10,1),linspace(0,1,10),'b--');

theta = opt_theta_HP(i)
N = round((L- theta)/dx);
x = linspace(theta, L, N+1)';
[p_T,f_T] = FPE_numn_solve([t,t_f+dt],x,dx,dt,B,alpha,rho,Xzero,L,theta,n,tau);
p_t1 = 2*(1-f_T).*p_T;  p_t1 = p_t1(1:end-1);    T1 = trapz(t,t.*p_t1)
plot(t,p_t1,'r','linewidth',2);
plot(T1*ones(10,1),linspace(0,1,10),'r--');

set(gca,'fontsize',30);
xlabel('$T$','Interpreter','latex');
ylabel('$p(T)$','Interpreter','latex');
xlim([0 40]);
ylim([0 .2]);
