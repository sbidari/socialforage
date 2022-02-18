function [t,X1,X2] = SDE_pulse(alpha,rho,tau,B,kappa,theta,Xzero)
% EM  Euler-Maruyama method on coupled SDE
% SDE is  dx1 = A dt + K*(x2-x1) dt + sqrt(2 B) dW1(t),
%         dx2 = A dt + K*(x1-x2) dt + sqrt(2 B) dW2(t)
i=1;
X1(i) = Xzero(1);
X2(i) = Xzero(2);

dt = 0.01;  t(i) = 0;
while X1(i) > theta && X2(i) > theta
    t(i+1) = t(i) + dt; i=i+1;
    X1(i) = X1(i-1) + dt*(rho*exp(-2*t(i)/tau) - alpha)  + sqrt(2*B*dt)*randn;
    X2(i) = X2(i-1) + dt*(rho*exp(-2*t(i)/tau) - alpha)  + sqrt(2*B*dt)*randn;
end
T1exit = t(i);

if X1(i) <= theta
    t(i+1) = t(i) + dt; i=i+1;
    X2(i) = X2(i-1) - kappa;
    X1(i) = X1(i-1);
    while X2(i) > theta
        t(i+1) = t(i) + dt; i=i+1;
        X2(i) = X2(i-1) + dt*(rho*exp(-t(i)/tau) - alpha)  + sqrt(2*B*dt)*randn;
        X1(i) = theta;
    end
    T2exit = t(i);
    
elseif X2(i) <= theta
    t(i+1) = t(i) + dt; i=i+1;
    X1(i) = X1(i-1) - kappa;
    X2(i) = X2(i-1);
    while X1(i) > theta
        t(i+1) = t(i) + dt; i=i+1;
        X1(i) = X1(i-1) + dt*(rho*exp(-t(i)/tau) - alpha)  + sqrt(2*B*dt)*randn;
        X2(i) = theta;
    end
    T2exit = t(i);
end

figure;hold on;
plot(t,X1,'b','Linewidth',2);
plot(t,X2,'b','Linewidth',2); 
plot(t,theta*ones(length(t),1),'k')
xlabel('$t$','FontSize',20,'Interpreter','latex');
ylabel('$x(t)$','FontSize',20,'Interpreter','latex');
set(gca,'fontsize',30);
set(groot,'defaultAxesTickLabelInterpreter','latex');
end