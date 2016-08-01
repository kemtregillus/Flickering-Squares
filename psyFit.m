clear all
close all
% 
% load 'SC_No_Adapt_01-Jul-2016.mat'
% load 'SC_Adapt_01-Jul-2016.mat'
% 
load 'KT_No_Adapt_01-Jul-2016.mat'
load 'KT_Adapt_01-Jul-2016.mat'
% 
% load 'AA_No_Adapt_04-Jul-2016.mat'
% load 'AA_Adapt_05-Jul-2016.mat'

% load 'wk_No_Adapt_04-Jul-2016.mat'
% load 'wk_Adapt_05-Jul-2016.mat'

% load 'ST_No_Adapt_11-Jul-2016.mat'
countUp = zeros(60,25);
bins = zeros(60,0);

NrespsAdapt = zeros(1,25);
%% calculate mean of last 4 responses for No Adapt condition
for i = 1:25
    for j = 1:60
        if outAdapt.responses(j,i) ~= 0
            NrespsAdapt(i) = NrespsAdapt(i)+1;
        end
    end
end
for i = 2:60
    for j = 1:25
        if outAdapt.responses(i,j) > outAdapt.responses(i-1,j)
            countUp(i-1,j) = 0;
        elseif outAdapt.responses(i,j) < outAdapt.responses(i-1,j)
            countUp(i-1,j) = 1;
        end
        %%%%start here for updates
        edges = [0 0.1 0.2 0.4 0.7 1.1 1.6 2.2 2.9 3.7];
        [N,edges,bin]=histcounts(outAdapt.responses(1:NrespsAdapt(j),j),edges);
        bins(1:NrespsAdapt(j),j) = bin;
    end
end

count02 = 0;
persUp02 = zeros(60,5);
binNum02 = zeros(60,5);


for j = 1:25
    if outAdapt.means(1,j) == [1.60000000000000]
        count02 = count02+1;
        persUp02(:,count02) = countUp(:,j);
        binNum02(:,count02) = bins(:,j);
    end
end

pers1 = 0;
pers2 = 0;
pers3 = 0;
pers4 = 0;
pers5 = 0;
pers6 = 0;
pers7 = 0;
pers8 = 0;
pers9 = 0;
pers10 = 0;

c1 = 0;
c2 = 0;
c3 = 0;
c4 = 0;
c5 = 0;
c6 = 0;
c7 = 0;
c8 = 0;
c9 = 0;
c10 = 0;

for i = 1:5
    for j = 1:60
        if binNum02(j,i) == 1
            c1 = c1+1;
            pers1 = pers1+persUp02(j,i);
        elseif binNum02(j,i) == 2
            c2 = c2+1;
            pers2 = pers2+persUp02(j,i);
        elseif binNum02(j,i) == 3
            c3 = c3+1;
            pers3 = pers3+persUp02(j,i);
        elseif binNum02(j,i) == 4
            c4 = c4+1;
            pers4 = pers4+persUp02(j,i);
        elseif binNum02(j,i) == 5
            c5 = c5+1;
            pers5 = pers5+persUp02(j,i);
        elseif binNum02(j,i) == 6
            c6 = c6+1;
            pers6 = pers6+persUp02(j,i);
        elseif binNum02(j,i) == 7
            c7 = c7+1;
            pers7 = pers7+persUp02(j,i);
        elseif binNum02(j,i) == 8
            c8 = c8+1;
            pers8 = pers8+persUp02(j,i);
        elseif binNum02(j,i) == 9
            c9 = c9+1;
            pers9 = pers9+persUp02(j,i);
        elseif binNum02(j,i) == 10
            c10 = c10+1;
            pers10 = pers10+persUp02(j,i);
        end
    end
end

pers1 = pers1/c1;
pers2 = pers2/c2;
pers3 = pers3/c3;
pers4 = pers4/c4;
pers5 = pers5/c5;
pers6 = pers6/c6;
pers7 = pers7/c7;
pers8 = pers8/c8;
pers9 = pers9/c9;
pers10 = pers10/c10;
resultsAdapt = [pers1 pers2 pers3 pers4 pers5 pers6 pers7 pers8 pers9 pers10];
x = [0 1 2 3 4 5 6 7 8 9];

scatter(x,resultsAdapt,'b')
            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
countUp = zeros(60,25);
bins = zeros(60,0);

NrespsAdapt = zeros(1,25);
%% calculate mean of last 4 responses for No Adapt condition
for i = 1:25
    for j = 1:60
        if outNoAdapt.responses(j,i) ~= 0
            NrespsAdapt(i) = NrespsAdapt(i)+1;
        end
    end
end
for i = 2:60
    for j = 1:25
        if outNoAdapt.responses(i,j) > outNoAdapt.responses(i-1,j)
            countUp(i-1,j) = 0;
        elseif outNoAdapt.responses(i,j) < outNoAdapt.responses(i-1,j)
            countUp(i-1,j) = 1;
        end
        %%%%start here for updates
        edges = [0 0.1 0.2 0.4 0.7 1.1 1.6 2.2 2.9 3.7];
        [N,edges,bin]=histcounts(outNoAdapt.responses(1:NrespsAdapt(j),j),edges);
        bins(1:NrespsAdapt(j),j) = bin;
    end
end

count02 = 0;
persUp02 = zeros(60,5);
binNum02 = zeros(60,5);


for j = 1:25
    if outNoAdapt.means(1,j) == [1.60000000000000]
        count02 = count02+1;
        persUp02(:,count02) = countUp(:,j);
        binNum02(:,count02) = bins(:,j);
    end
end

pers1 = 0;
pers2 = 0;
pers3 = 0;
pers4 = 0;
pers5 = 0;
pers6 = 0;
pers7 = 0;
pers8 = 0;
pers9 = 0;
pers10 = 0;

c1 = 0;
c2 = 0;
c3 = 0;
c4 = 0;
c5 = 0;
c6 = 0;
c7 = 0;
c8 = 0;
c9 = 0;
c10 = 0;

for i = 1:5
    for j = 1:60
        if binNum02(j,i) == 1
            c1 = c1+1;
            pers1 = pers1+persUp02(j,i);
        elseif binNum02(j,i) == 2
            c2 = c2+1;
            pers2 = pers2+persUp02(j,i);
        elseif binNum02(j,i) == 3
            c3 = c3+1;
            pers3 = pers3+persUp02(j,i);
        elseif binNum02(j,i) == 4
            c4 = c4+1;
            pers4 = pers4+persUp02(j,i);
        elseif binNum02(j,i) == 5
            c5 = c5+1;
            pers5 = pers5+persUp02(j,i);
        elseif binNum02(j,i) == 6
            c6 = c6+1;
            pers6 = pers6+persUp02(j,i);
        elseif binNum02(j,i) == 7
            c7 = c7+1;
            pers7 = pers7+persUp02(j,i);
        elseif binNum02(j,i) == 8
            c8 = c8+1;
            pers8 = pers8+persUp02(j,i);
        elseif binNum02(j,i) == 9
            c9 = c9+1;
            pers9 = pers9+persUp02(j,i);
        elseif binNum02(j,i) == 10
            c10 = c10+1;
            pers10 = pers10+persUp02(j,i);
        end
    end
end

pers1 = pers1/c1;
pers2 = pers2/c2;
pers3 = pers3/c3;
pers4 = pers4/c4;
pers5 = pers5/c5;
pers6 = pers6/c6;
pers7 = pers7/c7;
pers8 = pers8/c8;
pers9 = pers9/c9;
pers10 = pers10/c10;
resultsAdapt = [pers1 pers2 pers3 pers4 pers5 pers6 pers7 pers8 pers9 pers10];
x = [0 1 2 3 4 5 6 7 8 9];


hold on
scatter(x,resultsAdapt,'r')
            
            
            
            
            
            
            
            
            
            
