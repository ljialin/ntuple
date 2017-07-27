%%% RMHC
figure
nfht=load('dataSimon/rmhc_fd10T500.dat');
fht=load('dataSimon/rmhc_fd10FHT.dat');
plot(fht(:,2)/10000,'bo-','LineWidth',3);
hold on
plot(nfht(:,2)/10000,'ro-','LineWidth',3);
xlabel('Resampling number','FontSize',14);
ylabel('Optimum found (%)','FontSize',14);
legend('FHT','500 evals.')
title('RMHC','FontSize',14);
set(gca,'FontSize',12);
axis([1 20 0 0.6]);
print('pix/nbFindOpt_rmhc','-dpng')
%%%
figure
nfht=load('dataSimon/opo_nfd10T500.dat');
fht=load('dataSimon/opo_nfd10FHT.dat');
plot(fht(:,2)/10000,'bo-','LineWidth',3);
hold on
plot(nfht(:,2)/10000,'ro-','LineWidth',3);
xlabel('Resampling number','FontSize',14);
ylabel('Optimum found (%)','FontSize',14);
legend('FHT','500 evals.')
title('(1+1)-EA','FontSize',14);
set(gca,'FontSize',12);
axis([1 20 0 0.6]);
print('pix/nbFindOpt_opo','-dpng')
%%%
figure
nfht=load('dataSimon/opo_fd10T500.dat');
fht=load('dataSimon/opo_fd10FHT.dat');
plot(fht(:,2)/10000,'bo-','LineWidth',3);
hold on
plot(nfht(:,2)/10000,'ro-','LineWidth',3);
xlabel('Resampling number','FontSize',14);
ylabel('Optimum found (%)','FontSize',14);
legend('FHT','500 evals.')
title('(1+1)-EA, flip at least once','FontSize',14);
set(gca,'FontSize',12);
axis([1 20 0 0.6]);
print('pix/nbFindOpt_opoflip','-dpng')