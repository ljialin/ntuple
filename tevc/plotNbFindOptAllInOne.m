%%% RMHC
figure
nfht=load('dataSimon/rmhc_fd10T500.dat');
fht=load('dataSimon/rmhc_fd10FHT.dat');
plot(fht(:,2)/100,'r+-','LineWidth',2);
hold on
plot(nfht(:,2)/100,'ro:','LineWidth',2);

nfht=load('dataSimon/opo_nfd10T500.dat');
fht=load('dataSimon/opo_nfd10FHT.dat');
plot(fht(:,2)/100,'b+-','LineWidth',2);
hold on
plot(nfht(:,2)/100,'bo:','LineWidth',2);

nfht=load('dataSimon/opo_fd10T500.dat');
fht=load('dataSimon/opo_fd10FHT.dat');
plot(fht(:,2)/100,'g+-','LineWidth',2);
hold on
plot(nfht(:,2)/100,'go:','LineWidth',2);
xlabel('Resampling number','FontSize',14);
ylabel('Optimum found (%)','FontSize',14);

legend('RMHC, FHT', 'RMHC, T=500', '(1+1)-EA, FHT', '(1+1)-EA, T=500', '(1+1)-EA, FAO, FHT', '(1+1)-EA, FAO, T=500')

title('(1+1)-EA, flip at least once','FontSize',14);
set(gca,'FontSize',12);
axis([1 20 0 60]);
print('pix/nbFindOpt_allInOne','-dpng')