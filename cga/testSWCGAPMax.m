%testCGA NoiseOneMax
clear all

mycolor={'k','r','b','g','m', ':k', ':r', ':b', ':g', ':m'};
d=100;
T=1000;
nTrials=100;

W=[1 4 6 8 10 20 30 40 50];

K=[1 0.01 0.1 0.5 2 5 10 20 50 100];
for kidx=length(K):-1:1
k=K(kidx)*d

figure
set(gca,'fontsize',18)
hold on
X=[1:T];
strlegend = 'legend(h,{';
for j=length(W):-1:2
    w = W(j);
    cga=NaN(nTrials,T);
    for i=1:nTrials
        res = SlidingWindowCompactGA('PMax','SampleGame',d,k,w,T);
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
    res = CompactGA('PMax','SampleGame',d,0.5*d,2,T);
    cga(i,1:length(res)) = res;
    cga(i,length(res)+1:end) = res(end);
end
boundedline([1:T/2]*2, mean(cga), std(cga)/sqrt(nTrials), mycolor{j});
h(length(W)-j+1)=plot([1:T/2]*2, mean(cga), mycolor{j}, 'LineWidth', 1);
strlegend=sprintf('%s ''cGA, k=0.50d''}, ''Location'', ''SouthEast'')', strlegend);


title(sprintf('%d-bit PMax - k=%.2fd', d, K(kidx)));
xlabel('Evaluation number');
ylabel('Winning rate');
grid on
eval(strlegend);
legend boxoff  
axis([0 1000 0.2 1])

saveas(gcf, sprintf('res/PMax_SWcGA_d%d_k%d_T%d_stop.png',d,k,T));
end