% Generates figures 3.a.b.c

clear;

C = [84,48,5;140,81,10;166,97,26;191,129,45;216,179,101;223,194,125;246,232,195;245,245,245;199,234,229;128,205,193;90,180,172;53,151,143;1,133,113;1,102,94;0,60,48];
C = C/255;

Rd = [255,255,204;255,255,178;255,237,160;254,217,118;254,204,92;254,178,76;253,141,60;252,78,42;240,59,32;227,26,28;189,0,38;177,0,38;128,0,38];
Rd = Rd/255;

Bl = [247,251,255;239,243,255;222,235,247;198,219,239;189,215,231;158,202,225;107,174,214;66,146,198;49,130,189;33,113,181;8,81,156;8,69,148;8,48,107];
Bl = Bl/255;

Gr = [247,252,245;237,248,233;229,245,224;199,233,192;186,228,179;161,217,155;116,196,118;65,171,93;49,163,84;35,139,69;0,109,44;0,90,50;0,68,27];
Gr = Gr/255;

Pr = [252,251,253;242,240,247;239,237,245;218,218,235;203,201,226;188,189,220;158,154,200;128,125,186;117,107,177;106,81,163;84,39,143;74,20,134;63,0,125];
Pr = Pr/255;

figure;
ax1 = axes('Position',[0.14821,0.22142,0.59286,0.67617],'Box','off');
hold on; colormap(hot)
load('diff_rr_rho4.mat','RR','list_kappa','list_theta','RR_inf')
RR_inf = RR_inf';
pcolor(list_kappa,list_theta,RR);
shading flat;  caxis([0 max(RR_inf)]);
set(gca,'fontsize',35);  box off;
xlabel('$\kappa$','Interpreter','latex');
ylabel('$\theta$','Interpreter','latex');
set(groot,'defaultAxesTickLabelInterpreter','latex');

for k = 1:length(list_kappa)
    R_kappa = RR(:,k);    
    pos = find(R_kappa == max(R_kappa));
    opt_theta(k) = list_theta(pos(1));
end

M = movmean(opt_theta,3);
plot(list_kappa,M,'linewidth',3,'Color',[.5 .5 .5])

% create second plot
ax2 = axes('Position',[0.748214,0.22381,0.03214,0.671426],'Box','off');
pcolor(1:2,list_theta,[RR_inf;RR_inf]');
set(gca,'fontsize',30,'xticklabel',{[]},'yticklabel',{[]});
shading flat;   colorbar('TickLabelInterpreter','latex');
colormap(hot);  caxis([0 max(RR_inf)]);
linkaxes([ax1 ax2],'y')
axis('tight')

%Asymmetric RR plot ----------------------
%%{

%%HH 
load('asym/asHHr4_diff.mat','RR','list_kappa','list_theta')
[row, col] = find(ismember(RR, max(RR(:))));
opt_kappa_HH = list_kappa(col(1))
opt_theta_HH = list_theta(row(1))
max_RR_HH = max(RR(:))
d_theta = list_theta(2)-list_theta(1);
d_kappa = list_kappa(2)-list_kappa(1);
[gx, gy] = gradient(RR,d_kappa,d_theta);
[gyx, gyy] = gradient(gy,d_kappa);
[gxx, gxy] = gradient(gx,d_theta);
Hes_HH = [gxx(row(1),col(1)) gxy(row(1),col(1)); gyx(row(1),col(1)) gyy(row(1),col(1))];
MS_HH = det(Hes_HH);

%%HL
load('asym/asHLr4_diff.mat','RR','list_kappa','list_theta')
[row, col] = find(ismember(RR, max(RR(:))));
opt_kappa_HL = list_kappa(col(1))
opt_theta_HL = list_theta(row(1))
max_RR_HL = max(RR(:))
d_theta = list_theta(2)-list_theta(1);
d_kappa = list_kappa(2)-list_kappa(1);
[gx, gy] = gradient(RR,d_kappa,d_theta);
[gyx, gyy] = gradient(gy,d_kappa);
[gxx, gxy] = gradient(gx,d_theta);
Hes_HL = [gxx(row(1),col(1)) gxy(row(1),col(1)); gyx(row(1),col(1)) gyy(row(1),col(1))];
MS_HL = det(Hes_HL);

%%LH
load('asym/asLHr4_diff.mat','RR','list_kappa','list_theta')
[row, col] = find(ismember(RR, max(RR(:))));
opt_kappa_LH = list_kappa(col(1))
opt_theta_LH = list_theta(row(1))
max_RR_LH = max(RR(:))
d_theta = list_theta(2)-list_theta(1);
d_kappa = list_kappa(2)-list_kappa(1);
[gx, gy] = gradient(RR,d_kappa,d_theta);
[gyx, gyy] = gradient(gy,d_kappa);
[gxx, gxy] = gradient(gx,d_theta);
Hes_LH = [gxx(row(1),col(1)) gxy(row(1),col(1)); gyx(row(1),col(1)) gyy(row(1),col(1))];
MS_LH = det(Hes_LH);

%%LL
load('asym/asLLr4_diff.mat','RR','list_kappa','list_theta')
[row, col] = find(ismember(RR, max(RR(:))));
opt_kappa_LL = list_kappa(col(1))
opt_theta_LL = list_theta(row(1))
max_RR_LL = max(RR(:))
d_theta = list_theta(2)-list_theta(1);
d_kappa = list_kappa(2)-list_kappa(1);
[gx, gy] = gradient(RR,d_kappa,d_theta);
[gyx, gyy] = gradient(gy,d_kappa);
[gxx, gxy] = gradient(gx,d_theta);
Hes_LL = [gxx(row(1),col(1)) gxy(row(1),col(1)); gyx(row(1),col(1)) gyy(row(1),col(1))];
MS_LL = det(Hes_LL);
  
%%sym
load('diff_rr_rho4.mat','RR','list_kappa','list_theta')
[row, col] = find(ismember(RR, max(RR(:))));
opt_kappa = list_kappa(col(1))
opt_theta = list_theta(row(1))
max_RR = max(RR(:))
d_theta = list_theta(2)-list_theta(1);
d_kappa = list_kappa(2)-list_kappa(1);
[gx, gy] = gradient(RR,d_kappa,d_theta);
[gyx, gyy] = gradient(gy,d_kappa);
[gxx, gxy] = gradient(gx,d_theta);
Hes = [gxx(row(1),col(1)) gxy(row(1),col(1)); gyx(row(1),col(1)) gyy(row(1),col(1))];
MS = det(Hes);

t_H = -5;   t_L = -0.5;  k_H = 5;   k_L = 0.5;

figure; subplot(3,4,1); b=bar(1:2,[t_H; opt_theta_HH],'BarWidth',.7,'FaceColor','flat','FaceAlpha',.8,'EdgeColor','none');
hold on;
plot(linspace(.5,2.5,4),opt_theta*ones(1,4),'Color',[.4 .4 .4]);
b.CData(1,:) = Bl(11,:);  b.CData(2,:) = Bl(7,:);
ylabel('$\theta$','Interpreter','latex') 
set(gca,'fontsize',30,'xticklabel',{[]},'YDir','reverse'); box off; xlim([0.5 2.5]); ylim([-5 0]);
set(groot,'defaultAxesTickLabelInterpreter','latex');

subplot(3,4,5); b=bar(1:2,[k_H; opt_kappa_HH],'BarWidth',.7,'FaceColor','flat','FaceAlpha',.8,'EdgeColor','none');
hold on;
plot(linspace(.5,2.5,4),opt_kappa*ones(1,4),'Color',[.4 .4 .4]);
ylabel('$\kappa$','Interpreter','latex')
b.CData(1,:) = Bl(11,:);  b.CData(2,:) = Bl(7,:);
set(gca,'fontsize',30,'xticklabel',{[]}); box off; xlim([0.5 2.5]);
set(groot,'defaultAxesTickLabelInterpreter','latex');

subplot(3,4,9); b=bar(1,max_RR_HH ,'BarWidth',.3,'FaceColor','flat','FaceAlpha',.8,'EdgeColor','none');   
hold on; 
plot(linspace(.5,1.5,4),max_RR*ones(1,4),'Color',[.4 .4 .4])%,'BarWidth',.25);
ylabel('$RR$','Interpreter','latex') 
b.CData = Bl(11,:);
set(gca,'fontsize',30,'xticklabel',{[]}); box off; xlim([0.5 1.5]);
set(groot,'defaultAxesTickLabelInterpreter','latex');

subplot(3,4,2); b=bar(1:2,[t_H; opt_theta_HL],'BarWidth',.7,'FaceColor','flat','FaceAlpha',.8,'EdgeColor','none');
hold on;
plot(linspace(.5,2.5,4),opt_theta*ones(1,4),'Color',[.4 .4 .4]);
b.CData(1,:) = Pr(11,:);  b.CData(2,:) = Pr(7,:);
set(gca,'fontsize',30,'xticklabel',{[]},'yticklabel',{[]},'YDir','reverse'); box off; xlim([0.5 2.5]); ylim([-5 0]);

subplot(3,4,6); b=bar(1:2,[k_L opt_kappa_HL],'BarWidth',.7,'FaceColor','flat','FaceAlpha',.8,'EdgeColor','none');
hold on;
plot(linspace(.5,2.5,4),opt_kappa*ones(1,4),'Color',[.4 .4 .4])
b.CData(1,:) = Pr(11,:);  b.CData(2,:) = Pr(7,:);
set(gca,'fontsize',30,'xticklabel',{[]},'yticklabel',{[]}); box off; xlim([0.5 2.5]);

subplot(3,4,10); b=bar(1,max_RR_HL ,'BarWidth',.3,'FaceColor','flat','FaceAlpha',.8,'EdgeColor','none');   
hold on; 
plot(linspace(.5,1.5,4),max_RR*ones(1,4),'Color',[.4 .4 .4])%,'BarWidth',.25);
b.CData = Pr(11,:);
set(gca,'fontsize',30,'xticklabel',{[]},'yticklabel',{[]}); box off; xlim([0.5 1.5]);

subplot(3,4,3); b=bar(1:2,[t_L opt_theta_LH],'BarWidth',.7,'FaceColor','flat','FaceAlpha',.8,'EdgeColor','none');
hold on;
plot(linspace(.5,2.5,4),opt_theta*ones(1,4),'Color',[.4 .4 .4]);
b.CData(1,:) = Rd(11,:);  b.CData(2,:) = Rd(7,:);
set(gca,'fontsize',30,'xticklabel',{[]},'yticklabel',{[]},'YDir','reverse'); box off; 
xlim([0.5 2.5]); ylim([-5 0]);

subplot(3,4,7); b=bar(1:2,[k_H opt_kappa_LH],'BarWidth',.7,'FaceColor','flat','FaceAlpha',.8,'EdgeColor','none');
hold on;
plot(linspace(.5,2.5,4),opt_kappa*ones(1,4),'Color',[.4 .4 .4])
b.CData(1,:) = Rd(11,:);  b.CData(2,:) = Rd(7,:);
set(gca,'fontsize',30,'xticklabel',{[]},'yticklabel',{[]}); box off; xlim([0.5 2.5]);

subplot(3,4,11); b=bar(1,max_RR_LH ,'BarWidth',.3,'FaceColor','flat','FaceAlpha',.8,'EdgeColor','none');   
hold on; 
plot(linspace(.5,1.5,4),max_RR*ones(1,4),'Color',[.4 .4 .4])%,'BarWidth',.25);
b.CData = Rd(11,:);
set(gca,'fontsize',30,'xticklabel',{[]},'yticklabel',{[]}); box off; xlim([0.5 1.5]);

subplot(3,4,4); b=bar(1:2,[t_L opt_theta_LL],'BarWidth',.7,'FaceColor','flat','FaceAlpha',.8,'EdgeColor','none');
hold on;
plot(linspace(.5,2.5,4),opt_theta*ones(1,4),'Color',[.4 .4 .4]);
b.CData(1,:) = Gr(11,:);  b.CData(2,:) = Gr(7,:);
set(gca,'fontsize',30,'xticklabel',{[]},'yticklabel',{[]},'YDir','reverse'); box off; xlim([0.5 2.5]); ylim([-5 0]);

subplot(3,4,8); b=bar(1:2,[k_L opt_kappa_LL],'BarWidth',.7,'FaceColor','flat','FaceAlpha',.8,'EdgeColor','none');
hold on;
plot(linspace(.5,2.5,4),opt_kappa*ones(1,4),'Color',[.4 .4 .4])
b.CData(1,:) = Gr(11,:);  b.CData(2,:) = Gr(7,:);
set(gca,'fontsize',30,'xticklabel',{[]},'yticklabel',{[]}); box off; xlim([0.5 2.5]);

subplot(3,4,12); b=bar(1,max_RR_LL ,'BarWidth',.3,'FaceColor','flat','FaceAlpha',.8,'EdgeColor','none');   
hold on; 
plot(linspace(.5,1.5,4),max_RR*ones(1,4),'Color',[.4 .4 .4])%,'BarWidth',.25);
b.CData = Gr(11,:);
set(gca,'fontsize',30,'xticklabel',{[]},'yticklabel',{[]}); box off; xlim([0.5 1.5]);

% Asym PRT plots -----------------------------

%%{
f = figure;
ax1 = axes('Parent',f); hold on;
load('diff_rr_rho4.mat','RR','p_1','p_2','t')
[row, col] = find(ismember(RR, max(RR(:))));
p_1 = squeeze(p_1(row(1),col(1),:)); p_1 = [0; p_1];
p_2 = squeeze(p_2(row(1),col(1),:)); p_2 = [0; p_2];
plot(t,p_1(1:end-1),'LineWidth',4,'color',[0 0 0])
% plot(t,p_2(1:end-1),'LineWidth',2,'color',C(1,:))
set(gca,'fontsize',30); 
ylabel('$p(T)$','Interpreter','latex');
xlim([0 30])
ylim([0 .2])

%%HH
load('asym/asHHr4_diff.mat','RR','p_1','p_2','t')
[row, col] = find(ismember(RR, max(RR(:))));
p_1 = squeeze(p_1(row(1),col(1),:)); p_1 = [0; p_1]; p_1 = p_1(1:end-1);
% p_2 = squeeze(p_2(row(1),col(1),:)); p_2 = [0; p_2]; p_2 = p_2(1:end-1);
plot(t,p_1,'LineWidth',3,'color',Bl(11,:))
% plot(t,p_2,'LineWidth',2,'color',Bl(11,:))

%%LH
load('asym/asLHr4_diff.mat','RR','p_1','p_2','t')
[row, col] = find(ismember(RR, max(RR(:))));
p_1 = squeeze(p_1(row(1),col(1),:)); p_1 = [0; p_1]; p_1 = p_1(1:end-1);
% p_2 = squeeze(p_2(row(1),col(1),:)); p_2 = [0; p_2]; p_2 = p_2(1:end-1);
plot(t,p_1,'LineWidth',3,'color',Rd(11,:))
xlim([0 30])
ylim([0 .2])


%%HL
Bl = [247,251,255;239,243,255;222,235,247;198,219,239;189,215,231;158,202,225;107,174,214;66,146,198;49,130,189;33,113,181;8,81,156;8,69,148;8,48,107];
Bl= Bl/255;
ax2 = axes('Parent',f,'Units','normalized','Position',[0.425,0.188405797101449,0.251579925650558,0.737784679089028]);
hold on;
load('asym/asHLr4_diff.mat','RR','p_1','p_2','t')
[row, col] = find(ismember(RR, max(RR(:))));
p_1 = squeeze(p_1(row(1),col(1),:)); p_1 = [0; p_1]; p_1 = p_1(1:end-1);
p_2 = squeeze(p_2(row(1),col(1),:)); p_2 = [0; p_2]; p_2 = p_2(1:end-1);
plot(t,p_1,'LineWidth',3,'color',Pr(7,:))
plot(t,p_2,'LineWidth',3,'color',Pr(11,:))
set(gca,'fontsize',30,'yticklabel',{[]});
xlabel('$T$','Interpreter','latex'); 
legend('$p(T_1)$','$p(T_2)$','Interpreter','latex','EdgeColor','none')
xlim([0 30])
ylim([0 .2])

%%LL
Gr = [247,252,245;237,248,233;229,245,224;199,233,192;186,228,179;161,217,155;116,196,118;65,171,93;49,163,84;35,139,69;0,109,44;0,90,50;0,68,27];
Gr = Gr/255;
ax3 = axes('Parent',f,'Units','normalized','Position',[0.684014869888476,0.188405797101449,0.261107081331036,0.740165631469982]);
hold on;
load('asym/asLLr4_diff.mat','RR','p_1','p_2','t')
[row, col] = find(ismember(RR, max(RR(:))));
p_1 = squeeze(p_1(row(1),col(1),:)); p_1 = [0; p_1]; p_1 = p_1(1:end-1);
p_2 = squeeze(p_2(row(1),col(1),:)); p_2 = [0; p_2]; p_2 = p_2(1:end-1);
plot(t,p_1,'LineWidth',3,'color',Gr(7,:))
plot(t,p_2,'LineWidth',3,'color',Gr(11,:))
set(gca,'fontsize',30,'yticklabel',{[]});
legend('$p(T_1)$','$p(T_2)$','Interpreter','latex','EdgeColor','none')
xlim([0 30])
ylim([0 .2])

%}
