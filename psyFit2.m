clear all
close all

% load 'KT_No_Adapt_01-Jul-2016.mat'
% load 'KT_Adapt_01-Jul-2016.mat'
% 
% load 'SC_No_Adapt_01-Jul-2016.mat'
% load 'SC_Adapt_01-Jul-2016.mat'
% 
% load 'wk_No_Adapt_04-Jul-2016.mat'
% load 'wk_Adapt_05-Jul-2016.mat'
% 
% load 'AA_No_Adapt_12-Jul-2016.mat'
% load 'AA_Adapt_05-Jul-2016.mat'

% load 'ST_No_Adapt_11-Jul-2016.mat'
% load 'ST_Adapt_11-Jul-2016.mat'

load 'HG_No_Adapt_11-Jul-2016.mat'
load 'HG_Adapt_12-Jul-2016.mat'

pseListAdapt = [];
sdListAdapt = [];
pseListNoAdapt = [];
sdListNoAdapt = [];

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
    [edges, N,pse,params,x, PF] = binAndFit(input,adapt,figNum);
    pseListAdapt = cat(1,pseListAdapt,pse);
    sdListAdapt = cat(1,sdListAdapt,params(1,2));
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
    [edges, N,pse,params,x, PF] = binAndFit(input,adapt,figNum);
    pseListNoAdapt = cat(1,pseListNoAdapt,pse);
    sdListNoAdapt = cat(1,sdListNoAdapt,params(1,2));
end

figure(6)
bar([0.2 0.9 1.6 2.3 3],[pseListAdapt(1) pseListNoAdapt(1);pseListAdapt(2) pseListNoAdapt(2);pseListAdapt(3) pseListNoAdapt(3);pseListAdapt(4) pseListNoAdapt(4);pseListAdapt(5) pseListNoAdapt(5)])
figure(7)
bar([0.2 0.9 1.6 2.3 3],[sdListAdapt(1) sdListNoAdapt(1);sdListAdapt(2) sdListNoAdapt(2);sdListAdapt(3) sdListNoAdapt(3);sdListAdapt(4) sdListNoAdapt(4);sdListAdapt(5) sdListNoAdapt(5)])
% figure(1)
% title('Adapt Level = 0.2','fontsize',16)
% figure(2)
% title('Adapt Level = 0.9','fontsize',16)
% figure(3)
% title('Adapt Level = 1.6','fontsize',16)
% figure(4)
% title('Adapt Level = 2.3','fontsize',16)
% figure(5)
% title('Adapt Level = 3','fontsize',16)
