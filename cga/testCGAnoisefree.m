%testCGA
clear all

mycolor={'k','r','b','g','m','c','y'};
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
for j=1:length(K)
    k = d*K(j);
    cga=NaN(nTrials,T/2);
    for i=1:nTrials
        res = CompactGA('OneMax','OneMax',d,k,2,T);
        cga(i,1:length(res)) = res;
        cga(i,length(res)+1:end) = res(end);
    end
    meanCGA(j,:)=mean(cga);
    stdCGA(j,:)=std(cga)/sqrt(nTrials);
    h(j)=boundedline(X, meanCGA(j,:), stdCGA(j,:), mycolor{j});
    plot(X, meanCGA(j,:), mycolor{j});
    if (j==1)
        strlegend=sprintf('%s ''cGA, k=d'',', strlegend);
    else
        if(j<length(K))
            strlegend=sprintf('%s ''cGA, k=%dd'',', strlegend, K(j));
        else
            strlegend=sprintf('%s ''cGA, k=%dd''}, ''Location'', ''Best'')', strlegend, K(j));
        end
    end
end
title(sprintf('%d-bit OneMax - std(Noise)=1', d));
xlabel('Evaluation number');
ylabel('Noise-free fitness of solution');
grid on

eval(strlegend);
saveas(gcf, sprintf('res/onemax_cGA_d%d_T%d_stop.png',d,T));
save(sprintf('res/onemax_cGA_d%d_T%d_stop.mat',d,T),'K','nTrials','meanCGA','stdCGA');