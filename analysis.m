%%%%%%%%Analysis code for flickerSquaresStair and flicker_noAdapt
%%%%%%%%written by Katie Tregillus, email: kmussell@gmail.com

clear all
close all

% load 'SC_No_Adapt_01-Jul-2016.mat'
% load 'SC_Adapt_01-Jul-2016.mat'

load 'KT_No_Adapt_01-Jul-2016.mat'
load 'KT_Adapt_01-Jul-2016.mat'

NrespsNoAdapt = zeros(1,25);
respMeansNoAdapt = zeros(1,25);
NrespsAdapt = zeros(1,25);
respMeansAdapt = zeros(1,25);
%% calculate mean of last 4 responses for No Adapt condition
for i = 1:25
    for j = 1:60
        if outNoAdapt.responses(j,i) ~= 0
            NrespsNoAdapt(i) = NrespsNoAdapt(i)+1;
        end
    end
end
for i = 1:25
    if NrespsNoAdapt(i) ~= 0
        prods = outNoAdapt.responses(NrespsNoAdapt(i)-3:NrespsNoAdapt(i),i);
        sum1 = sum(prods);
        respMeansNoAdapt(i) = sum1/4;
    else
        respMeansNoAdapt(i) = 0;
    end
end
%% calculate mean of last 4 responses for Adapt condition 
for i = 1:25
    for j = 1:60
        if outAdapt.responses(j,i) ~= 0
            NrespsAdapt(i) = NrespsAdapt(i)+1;
        end
    end
end
for i = 1:25
    if NrespsAdapt(i) ~= 0
        prods = outAdapt.responses(NrespsAdapt(i)-3:NrespsAdapt(i),i);
        sum1 = sum(prods);
        respMeansAdapt(i) = sum1/4;
    else
        respMeansAdapt(i) = 0;
    end
end

scatter(outAdapt.means(2,:),respMeansAdapt,'ob');
hold on
scatter(outNoAdapt.means(2,:),respMeansNoAdapt,'or');
p = polyfit(outAdapt.means(2,:),respMeansAdapt,1);
f = polyval(p,outAdapt.means(2,:));
hold on
plot(outAdapt.means(2,:),f,'--b')
p = polyfit(outNoAdapt.means(2,:),respMeansNoAdapt,1);
f = polyval(p,outNoAdapt.means(2,:));
hold on
plot(outNoAdapt.means(2,:),f,'--r')
hold on
plot(outAdapt.means(1,:),outAdapt.means(1,:),'-k')
axis('equal')
axis([0 3.5 0 3.5])
legend('Adapt','No Adapt','Location','NorthWest')

figure(2) 
mean02 = zeros(1,5);
mean09 = zeros(1,5);
mean16 = zeros(1,5);
mean23 = zeros(1,5);
mean3 = zeros(1,5);
count02 = 0;
count09 = 0;
count16 = 0;
count23 = 0;
count3 = 1;
meanAll = zeros(1,5);

for i = 1:25
    if outAdapt.means(1,i) == [0.200000000000000]
        count02 = count02+1;
        mean02(1,count02) = respMeansAdapt(i);
    end
    if outAdapt.means(1,i) == [0.900000000000000]
        count09 = count09+1;
        mean09(1,count09) = respMeansAdapt(i);
    end
    if outAdapt.means(1,i) == [1.60000000000000]
        count16 = count16+1;
        mean16(1,count16) = respMeansAdapt(i);
    end
    if outAdapt.means(1,i) == [2.30000000000000]
        count23 = count23+1;
        mean23(1,count23) = respMeansAdapt(i);
    end
    if outAdapt.means(1,i) == [3]
        count3 = count3+1;
        mean3(1,count3) = respMeansAdapt(i);
    end
end

meanAll(1,1) = sum(mean02)/5;
meanAll(1,2) = sum(mean09)/5;
meanAll(1,3) = sum(mean16)/5;
meanAll(1,4) = sum(mean23)/5;
meanAll(1,5) = sum(mean3)/5;
xNA = [0.2 0.9 1.6 2.3 3]
scatter(xNA,meanAll,'bo')

hold on
mean02 = zeros(1,5);
mean09 = zeros(1,5);
mean16 = zeros(1,5);
mean23 = zeros(1,5);
mean3 = zeros(1,5);
count02 = 0;
count09 = 0;
count16 = 0;
count23 = 0;
count3 = 1;
meanAll = zeros(1,5);

for i = 1:25
    if outNoAdapt.means(1,i) == [0.200000000000000]
        count02 = count02+1;
        mean02(1,count02) = respMeansNoAdapt(i);
    end
    if outNoAdapt.means(1,i) == [0.900000000000000]
        count09 = count09+1;
        mean09(1,count09) = respMeansNoAdapt(i);
    end
    if outNoAdapt.means(1,i) == [1.60000000000000]
        count16 = count16+1;
        mean16(1,count16) = respMeansNoAdapt(i);
    end
    if outNoAdapt.means(1,i) == [2.30000000000000]
        count23 = count23+1;
        mean23(1,count23) = respMeansNoAdapt(i);
    end
    if outNoAdapt.means(1,i) == [3]
        count3 = count3+1;
        mean3(1,count3) = respMeansNoAdapt(i);
    end
end

meanAll(1,1) = sum(mean02)/5;
meanAll(1,2) = sum(mean09)/5;
meanAll(1,3) = sum(mean16)/5;
meanAll(1,4) = sum(mean23)/5;
meanAll(1,5) = sum(mean3)/5;
xNA = [0.2 0.9 1.6 2.3 3]
scatter(xNA,meanAll,'ro')

hold on
   

hold on
plot(outAdapt.means(1,:),outAdapt.means(1,:),'-k')
axis('equal')
axis([0 3.5 0 3.5])
legend('Adapt','No Adapt','Location','NorthWest')