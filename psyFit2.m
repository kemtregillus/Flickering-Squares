clear all
close all
% 
% load 'SC_No_Adapt_01-Jul-2016.mat'
% load 'SC_Adapt_01-Jul-2016.mat'

% load 'KT_No_Adapt_01-Jul-2016.mat'
% load 'KT_Adapt_01-Jul-2016.mat'
% 
% load 'AA_No_Adapt_04-Jul-2016.mat'
% load 'AA_Adapt_05-Jul-2016.mat'

load 'wk_No_Adapt_04-Jul-2016.mat'
load 'wk_Adapt_05-Jul-2016.mat'

% load 'ST_No_Adapt_11-Jul-2016.mat'


all02 = zeros(60,5);
all09 = zeros(60,5);
all16 = zeros(60,5);
all23 = zeros(60,5);
all3 = zeros(60,5);
count02 = 0;
count09 = 0;
count16 = 0;
count23 = 0;
count3 = 0;

for i = 1:25
    if outAdapt.means(1,i) == [0.200000000000000]
        count02 = count02+1;
        all02(:,count02) = outAdapt.responses(:,i);
    end
    if outAdapt.means(1,i) == [0.900000000000000]
        count09 = count09+1;
        all09(:,count09) = outAdapt.responses(:,i);
    end
    if outAdapt.means(1,i) == [1.60000000000000]
        count16 = count16+1;
        all16(:,count16) = outAdapt.responses(:,i);
    end
    if outAdapt.means(1,i) == [2.30000000000000]
        count23 = count23+1;
        all23(:,count23) = outAdapt.responses(:,i);
    end
    if outAdapt.means(1,i) == [3]
        count3 = count3+1;
        all3(:,count3) = outAdapt.responses(:,i);
    end
end

inName = [all02 all09 all16 all23 all3];
count = 1;
for i = 1:5
    input = inName(:,count:count+4);
    count = count+5;
    figNum = i;
    adapt = 1;
    [resultsAdapt, edges, N] = binAndFit(input,adapt,figNum);
    title('AdaptLevel')
end

%%%%%%%%%%%% no adapt
all02 = zeros(60,5);
all09 = zeros(60,5);
all16 = zeros(60,5);
all23 = zeros(60,5);
all3 = zeros(60,5);
count02 = 0;
count09 = 0;
count16 = 0;
count23 = 0;
count3 = 0;

for i = 1:25
    if outNoAdapt.means(1,i) == [0.200000000000000]
        count02 = count02+1;
        all02(:,count02) = outNoAdapt.responses(:,i);
    end
    if outNoAdapt.means(1,i) == [0.900000000000000]
        count09 = count09+1;
        all09(:,count09) = outNoAdapt.responses(:,i);
    end
    if outNoAdapt.means(1,i) == [1.60000000000000]
        count16 = count16+1;
        all16(:,count16) = outNoAdapt.responses(:,i);
    end
    if outNoAdapt.means(1,i) == [2.30000000000000]
        count23 = count23+1;
        all23(:,count23) = outNoAdapt.responses(:,i);
    end
    if outNoAdapt.means(1,i) == [3]
        count3 = count3+1;
        all3(:,count3) = outNoAdapt.responses(:,i);
    end
end

inName = [all02 all09 all16 all23 all3];
count = 1;
for i = 1:5
    input = inName(:,count:count+4);
    count = count+5;
    figNum = i;
    adapt = 0;
    binAndFit(input,adapt,figNum);
end