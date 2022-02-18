function [t,X1,X2] = SDE_diff(alpha,rho,tau,B,kappa,theta,Xzero)

% run and generate time series to superimpose on heat plot

X1temp = Xzero(1);
X2temp = Xzero(2);
j = 1; t=0; dt = 0.01;  
while X1temp > theta && X2temp > theta 
    t = t + dt;
    X1temp = X1temp + dt*(-alpha + rho*exp(-2*t/tau)) + dt*kappa*(X2temp - X1temp) + sqrt(2*B*dt)*randn;
    X2temp = X2temp + dt*(-alpha + rho*exp(-2*t/tau)) + dt*kappa*(X1temp - X2temp) + sqrt(2*B*dt)*randn;
    X1em(j) = X1temp;
    X2em(j) = X2temp;
    j = j+1;
end

if X1temp <= theta
    while X2temp > theta
        t = t + dt;
        X2temp = X2temp + dt*(-alpha + rho*exp(-t/tau)) + dt*kappa*(theta - X2temp) + sqrt(2*B*dt)*randn;
        X1em(j) = theta;
        X2em(j) = X2temp;
        j = j+1;
    end
elseif X2temp <= theta
    while X1temp > theta
        t = t + dt;
        X1temp = X1temp + dt*(-alpha + rho*exp(-t/tau)) + dt*kappa*(theta - X1temp) + sqrt(2*B*dt)*randn;
        X2em(j) = theta;
        X1em(j) = X1temp;
        j = j+1;
    end
end

X1 = [Xzero(1),X1em];   X2 = [Xzero(2),X2em];
t =linspace(0,j*dt,length(X1));

figure;hold on;
plot(t,X1,'b','Linewidth',2);
plot(t,X2,'b','Linewidth',2); 
plot(t,theta*ones(length(X1),1),'k')
xlabel('$t$','FontSize',20,'Interpreter','latex');
ylabel('$x(t)$','FontSize',20,'Interpreter','latex');
set(gca,'fontsize',30);
set(groot,'defaultAxesTickLabelInterpreter','latex');

end