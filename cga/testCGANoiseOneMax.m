%testCGA NoiseOneMax
clear all

mycolor={'k','r','b','g','m', ':k', ':r', ':b', ':g', ':m'};
d=100;
T=1000;
nTrials=100;

K=[1 2 5 10 20 50 100];

meanCGA = zeros(length(K),T/2);
stdCGA = zeros(length(K),T/2);


figure
set(gca,'fontsize',18)
hold on
X=[1:T/2]*2;
strlegend = 'legend(h,{';
for j=length(K):-1:1
    k = d*K(j);
    cga=NaN(nTrials,T/2);
    for i=1:nTrials
        res = CompactGA('OneMax','NoisyOneMax',d,k,2,T);
        cga(i,1:length(res)) = res;
        cga(i,length(res)+1:end) = res(end);
    end
    meanCGA(j,:)=mean(cga);
    stdCGA(j,:)=std(cga)/sqrt(nTrials);
    boundedline(X, meanCGA(j,:), stdCGA(j,:), mycolor{j});
    h(length(K)-j+1)=plot(X, meanCGA(j,:), mycolor{j}, 'LineWidth', 1);
    if (j==1)
        strlegend=sprintf('%s ''cGA, k=d''}, ''Location'', ''SouthEast'')', strlegend);
    else
        strlegend=sprintf('%s ''cGA, k=%dd'',', strlegend, K(j));
    end
end
title(sprintf('%d-bit Noisy OneMax - std(Noise)=1', d));
xlabel('Evaluation number');
ylabel('Noise-free fitness of solution');
grid on

eval(strlegend);

legend boxoff  

saveas(gcf, sprintf('res/NoisyOneMax_cGA_d%d_T%d_stop.png',d,T));
% save(sprintf('res/noisyonemax_cGA_d%d_T%d_stop.mat',d,T),'K','nTrials','meanCGA','stdCGA');