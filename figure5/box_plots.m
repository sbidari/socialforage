% Generate the box plots for error in Figure 5.b

clear;

%% No coupling 

load('no couple/LH_nc.mat','actual_theta','actual_B','B_ml','theta_ml');
val_B =  abs(actual_B-B_ml)./max(abs(actual_B),abs(B_ml));
val_theta = abs(actual_theta-theta_ml)./max(abs(actual_theta),abs(theta_ml));
val_kappa = nan(size(val_theta));

v50 = [val_theta(:,1);val_B(:,1);val_kappa(:,1)];
v100 = [val_theta(:,2);val_B(:,2);val_kappa(:,2)];
v500 = [val_theta(:,3);val_B(:,3);val_kappa(:,3)];
V = [v50;v100;v500];

% Create a corresponding x-vector, indicating which column each row came from
x=ones(size(val_B,1),1)*(1:size(val_B,2));
x = [x(:);x(:);x(:)];
% convert to dates
d=1:9;
d=categorical(d(x));

% Create a group vector, indicating which data set each row came from
G = ones(size(v50));
G = [G;G*2;G*3];

figure;
% Create boxchart
b1=boxchart(d,V,'GroupByColor',G,'Notch','on','MarkerStyle','+','BoxFaceAlpha',.8)
legend('n=50','n=100','n=500','EdgeColor','none','Interpreter','latex');
set(gca,'fontsize',30); box off;  
ylabel('relative error','Interpreter','latex');
set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(gca,'XTick',[])
offset = .1;
text(1-offset,0-offset,'$\theta$','FontSize',35,'Interpreter','latex')
text(2-offset,0-offset,'$B$','FontSize',35,'Interpreter','latex')
% text(3,0-offset,'$\kappa$','FontSize',35,'Interpreter','latex')
Rd = [140,81,10;254,178,76;227,26,28;177,0,38]/255;
b1(1).BoxFaceColor = Rd(1,:);
b1(1).MarkerColor = Rd(1,:);
b1(2).BoxFaceColor = Rd(2,:);
b1(2).MarkerColor = Rd(2,:);
b1(3).BoxFaceColor = Rd(3,:);
b1(3).MarkerColor = Rd(3,:);


%% Diffusive
load('diffusive/err_diff.mat','actual_theta','actual_B','actual_kappa','kappa_ml','B_ml','theta_ml');

val_B =  abs(actual_B-B_ml)./max(abs(actual_B),abs(B_ml));
val_theta = abs(actual_theta-theta_ml)./max(abs(actual_theta),abs(theta_ml));
val_kappa = abs(actual_kappa-kappa_ml)./max(abs(actual_kappa),abs(kappa_ml));

v50 = [val_theta(:,1);val_B(:,1);val_kappa(:,1)];
v100 = [val_theta(:,2);val_B(:,2);val_kappa(:,2)];
v500 = [val_theta(:,3);val_B(:,3);val_kappa(:,3)];
V = [v50;v100;v500];

% Create a corresponding x-vector, indicating which column each row came from
x=ones(size(val_B,1),1)*(1:size(val_B,2));
x = [x(:);x(:);x(:)];
% convert to dates
d=1:9;
d=categorical(d(x));

% Create a group vector, indicating which data set each row came from
G = ones(size(v50));
G = [G;G*2;G*3];

figure;
% Create boxchart
b2=boxchart(d,V,'GroupByColor',G,'Notch','on','MarkerStyle','+','BoxFaceAlpha',.8)
% legend('n=50','n=100','n=500','EdgeColor','none','Interpreter','latex');
set(gca,'fontsize',30); box off;  
ylabel('relative error','Interpreter','latex');
set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(gca,'XTick',[])
offset = .1;
text(1-offset,0-offset,'$\theta$','FontSize',35,'Interpreter','latex')
text(2-offset,0-offset,'$B$','FontSize',35,'Interpreter','latex')
text(3-offset,0-offset,'$\kappa$','FontSize',35,'Interpreter','latex')
Rd = [140,81,10;254,178,76;227,26,28;177,0,38]/255;
b2(1).BoxFaceColor = Rd(1,:);
b2(1).MarkerColor = Rd(1,:);
b2(2).BoxFaceColor = Rd(2,:);
b2(2).MarkerColor = Rd(2,:);
b2(3).BoxFaceColor = Rd(3,:);
b2(3).MarkerColor = Rd(3,:);

%% Pulsatile

load('pulsatile/err_pulse.mat','actual_theta','actual_B','actual_kappa','kappa_ml','B_ml','theta_ml');
val_B =  abs(actual_B-B_ml)./max(abs(actual_B),abs(B_ml));
val_theta = abs(actual_theta-theta_ml)./max(abs(actual_theta),abs(theta_ml));
val_kappa = abs(actual_kappa-kappa_ml)./max(abs(actual_kappa),abs(kappa_ml));

v50 = [val_theta(:,1);val_B(:,1);val_kappa(:,1)];
v100 = [val_theta(:,2);val_B(:,2);val_kappa(:,2)];
v500 = [val_theta(:,3);val_B(:,3);val_kappa(:,3)];
V = [v50;v100;v500];

% Create a corresponding x-vector, indicating which column each row came from
x=ones(size(val_B,1),1)*(1:size(val_B,2));
x = [x(:);x(:);x(:)];
% convert to dates
d=1:9;
d=categorical(d(x));

% Create a group vector, indicating which data set each row came from
G = ones(size(v50));
G = [G;G*2;G*3];

figure;
% Create boxchart
b3=boxchart(d,V,'GroupByColor',G,'Notch','on','MarkerStyle','+','BoxFaceAlpha',.8)
% legend('n=50','n=100','n=500','EdgeColor','none','Interpreter','latex');
set(gca,'fontsize',30); box off;  
ylabel('relative error','Interpreter','latex');
set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(gca,'XTick',[])
offset = .1;
text(1-offset,0-offset,'$\theta$','FontSize',35,'Interpreter','latex')
text(2-offset,0-offset,'$B$','FontSize',35,'Interpreter','latex')
text(3-offset,0-offset,'$\kappa$','FontSize',35,'Interpreter','latex')
Rd = [140,81,10;254,178,76;227,26,28;177,0,38]/255;
b3(1).BoxFaceColor = Rd(1,:);
b3(1).MarkerColor = Rd(1,:);
b3(2).BoxFaceColor = Rd(2,:);
b3(2).MarkerColor = Rd(2,:);
b3(3).BoxFaceColor = Rd(3,:);
b3(3).MarkerColor = Rd(3,:);

