function [T1exit,T2exit] = as_SDE_pulse(alpha,rho,tau,B,kappa1,kappa2,theta1,theta2,Xzero)
% EM  Euler-Maruyama method on coupled SDE
% SDE is  dx1 = A dt + K*(x2-x1) dt + sqrt(2 B) dW1(t),
%         dx2 = A dt + K*(x1-x2) dt + sqrt(2 B) dW2(t)

X1 = Xzero(1);
X2 = Xzero(2);

dt = 0.01;  t = 0;
sqrt_bis = sqrt(2*B*dt);

while X1 > theta1 && X2 > theta2
    t = t + dt;
    X1 = X1 + dt*(rho*exp(-2*t/tau) - alpha)  + sqrt_bis*randn;
    X2 = X2 + dt*(rho*exp(-2*t/tau) - alpha)  + sqrt_bis*randn;
end
   
if X1 <= theta1
    T1exit = t;
    X2 = X2 - kappa2;
    while X2 > theta2
        t = t + dt;
        X2 = X2 + dt*(rho*exp(-t/tau) - alpha)  + sqrt_bis*randn;
    end
    T2exit = t;
    
elseif X2 <= theta2
    T1exit = t;
    X1 = X1 - kappa1;
    while X1 > theta1
        t = t + dt;
        X1 = X1 + dt*(rho*exp(-t/tau) - alpha)  + sqrt_bis*randn;
    end
    T2exit = t;
end

end