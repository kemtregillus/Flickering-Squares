function [resultsAdapt,edges, N, resultsNoAdapt] = binAndFit(input,adapt,figNum)

if adapt == 1
    nbins = 5;
    Nresps = zeros(1,5);
    countUp = zeros(60,5);
    allnonezero = zeros(0);
    allpers = zeros(0);
    for i = 1:5
        for j = 1:60
            if input(j,i) ~= 0
                Nresps(i) = Nresps(i)+1;
            end
            
        end
    end
    
    for i = 2:60
        for j = 1:5
            if input(i,j) > input(i-1,j)
                countUp(i-1,j) = 0;
            elseif input(i,j) < input(i-1,j)
                countUp(i-1,j) = 1;
            end
        end
    end
    
    for j = 1:5
        allnonezero = cat(1,allnonezero,input(1:Nresps(j),j));
        allpers = cat(1,allpers,countUp(1:Nresps(j),j));
    end
    [N,edges,bin] = histcounts(allnonezero,nbins);
    
    pers1 = 0;
    pers2 = 0;
    pers3 = 0;
    pers4 = 0;
    pers5 = 0;
    
    c1 = 0;
    c2 = 0;
    c3 = 0;
    c4 = 0;
    c5 = 0;
    for i = 1:size(allnonezero)
        if bin(i) == 1
            c1 = c1+1;
            pers1 = pers1+allpers(i);
        elseif bin(i) == 2
            c2 = c2+1;
            pers2 = pers2+allpers(i);
        elseif bin(i) == 3
            c3 = c3+1;
            pers3 = pers3+allpers(i);
        elseif bin(i) == 4
            c4 = c4+1;
            pers4 = pers4+allpers(i);
        elseif bin(i) == 5
            c5 = c5+1;
            pers5 = pers5+allpers(i);
        end
    end
    
    pers1 = pers1/c1;
    pers2 = pers2/c2;
    pers3 = pers3/c3;
    pers4 = pers4/c4;
    pers5 = pers5/c5;
    resultsAdapt = [pers1 pers2 pers3 pers4 pers5];
    figure(figNum)
    scatter(edges(2:6),resultsAdapt,N.*10,'b')
    [pse params x PF] = PAL_pfit(edges(2:6),resultsAdapt.*N,N)
    x_plot=[min(x):max(x)./1000:max(x)];
    y_plot = PF(params,x_plot);
    hold on
    plot(x_plot,y_plot,'b-');
    axis([0 edges(6) 0 1]);
    hold on
end
%%%%%%%%%%no adapt
if adapt == 0
    nbins = 5;
    Nresps = zeros(1,5);
    countUp = zeros(60,5);
    allnonezero = zeros(0);
    allpers = zeros(0);
    for i = 1:5
        for j = 1:60
            if input(j,i) ~= 0
                Nresps(i) = Nresps(i)+1;
            end
            
        end
    end
    
    for i = 2:60
        for j = 1:5
            if input(i,j) > input(i-1,j)
                countUp(i-1,j) = 0;
            elseif input(i,j) < input(i-1,j)
                countUp(i-1,j) = 1;
            end
        end
    end
    
    for j = 1:5
        allnonezero = cat(1,allnonezero,input(1:Nresps(j),j));
        allpers = cat(1,allpers,countUp(1:Nresps(j),j));
    end
    [N,edges,bin] = histcounts(allnonezero,nbins);
    
    pers1 = 0;
    pers2 = 0;
    pers3 = 0;
    pers4 = 0;
    pers5 = 0;
    
    c1 = 0;
    c2 = 0;
    c3 = 0;
    c4 = 0;
    c5 = 0;
    for i = 1:size(allnonezero)
        if bin(i) == 1
            c1 = c1+1;
            pers1 = pers1+allpers(i);
        elseif bin(i) == 2
            c2 = c2+1;
            pers2 = pers2+allpers(i);
        elseif bin(i) == 3
            c3 = c3+1;
            pers3 = pers3+allpers(i);
        elseif bin(i) == 4
            c4 = c4+1;
            pers4 = pers4+allpers(i);
        elseif bin(i) == 5
            c5 = c5+1;
            pers5 = pers5+allpers(i);
        end
    end
    
    pers1 = pers1/c1;
    pers2 = pers2/c2;
    pers3 = pers3/c3;
    pers4 = pers4/c4;
    pers5 = pers5/c5;
    resultsNoAdapt = [pers1 pers2 pers3 pers4 pers5];
    figure(figNum)
    scatter(edges(2:6),resultsNoAdapt,N.*10,'r')
    [pse params x PF] = PAL_pfit(edges(2:6),resultsNoAdapt.*N,N)
    x_plot=[min(x):max(x)./1000:max(x)];
    y_plot = PF(params,x_plot);
    hold on
    plot(x_plot,y_plot,'r-');
    axis([0 edges(6) 0 1]);
end
