clear all
close all

% load 'KT2_ensemble_22-Jul-2016'
% load 'WK_ensemble_01-Aug-2016.mat'
load 'MN_ensemble_03-Aug-2016.mat'


p1 = scatter(outAdapt.means(2,:),outAdapt.responses(2:26)');
hold on
p = polyfit(outAdapt.means(2,:),outAdapt.responses(2:26)',1);
f = polyval(p,outAdapt.means(2,:));
plot(outAdapt.means(2,:),f,'--b');
plot(outAdapt.means(1,:),outAdapt.means(1,:),'-k')


% load 'kt2_ensemble_28-Jul-2016.mat'
% load 'WK2_ensemble_01-Aug-2016.mat'
load 'MN_ensemble5_03-Aug-2016.mat'

p2 = scatter(outAdapt.means(2,:),outAdapt.responses(2:26)');
hold on
p = polyfit(outAdapt.means(2,:),outAdapt.responses(2:26)',1);
f = polyval(p,outAdapt.means(2,:));
plot(outAdapt.means(2,:),f,'--r');
axis('equal')
axis([0 6 0 6])
xlabel('Ensemble Mean (Hz)')
ylabel('Response (Hz)')
legend([p1,p2],'Ensemble Estimate (25 squares)','Ensemble Estimate (5 squares)','Location','NorthWest')


