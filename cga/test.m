%test
clear all
d=100;
K=2000;
w=20;
np=10;
r=3;
T=1000;
nTrials=100;

p2=NaN(nTrials,T/2);
p3=NaN(nTrials,T/np);
p4=NaN(nTrials,floor(T/r));

for i=1:nTrials
    res2 = CompactGA('OneMax','NoisyOneMax',d,K,2,T);
    p2(i,1:length(res2)) = res2;
    p2(i,length(res2)+1:end) = res2(end);
    res3 = CompactGA('OneMax','NoisyOneMax',d,K,np,T);
    p3(i,1:length(res3)) = res3;
    p3(i,length(res3)+1:end) = res3(end);
    res4 = RMHC('OneMax','NoisyOneMax',d,r,T);
    p4(i,1:length(res4)) = res4;
    p4(i,length(res4)+1:end) = res4(end);
%     res5 = MABRMHC('OneMax','NoisyOneMax',d,r,T);
%     p5(i,1:length(res5)) = res5;
%     p5(i,length(res5)+1:end) = res5(end);
end
window=[10 20 30 40 50];
meanSW = zeros(length(window),T);
stdSW = zeros(length(window),T);
for j=1:length(window)
    w = window(j);
    p = NaN(nTrials,T);
    for i=1:nTrials
        res = WindowCompactGA('OneMax','NoisyOneMax',d,K,w,T);
        p(i,1:length(res)) = res;
        p(i,length(res)+1:end) = res(end);
    end
    meanSW(j,:)=mean(p);
    stdSW(j,:)=std(p)/sqrt(nTrials);
end

figure
set(gca,'fontsize',18)

hold on
h2=boundedline([1:T/2]*2, mean(p2), std(p2)/sqrt(nTrials), '-k');
h3=boundedline([1:T/np]*np, mean(p3), std(p3)/sqrt(nTrials), '-.k');
h4=boundedline([1:floor(T/r)]*r, mean(p4), std(p4)/sqrt(nTrials), ':k');

hw1=boundedline([1:T], meanSW(1,:), stdSW(1), '-b');
hw2=boundedline([1:T], meanSW(2,:), stdSW(2), '-r');
hw3=boundedline([1:T], meanSW(3,:), stdSW(3), '-g');
hw4=boundedline([1:T], meanSW(4,:), stdSW(4), '-m');
hw5=boundedline([1:T], meanSW(5,:), stdSW(5), '-c');

% set(h1, 'color', 'r', 'marker', 'x');

plot([1:T/2]*2, mean(p2), '--k');
plot([1:T/np]*np, mean(p3), '-.k');
plot([1:floor(T/r)]*r, mean(p4), ':k');
plot([1:T], meanSW(1,:), '-b');
plot([1:T], meanSW(2,:), '-r');
plot([1:T], meanSW(3,:), '-g');
plot([1:T], meanSW(4,:), '-m');
plot([1:T], meanSW(5,:), '-c');

title(sprintf('Noisy OneMax - d=%d, std(Noise)=1', d));
xlabel('Evaluation number');
ylabel('Noise-free fitness of solution');
grid on

legend([h2 h3 h4 hw1 hw2 hw3 hw4 hw5],{sprintf('cGA, %d parents', 2), sprintf('cGA, %d parents', np), sprintf('RMHC r=%d', r), sprintf('SWcGA w=%d',10), sprintf('SWcGA w=%d',20), sprintf('SWcGA w=%d',30), sprintf('SWcGA w=%d',40), sprintf('SWcGA w=%d',50)}, 'Location', 'Best');
saveas(gcf, sprintf('noisyonemax_d%d_T%d_W%d_stop.png',d,T,w));

cga=p2;
cga10=p3;
rmhc=p4;
save('results.mat','cga','10','rmhc','meanSW','stdSW');