%testrmhc PMax
clear all
close all
mycolor={'k','r','b','g','m', ':k', ':r', ':b', ':g', ':m'};
d=100;
T=1000;

nTrials=100;

R=[1:8];

% meanrmhc = zeros(length(R),T);
% stdrmhc = zeros(length(R),T);

figure
set(gca,'fontsize',18)
hold on

strlegend = 'legend(h,{';
for j=length(R):-1:1
    r = R(j);
    G=ceil(T/r);
    X=[1:G]*r;
    rmhc=NaN(nTrials,G);
    for i=1:nTrials
        res = RMHC('OneMax','NoisyOneMax',d,r,T);
        rmhc(i,1:length(res)) = res;
        rmhc(i,length(res)+1:end) = res(end);
    end
%     meanrmhc(j,:)=mean(rmhc);
%     stdrmhc(j,:)=std(rmhc)/sqrt(nTrials);
    boundedline(X, mean(rmhc), std(rmhc)/sqrt(nTrials), mycolor{j});
    h(length(R)-j+1)=plot(X, mean(rmhc), mycolor{j}, 'LineWidth', 1);
    if(j>1)
        strlegend=sprintf('%s ''RMHC, r=%d'',', strlegend, r);
    else
        strlegend=sprintf('%s ''RMHC, r=%d''}, ''Location'', ''SouthEast'')', strlegend, r);
    end
end
title(sprintf('%d-bit Noisy OneMax - std(Noise)=1', d));
xlabel('Evaluation number');
ylabel('Noise-free fitness of solution');
grid on


eval(strlegend);

legend boxoff  
axis([0 1000 20 100])
saveas(gcf, sprintf('res/NoisyOneMax_rmhc_d%d_T%d_stop.png',d,T));
% save(sprintf('res/PMax_rmhc_d%d_T%d_stop.mat',d,T),'R','nTrials','meanrmhc','stdrmhc');