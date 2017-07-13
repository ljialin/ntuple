%testCGA NoiseOneMax
clear all

mycolor={'k','r','b','g','m', ':k', ':r', ':b', ':g', ':m'};
d=100;
T=1000;
nTrials=100;

W=[1 5 10 20 30 40 50];


figure
set(gca,'fontsize',18)
hold on
X=[1:T];
k=d;
strlegend = 'legend(h,{';
for j=length(W):-1:2
    w = W(j);
    cga=NaN(nTrials,T);
    for i=1:nTrials
        res = SlidingWindowCompactGA('OneMax','NoisyOneMax',d,k,w,T);
        cga(i,1:length(res)) = res;
        cga(i,length(res)+1:end) = res(end);
    end
    boundedline(X, mean(cga), std(cga)/sqrt(nTrials), mycolor{j});
    h(length(W)-j+1)=plot(X, mean(cga), mycolor{j}, 'LineWidth', 1);
    if (j==1)
        strlegend=sprintf('%s ''SWcGA, w=%d''}, ''Location'', ''SouthEast'')', strlegend, w);
    else
        strlegend=sprintf('%s ''SWcGA, w=%d'',', strlegend, w);
    end
end
j=1;
cga=NaN(nTrials,T/2);
for i=1:nTrials
    res = CompactGA('OneMax','NoisyOneMax',d,k,2,T);
    cga(i,1:length(res)) = res;
    cga(i,length(res)+1:end) = res(end);
end
boundedline([1:T/2]*2, mean(cga), std(cga)/sqrt(nTrials), mycolor{j});
h(length(W)-j+1)=plot([1:T/2]*2, mean(cga), mycolor{j}, 'LineWidth', 1);
strlegend=sprintf('%s ''cGA, k=d''}, ''Location'', ''SouthEast'')', strlegend);
  
title(sprintf('%d-bit Noisy OneMax - std(Noise)=1', d));
xlabel('Evaluation number');
ylabel('Noise-free fitness of solution');
grid on

eval(strlegend);

legend boxoff  

saveas(gcf, sprintf('res/NoisyOneMax_SWcGA_d%d_T%d_stop.png',d,T));
% save(sprintf('res/noisyonemax_cGA_d%d_T%d_stop.mat',d,T),'K','nTrials','meanCGA','stdCGA');