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
countDown = zeros(60,25);


for i = 2:60
    for j = 1:25
        if outAdapt.responses(i,j) > outAdapt.responses(i-1,j)
            countUp(i,j) = 1;
        elseif outAdapt.responses(i,j) < outAdapt.responses(i-1,j)
            countUp(i,j) = 0;
        end
    end
end

% scatter(outAdapt.responses(1:18,1),countUp(1:18,1))

NrespsAdapt = zeros(1,25);
%% calculate mean of last 4 responses for No Adapt condition
for i = 1:25
    for j = 1:60
        if outAdapt.responses(j,i) ~= 0
            NrespsAdapt(i) = NrespsAdapt(i)+1;
        end
    end
end

count02 = 0;
count09 = 0;
count16 = 0;
count23 = 0;
count3 = 0;
for j = 1:25
    for i = 1:NrespsAdapt(i)
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
end


% 
% percentUp = zeros(1,25);
% 
% for i = 1:25
%     percentUp(i) = (countUp(i)/NrespsAdapt(i))*100;
% end
% 
% respMeansAdapt = zeros(1,25);
% 
% for i = 1:25
%     if NrespsAdapt(i) ~= 0
%         prods = outAdapt.responses(NrespsAdapt(i)-3:NrespsAdapt(i),i);
%         sum1 = sum(prods);
%         respMeansAdapt(i) = sum1/4;
%     else
%         respMeansAdapt(i) = 0;
%     end
% end

