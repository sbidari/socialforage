function [T1exit,T2exit] = SDE_2D_diff(tau,B,kappa,alpha,rho,theta,Xzero)

X1 = Xzero(1);
X2 = Xzero(2);

dt = 0.01;  t = 0;
sqrt_bis = sqrt(2*B*dt);

while X1 > theta && X2 > theta
    t = t + dt;
    X1 = X1 + dt*(rho*exp(-2*t/tau) - alpha)  + dt*kappa*(X2 - X1) + sqrt_bis*randn;
    X2 = X2 + dt*(rho*exp(-2*t/tau) - alpha)  + dt*kappa*(X1 - X2) + sqrt_bis*randn;
end

if X1 <= theta
    T1exit = t;
    while X2 > theta
        t = t + dt;
        X2 = X2 + dt*(rho*exp(-t/tau) - alpha) + dt*kappa*(theta - X2) + sqrt_bis*randn;
    end
    T2exit = t;
    
elseif X2 <= theta
    T1exit = t;
    X1 = X1 - kappa;
    while X1 > theta
        t = t + dt;
        X1 = X1 + dt*(rho*exp(-t/tau) - alpha)  + dt*kappa*(theta - X1) + sqrt_bis*randn;
    end
    T2exit = t;
end

end