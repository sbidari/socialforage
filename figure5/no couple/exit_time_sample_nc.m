function [T1,T2] = exit_time_sample_nc(alpha,theta,tau,B,rho,Xzero,ntrials)

dt = 0.01; sqrt_bis = sqrt(2*B*dt);
T1 = zeros(ntrials,1);
T2 = zeros(ntrials,1);

for i = 1:ntrials
    
    X1 = Xzero(1);
    X2 = Xzero(2);
    t = 0;
    
    while X1 > theta && X2 > theta
        t = t + dt;
        X1 = X1 + dt*(rho*exp(-2*t/tau) - alpha)  + sqrt_bis*randn;
        X2 = X2 + dt*(rho*exp(-2*t/tau) - alpha)  + sqrt_bis*randn;
    end
    T1(i) = t;
    
    if X1 <= theta
        while X2 > theta
            t = t + dt;
            X2 = X2 + dt*(rho*exp(-t/tau) - alpha)  + sqrt_bis*randn;
        end
        T2(i) = t;
        
    elseif X2 <= theta
        while X1 > theta
            t = t + dt;
            X1 = X1 + dt*(rho*exp(-t/tau) - alpha)  + sqrt_bis*randn;
        end
        T2(i) = t;
    end
end

end