function [T1exit,T2exit] = SDE_2D_pulse(alpha,rho,tau,B,kappa,theta,Xzero)
% EM  Euler-Maruyama method on coupled SDE
% SDE is  dx1 = A dt + K*(x2-x1) dt + sqrt(2 B) dW1(t),
%         dx2 = A dt + K*(x1-x2) dt + sqrt(2 B) dW2(t)

X1 = Xzero(1);
X2 = Xzero(2);

dt = 0.01;  t = 0;
sqrt_bis = sqrt(2*B*dt);

while X1 > theta && X2 > theta
    t = t + dt;
    X1 = X1 + dt*(rho*exp(-2*t/tau) - alpha)  + sqrt_bis*randn;
    X2 = X2 + dt*(rho*exp(-2*t/tau) - alpha)  + sqrt_bis*randn;
end
T1exit = t;

if X1 <= theta
    X2 = X2 - kappa;
    while X2 > theta
        t = t + dt;
        X2 = X2 + dt*(rho*exp(-t/tau) - alpha)  + sqrt_bis*randn;
    end
    T2exit = t;
    
elseif X2 <= theta
    X1 = X1 - kappa;
    while X1 > theta
        t = t + dt;
        X1 = X1 + dt*(rho*exp(-t/tau) - alpha)  + sqrt_bis*randn;
    end
    T2exit = t;
end

end