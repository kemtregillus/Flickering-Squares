%%%%%%%%Analysis code for flickerSquaresStair and flicker_noAdapt
%%%%%%%%written by Katie Tregillus, email: kmussell@gmail.com

clear all
close all

load 'testin_No_Adapt_30-Jun-2016.mat'
load 'testin_Adapt_30-Jun-2016.mat'

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
        sum1 = sum(outNoAdapt.responses(NrespsNoAdapt(i)-3:NrespsNoAdapt(i)));
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
        sum1 = sum(outAdapt.responses(NrespsAdapt(i)-3:NrespsAdapt(i)));
        respMeansAdapt(i) = sum1/4;
    else
        respMeansAdapt(i) = 0;
    end
end

scatter(outAdapt.means(2,:),respMeansAdapt);
hold on
scatter(outNoAdapt.means(2,:),respMeansNoAdapt);

        