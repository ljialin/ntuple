%testCGA NoiseOneMax
clear all

mycolor={'k','r','b','g','m', ':k', ':r', ':b', ':g', ':m'};
d=100;
T=1000;
nTrials=100;

% NP=[2:10];
% NP=[NP 20];
NP=[2 4 6 8 10 20 30 40 50];

% meanCGA = zeros(length(K),T/2);
% stdCGA = zeros(length(K),T/2);


figure
set(gca,'fontsize',18)
hold on
strlegend = 'legend(h,{';
for j=length(NP):-1:1
    np = NP(j);
    G = floor(T/np);
    cga=NaN(nTrials,G);
    X=[1:G]*np;
    for i=1:nTrials
        res = CompactGA('OneMax','NoisyOneMax',d,d,np,T);
        cga(i,1:length(res)) = res;
        cga(i,length(res)+1:end) = res(end);
    end
%     meanCGA(j,:)=mean(cga);
%     stdCGA(j,:)=std(cga)/sqrt(nTrials);
    boundedline(X, mean(cga), std(cga)/sqrt(nTrials), mycolor{j});
    h(length(NP)-j+1)=plot(X, mean(cga), mycolor{j}, 'LineWidth', 1);
    if (j==1)
        strlegend=sprintf('%s ''cGA, k=d''}, ''Location'', ''SouthEast'')', strlegend);
    else
        strlegend=sprintf('%s ''MScGA, %d parents'',', strlegend, np);
    end
end
title(sprintf('%d-bit Noisy OneMax - std(Noise)=1', d));
xlabel('Evaluation number');
ylabel('Noise-free fitness of solution');
grid on
eval(strlegend);
legend boxoff  

saveas(gcf, sprintf('res/NoisyOneMax_cGAMP_d%d_T%d_stop.png',d,T));
% save(sprintf('res/noisyonemax_cGAMP_d%d_T%d_stop.mat',d,T),'K','nTrials','meanCGA','stdCGA');