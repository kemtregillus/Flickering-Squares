%% Clear the workspace and the screen
sca;
close all;
clearvars;
PsychDefaultSetup(2);
screens = Screen('Screens');
%% added because of sync error
Screen('Preference', 'SkipSyncTests', 1);
%% set up keys
KbName('UnifyKeyNames');
upKey = KbName('UpArrow');
downKey = KbName('DownArrow');
enterKey = KbName('RETURN');
spaceKey = KbName('SPACE');
escapeKey = KbName('ESCAPE');
%% get subj
prompt = 'Subject initials: ';
subj = input(prompt);
%% window and screen set up
screenNumber = max(screens);
% screenNumber = 0 ;
black = BlackIndex(screenNumber);
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black+0.5);
% [window, windowRect] = PsychImaging('OpenWindow',screenNumber,black,[0 0 1000 500 ]);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
% [GM] need this: refresh interval
ifi = Screen('GetFlipInterval', window);
baseRect = [0 0 65 65]; %%stim squares size
rRect = [0 0 100 100];
fixation = [0 0 20 20];  %%fixation size
[xCenter, yCenter] = RectCenter(windowRect);%%center points
[xMax] = RectWidth(windowRect);
Screen('DrawText',window,'Press arrow keys to indicate which array of squares is flickering more quickly',xCenter/4,yCenter,[1 1 1])
Screen('DrawText',window,'Press Key to Continue',xCenter-150,yCenter+30,[1 1 1])
Screen('Flip', window);
% HideCursor();
KbStrokeWait;
%% basic set up
rectColor = [1 1 1];
pStart = GetSecs;
curTrial = 0;
%% parameters
nTrials = 25;
%% blank matrices for data storage and response tracking
keyResp = zeros(60,1);
respOut = zeros(60,nTrials);
meanFreqMat = zeros(1,nTrials);
centerFreqMat = zeros(1,nTrials);
sdFreqMat = zeros(1,nTrials);
AdaptField = zeros(1,nTrials);
frequency = zeros(500,2);
allAdaptFreq = zeros(1,5); %%stores all the frequency values, will likely never use but that way we have it
allRespFreq = zeros(1,1);
%% means were determined by latin square calculator and are pulled from 5 pre-made .txt files: mean1.txt, mean2.txt, etc...
meanPick = randi([1,5]);
meanName = strcat('mean',int2str(meanPick));
meanid = fopen(strcat(meanName,'.txt'));
% [GM] don't have this file, so hard coding mean:
mean = fscanf(meanid,'%f');
meanR = rand*3; %starting response mean (mean for test field) is chosen randomly
%% phase is randomized, this variable is not stored
phaseMat = abs(rand(5,5).*10);
%% do it
for k = 1:nTrials
    %% puts adapt field either on left or right
    positionPick = randi([1,2]);
    if positionPick == 1 %% adapt field on the left
        %%distance away from fixation with these setting is 125 pixels
        xFSquares = xCenter-500;  %%location stim squares - overall width of square matix is 375
        yFSquares = yCenter-225;
        xRSquares = xCenter+175;  %%location response squares
        yRSquares = yCenter;
        AdaptField(1,k) = 1;
    else %% adapt field on the right
        xRSquares = xCenter-175;  %%location stim squares - overall width of square matix is 375
        yRSquares = yCenter;
        xFSquares = xCenter+50;  %%location response squares
        yFSquares = yCenter-225;
        AdaptField(1,k) = 2;
    end
    rLumVal = 0;
    %% matrix of probabalistically distributed frequencies
    sd = mean(k,1)/3;
    freqMat = abs(normrnd(mean(k,1),sd,5,5)); %%frequency of stim squares
    centerFreq = freqMat(3,3);
    allAdaptFreq = cat(1,allAdaptFreq,freqMat);
    meanFreq = sum(freqMat(:))/25;
    meanFreqMat(1,k) = meanFreq;
    centerFreqMat(1,k) = centerFreq;
    sdFreqMat(1,k) = std(freqMat(:));
    
    SetMouse(rand*xMax,yCenter,window);
    [posX] = GetMouse(window);
    curTrial = curTrial+1;
    pStart = GetSecs;
    ptime = GetSecs;
    filler = 1;
    % [GM] set a few things:
    oldTime = 0;
    respFreq = posX/(xMax/6);
    oldFreq = respFreq;
    oldPos = rand*2*pi; %asin((rLumVal - 0.5)/5);
    while filler == 1
        [x,y,button] = GetMouse(window);
        if button(1)
            filler = 2;
            fixRect = CenterRectOnPointd(fixation,xCenter,yCenter);
            %     Screen('FillRect', window, reponseC olor, sideRect);
            Screen('FillOval',window, [.75 .75 .75],fixRect);
            Screen('Flip', window);
            WaitSecs(1);
        end
        time = GetSecs-pStart;
        for i = 1:5
            for j = 1:5
                lumVal = 0.5+(0.5*sin(freqMat(i,j)*time*(2*pi)+(phaseMat(i,j))));
                %             rectColor = [lumVal*rand lumVal*rand lumVal*rand];
                rectColor = [lumVal lumVal lumVal];
                xPos = xFSquares+i*75;
                yPos = yFSquares+j*75;
                centeredRect = CenterRectOnPointd(baseRect, xPos, yPos);
                Screen('FillRect', window, rectColor, centeredRect);
            end
        end
%         [GM] You can probably get rid of this if you use ouse clicks for
%         responses:
        KbCheck;
        [keyIsDown, seconds, keyCode ]  = KbCheck;
        if keyIsDown
            if keyCode(escapeKey)
                close all;
                sca;
            end
        end
        if GetSecs - ptime >= .25
        [posX] = GetMouse(window);
            ptime = GetSecs;
        end
        if posX/(xMax/6) ~= respFreq %change in freq
            oldTime = time - ifi;
            oldFreq = respFreq;
            respFreq = posX/(xMax/6);
            oldPos = asin((rLumVal - 0.5)/5);
        end
        rLumVal = 0.5 + 0.5 * sin(oldPos + respFreq * (time - oldTime) *2*pi);
%         else
%             rLumVal = 0.5*sin(respFreq*time*(2*pi)+(rLumValnew))+0.5;

        reponseColor = [rLumVal rLumVal rLumVal];
        sideRect = CenterRectOnPointd(rRect, xRSquares,yRSquares);
        Screen('FillRect', window, reponseColor, sideRect);
        %% draw fixation
        fixRect = CenterRectOnPointd(fixation,xCenter,yCenter);
        Screen('FillOval',window, [.75 .75 .75],fixRect);
        %% screen flip
        Screen('Flip', window);
    end
    allRespFreq = cat(1,allRespFreq,respFreq);
    meanRespFreq = sum(respFreq(:));
    respOut(curTrial,k) = meanRespFreq;
    %% save stuff
    means = cat(1,mean.',meanFreqMat,centerFreqMat);
    allAdaptFreq = cat(1,allAdaptFreq,zeros(1,5));
    outAdapt = struct('means',means,'responses',allRespFreq,'standevs',sdFreqMat,'rORlAdaptField',AdaptField,'allAdaptFreq',allAdaptFreq);
    saveFile = strcat(subj,'_ensemble_',date,'.mat');
    save(saveFile,'outAdapt');
end
%% do it
% meanPick = randi([1,5]);
% meanName = strcat('mean',int2str(meanPick));
% meanid = fopen(strcat(meanName,'.txt'));
% for k = 1:nTrials
%     %% puts adapt field either on left or right
%     positionPick = randi([1,2]);
%     if positionPick == 1 %% adapt field on the left
%         %%distance away from fixation with these setting is 125 pixels
%         xFSquares = xCenter-175;  %%location stim squares - overall width of square matix is 375
%         yFSquares = yCenter;
%         xRSquares = xCenter+175;  %%location response squares
%         yRSquares = yCenter;
%         AdaptField(1,k) = 1;
%     else %% adapt field on the right
%         xRSquares = xCenter-175;  %%location stim squares - overall width of square matix is 375
%         yRSquares = yCenter;
%         xFSquares = xCenter+175;  %%location response squares
%         yFSquares = yCenter;
%         AdaptField(1,k) = 2;
%     end
%     rLumVal = 0;
%     %% matrix of probabalistically distributed frequencies
%     sd = mean(k,1)/3;
%     freqMat = abs(normrnd(mean(k,1),sd,5,5)); %%frequency of stim squares
%     allAdaptFreq = cat(1,allAdaptFreq,freqMat);
%     meanFreq = sum(freqMat(:))/25;
%     meanFreqMat(1,k) = meanFreq;
%     sdFreqMat(1,k) = std(freqMat(:));
%     
%     SetMouse(rand*xMax,yCenter,window);
%     [posX] = GetMouse(window);
%     curTrial = curTrial+1;
%     pStart = GetSecs;
%     ptime = GetSecs;
%     filler = 1;
%     % [GM] set a few things:
%     oldTime = 0;
%     respFreq = posX/(xMax/6);
%     oldFreq = respFreq;
%     oldPos = rand*2*pi; %asin((rLumVal - 0.5)/5);
%     phase = rand*5;
%     while filler == 1
%         [x,y,button] = GetMouse(window);
%         if button(1)
%             filler = 2;
%             fixRect = CenterRectOnPointd(fixation,xCenter,yCenter);
%             %     Screen('FillRect', window, reponseC olor, sideRect);
%             Screen('FillOval',window, [.75 .75 .75],fixRect);
%             Screen('Flip', window);
%             WaitSecs(1);
%         end
%         time = GetSecs-pStart;
% %         for i = 1:5
% %             for j = 1:5
%                 lumVal = 0.5+(0.5*sin(mean(k)*time*(2*pi)+(phase)));
%                 %             rectColor = [lumVal*rand lumVal*rand lumVal*rand];
%                 rectColor = [lumVal lumVal lumVal];
%              
%                 centeredRect = CenterRectOnPointd(rRect, xFSquares, yFSquares);
%                 Screen('FillRect', window, rectColor, centeredRect);
% %             end
% %         end
% %         [GM] You can probably get rid of this if you use ouse clicks for
% %         responses:
%         KbCheck;
%         [keyIsDown, seconds, keyCode ]  = KbCheck;
%         if keyIsDown
%             if keyCode(escapeKey)
%                 close all;
%                 sca;
%             end
%         end
% %         if GetSecs - ptime >= .25
%         [posX] = GetMouse(window);
% %             ptime = GetSecs;
% %         end
%         if posX/(xMax/6) ~= respFreq %change in freq
%             oldTime = time - ifi;
%             oldFreq = respFreq;
%             respFreq = posX/(xMax/6);
%             oldPos = asin((rLumVal - 0.5)/5);
%         end
%         rLumVal = 0.5 + 0.5 * sin(oldPos + respFreq * (time - oldTime) *2*pi);
% %         else
% %             rLumVal = 0.5*sin(respFreq*time*(2*pi)+(rLumValnew))+0.5;
% 
%         reponseColor = [rLumVal rLumVal rLumVal];
%         sideRect = CenterRectOnPointd(rRect, xRSquares,yRSquares);
%         Screen('FillRect', window, reponseColor, sideRect);
%         %% draw fixation
%         fixRect = CenterRectOnPointd(fixation,xCenter,yCenter);
%         Screen('FillOval',window, [.75 .75 .75],fixRect);
%         %% screen flip
%         Screen('Flip', window);
%         
%     end
%     allRespFreq = cat(1,allRespFreq,respFreq);
%     meanRespFreq = sum(respFreq(:));
%     respOut(curTrial,k) = meanRespFreq;
%     %% save stuff
%     means = cat(1,mean.',meanFreqMat);
%     allAdaptFreq = cat(1,allAdaptFreq,zeros(1,5));
%     outAdapt = struct('means',means,'responses',allRespFreq,'standevs',sdFreqMat,'rORlAdaptField',AdaptField,'allAdaptFreq',allAdaptFreq);
%     saveFile = strcat(subj,'_singlesquare_',date,'.mat');
%     save(saveFile,'outAdapt');
% end

Screen('DrawText',window,'You are done. Thank you for participating. Press Key to Continue',xCenter/4,yCenter,[1 1 1])
Screen('Flip', window);
KbStrokeWait;
sca;

sca

