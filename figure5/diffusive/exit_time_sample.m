function [T1,T2] = exit_time_sample(tau,B,kappa,alpha,rho,theta,Xzero,ntrials)

dt = 0.01;  
T1 = zeros(ntrials,1);
T2 = zeros(ntrials,1);

for nn = 1:ntrials
    
    X1 = Xzero(1);
    X2 = Xzero(2);
    t = 0;
    
    while X1 > theta && X2 > theta
        t = t + dt;
        X1 = X1 + dt*(rho*exp(-2*t/tau) - alpha)  + dt*kappa*(X2 - X1) + sqrt(2*B*dt)*randn;
        X2 = X2 + dt*(rho*exp(-2*t/tau) - alpha)  + dt*kappa*(X1 - X2) + sqrt(2*B*dt)*randn;
    end
    
    if X1 <= theta
        T1(nn) = t;
        while X2 > theta
            t = t + dt;
            X2 = X2 + dt*(rho*exp(-t/tau) - alpha) + dt*kappa*(theta - X2) + sqrt(2*B*dt)*randn;
        end
        T2(nn) = t;
        
    elseif X2 <= theta
        T1(nn) = t;
        X1 = X1 - kappa;
        while X1 > theta
            t = t + dt;
            X1 = X1 + dt*(rho*exp(-t/tau) - alpha)  + dt*kappa*(theta - X1) + sqrt(2*B*dt)*randn;
        end
        T2(nn) = t;
    end
    
end

end