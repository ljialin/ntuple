r=[1:50];
figure(1)

[pmax,h1,h2]=plotyy(r,SFHT(1,:),r, SNFHT(1,:));
set(h1,'Color','blue','LineStyle','-','linewidth',3)
set(h2,'Color','red','LineStyle',':','linewidth',3)
ylim(pmax(2),[0 1.5])
ylim(pmax(1),[0 30])
hold on
xlabel('Resampling rate','FontSize',14);
ylabel(pmax(1),'Success rate: first hit (%)','FontSize',14);
ylabel(pmax(2),'Success rate: final solution (%)','FontSize',14);

legend('FHT','No FHT');
title('Success rate versus sampling rate: Noisy PMax','FontSize',14);
set(gca,'FontSize',12);
print('pix/pmax_rmhc_d10','-dpng')
%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
[pmax,h1,h2]=plotyy(r,SFHT(2,:),r, SNFHT(2,:));
set(h1,'Color','blue','LineStyle','-','linewidth',3)
set(h2,'Color','red','LineStyle',':','linewidth',3)

hold on
xlabel('Resampling rate','FontSize',14);
ylabel(pmax(1),'Success rate: first hit (%)','FontSize',14);
ylabel(pmax(2),'Success rate: final solution (%)','FontSize',14);
ylim(pmax(2),[0 1.5])
ylim(pmax(1),[0 30])

legend('FHT','No FHT');
title('Success rate versus sampling rate: Noisy PMax','FontSize',14);
set(gca,'FontSize',12);
print('pix/pmax_opo_d10','-dpng')
%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3)
h1=plot(r,SFHT(3,:),'linewidth',3)
hold on 
h2=plot(r,SNFHT(3,:),'linewidth',3)
set(h1,'Color','blue','LineStyle','-','linewidth',3)
set(h2,'Color','red','LineStyle',':','linewidth',3)
hold on
xlabel('Resampling rate','FontSize',14);
ylabel('Success rate (%)','FontSize',14);

legend('FHT','No FHT');
title('Success rate versus sampling rate: Noisy OneMax','FontSize',14);
set(gca,'FontSize',12);
print('pix/onemax_rmhc_d10','-dpng')

%%%%%%%%%%%%%%%%%%%%%%%
figure(4)
h1=plot(r,SFHT(4,:),'linewidth',3)
hold on 
h2=plot(r,SNFHT(4,:),'linewidth',3)
set(h1,'Color','blue','LineStyle','-','linewidth',3)
set(h2,'Color','red','LineStyle',':','linewidth',3)
hold on
xlabel('Resampling rate','FontSize',14);
ylabel('Success rate (%)','FontSize',14);

legend('FHT','No FHT');
title('Success rate versus sampling rate: Noisy OneMax','FontSize',14);
set(gca,'FontSize',12);
axis([0 50 0 100])

print('pix/onemax_opo_d10','-dpng')

