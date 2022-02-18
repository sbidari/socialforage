% Generate confusion matrix in figure 6

clear;
Rd = [255,245,240;254,229,217;254,224,210;252,187,161;252,174,145;252,146,114;251,106,74;239,59,44;222,45,38;203,24,29;165,15,21;153,0,13;103,0,13]/255;
CM = nan(3,3);
bflim = 0;

load('BF_n50.mat','BF_nc','BF_diff','BF_pulse')
BF = [BF_nc-BF_diff,BF_nc-BF_pulse,BF_diff-BF_pulse];

iter=100;   [n,m] = size(BF);
% Increase number of iterations but it will take a long time to run!


for ii = 0:m-1
    N = 0;  D = 0;  P = 0;  O = 0;
    for jj = 1:iter
        if BF(jj+ii*iter,1) < -bflim && BF(jj+ii*iter,3) > bflim
            D = D+1;
        elseif BF(jj+ii*iter,1) > bflim && BF(jj+ii*iter,2) > bflim
            N = N+1;
        elseif BF(jj+ii*iter,2) < -bflim && BF(jj+ii*iter,3) < -bflim
            P = P+1;
        else
            O = O+1;
        end
    end
   
CM(ii+1,1) = N/(iter);    CM(ii+1,2) = D/(iter);    CM(ii+1,3) = P/(iter);    Unidentified(ii+1) = O/(iter);
end

figure; colormap(Rd);
h=heatmap(round(CM,2),'XDisplayLabels',{'NC','Diff','Pulse'},'YDisplayLabels',{'NC','Diff','Pulse'},...
    'Colormap',Rd,'ColorbarVisible','off')%,'CellLabelColor','none');
set(gca,'fontsize',25); 
set(groot,'defaultAxesTickLabelInterpreter','latex');  

