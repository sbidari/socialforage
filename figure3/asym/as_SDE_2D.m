function [T1exit,T2exit] = as_SDE_2D(tau,B,k1,k2,alpha,rho,theta1,theta2,Xzero)

X1 = Xzero(1);
X2 = Xzero(2);

dt = 0.01;  t = 0;
sqrt_bis = sqrt(2*B*dt);

while X1 > theta1 && X2 > theta2
    t = t + dt;
    X1 = X1 + dt*(rho*exp(-2*t/tau) - alpha)  + dt*k1*(X2 - X1) + dt*k1*(theta1-theta2) + sqrt_bis*randn;
    X2 = X2 + dt*(rho*exp(-2*t/tau) - alpha)  + dt*k2*(X1 - X2) + dt*k2*(theta2-theta1) + sqrt_bis*randn;
end

if X1 <= theta1
    T1exit = t;
    while X2 > theta2
        t = t + dt;
        X2 = X2 + dt*(rho*exp(-t/tau) - alpha) + dt*k2*(theta2 - X2) + sqrt_bis*randn;
    end
    T2exit = t;
    
elseif X2 <= theta2
    T1exit = t;
    X1 = X1 - k1;
    while X1 > theta1
        t = t + dt;
        X1 = X1 + dt*(rho*exp(-t/tau) - alpha)  + dt*k1*(theta1 - X1) + sqrt_bis*randn;
    end
    T2exit = t;
end

end