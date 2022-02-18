function [FPT_theta,CFPT_theta]=  FPE_numn_solve(t,x,dx,dt,B,alpha,rho,Xzero,L,theta,n,tau)

% Initialize variables
N = length(x);  time_steps = length(t);

P_total = zeros(N,time_steps);
P_int = zeros(N-1,time_steps);
x_int = x(2:end);

pos = ceil(((Xzero-theta)/(L-theta))*length(x))+1;
P_int(:,1)= initial(x_int,dx,pos);

% construct the constant functions
a = (rho*exp(-n*t/tau) - alpha)*dt/(4*dx);
b = (B*dt)/(2*dx^2);

%Crank Nicholson
%%{
for i=1:time_steps-1
    
    %Construct FD matrices to solve linear system M*U(j+1) = N*U(j) system for P;
    MM = diag((1+2*b)*ones(N-1,1), 0)...
        + diag([zeros(N-2,1); 4*a(i+1)*(a(i+1)-b)/b], 0)...
        + diag([(-a(i+1)-b)*ones(N-3,1); -2*b], -1)...
        + diag((a(i+1) - b)*ones(N-2,1), 1);
    MM = sparse(MM);
    
    NN = diag((1-2*b)*ones(N-1,1), 0)...
        + diag([zeros(N-2,1); -4*a(i)*(a(i)-b)/b], 0)...
        + diag([(a(i) + b)*ones(N-3,1); 2*b], -1)...
        + diag((-a(i) + b)*ones(N-2,1), 1);
    NN = sparse(NN);

    P_previous = P_int(:,i);
    P_next = MM\(NN*P_previous);
    P_int(:,i+1) = P_next;
%     i
end
%}

P_total(2:end,:) =  P_int;

%}

% figure; plot(x,P_total)

[~,P_diff] = gradient(P_total,dx);
FPT_theta = B*P_diff(1,:);
CFPT_theta = cumsum(FPT_theta)*dt;

% figure;
% plot(t(1:end-1), FPT_theta);

% trapz(t(1:end-1), FPT_theta)
% T = trapz(t(1:end-1), t(1:end-1).*FPT_theta);

end

function Y = initial(x_int,dx,pos)
Y = zeros(length(x_int),1);
Y(pos) = 1/dx;
end
