%%%%%%%%Code written by Katie Tregillus Spring & summer 2016
%%%%%%%%This code is designed to test adaptation to a mean flicker rate
%%%%%%%%Contact Katie with questions: kmussell@gmail.com
 
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
rightKey = KbName('RightArrow');
leftKey = KbName('LeftArrow');
enterKey = KbName('RETURN');
escapeKey = KbName('ESCAPE');
%% set mean and sd for stim squares
% prompt = 'What is the mean frequency value? ';
% mean = input(prompt);
% prompt   2 = 'What is the sd value? ';
% sd = i nput(prompt2);

screenNumber = max(screens);
% screenNumber = 0 ;
black = BlackIndex(screenNumber);
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black+0.5);
% [window, windowRect] = PsychImaging('OpenWindow',screenNumber,black,[0 0 1000 500 ]);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

baseRect = [0 0 65 65]; %%stim squares size
%rRect = [0 0 100 100]; %%response squares size
fixation = [0 0 20 20];  %%fixation size
[xCenter, yCenter] = RectCenter(windowRect);%%center points
%%%distance away from fixation with these setting is 125 pixels
xFSquares = xCenter-500;  %%location stim squares - overall width of square matix is 375
yFSquares = yCenter-225;
xRSquare = xCenter+50;  %%location response squares
yRSquare = yCenter-225;
rectColor = [1 1 1];
pStart = GetSecs;
experiment = 3;
nTrials = 1;
adapTime = 10;
topUp = 5; 
testTime = 2;
curTrial = 0;
upScale = 1.2;
downScale = 0.8;

keyResp = zeros(50,1);
stairCount = 0;
%%do it
mean = 5;
sd = 3;
mean2 = rand*20;

phaseMat = abs(rand(5,5).*10);
reversals = 6;

for k = 1:nTrials
    %% matrix of probabalistically distributed frequencies
    freqMat = abs(normrnd(mean,sd,5,5)); %%frequency of stim squares
    respFreq = abs(normrnd(mean2,sd,5,5));  %%response square freq
    respFreqnew = respFreq;
    while stairCount <= reversals
        
        switch  experiment
            
            case 1 %%%Adaptation Top-Up
                pStart = GetSecs;
                while GetSecs - pStart < topUp
                    %% draw squares at lum determined by sin function and timing
                    time = GetSecs-pStart;
                    for i = 1:5
                        for j = 1:5
                            lumVal = 0.5+(0.5*sin(freqMat(i,j)*time+(phaseMat(i,j))));
                            %             rectColor = [lumVal*rand lumVal*rand lumVal*rand];
                            rectColor = [lumVal lumVal lumVal];
                            xPos = xFSquares+i*75;
                            yPos = yFSquares+j*75;
                            centeredRect = CenterRectOnPointd(baseRect, xPos, yPos);
                            Screen('FillRect', window, rectColor, centeredRect);
                        end
                    end
                    
                    KbCheck;
                    [keyIsDown, seconds, keyCode ]  = KbCheck;
                    if keyIsDown
                        if keyCode(leftKey)
                            respFreqnew = respFreq.*upScale;
                            keyResp(curTrial,1) = 'U';
                            
                        elseif keyCode(rightKey)
                            respFreqnew = respFreq.*downScale;
                            keyResp(curTrial,1) = 'D';
                            
                        end
                    end
                    
                    
                    
                    fixRect = CenterRectOnPointd(fixation,xCenter,yCenter);
                    %     Screen('FillRect', window, reponseColor, sideRect);
                    Screen('FillOval',window, [.75 .75 .75],fixRect);
                    Screen('Flip', window);
                end
                respFreq = respFreqnew;
                if curTrial > 1 && keyResp(curTrial,1) == 'U' && keyResp(curTrial-1,1) == 'D'
                    stairCount = stairCount+1
                elseif curTrial > 1 && keyResp(curTrial,1) == 'D' && keyResp(curTrial-1,1) == 'U'
                    stairCount = stairCount+1
                end
                experiment = 2;
                
            case 2 %%%Response field
                curTrial = curTrial+1
                pStart = GetSecs;
                while GetSecs - pStart < testTime;
                    %% draw squares at at lum determined by sin function and timing
                    time = GetSecs-pStart;
                    for i = 1:5
                        for j = 1:5
                            lumVal = 0.5+(0.5*sin(freqMat(i,j)*time+(phaseMat(i,j))));
                            %             rectColor = [lumVal*rand lumVal*rand lumVal*rand];
                            rectColor = [lumVal lumVal lumVal];
                            xPos = xFSquares+i*75;
                            yPos = yFSquares+j*75;
                            centeredRect = CenterRectOnPointd(baseRect, xPos, yPos);
                            Screen('FillRect', window, rectColor, centeredRect);
                        end
                    end
                    %% get key responses from response square
                    KbCheck;
                    [keyIsDown, seconds, keyCode ]  = KbCheck;
                    if keyIsDown
                        if keyCode(leftKey)
                            respFreqnew = respFreq.*upScale;
                            keyResp(curTrial,1) = 'U';
                            
                        elseif keyCode(rightKey)
                            respFreqnew = respFreq.*downScale;
                            keyResp(curTrial,1) = 'D';
                            
                        end
                    end
                    
                    
                    %% draw response square, fixation point
                    for i = 1:5
                        for j = 1:5
                            rlumVal = 0.5+(0.5*sin(respFreq(i,j)*time+(phaseMat(i,j))));
                            %             rectColor = [lumVal*rand lumVal*rand lumVal*rand];
                            responseColor = [rlumVal rlumVal rlumVal];
                            xPos2 = xRSquare+i*75;
                            yPos2 = yRSquare+j*75;
                            sideRect = CenterRectOnPointd(baseRect, xPos2, yPos2);
                            Screen('FillRect', window, responseColor, sideRect);
                        end
                    end
                    
                    %     rLumVal = sin(respFreq*(GetSecs-pStart));
                    %     reponseColor = [rLumVal rLumVal rLumVal];
                    %     sideRect = CenterRectOnPointd(rRect, xRSquare,yRSquare);
                    fixRect = CenterRectOnPointd(fixation,xCenter,yCenter);
                    %     Screen('FillRect', window, reponseColor, sideRect);
                    Screen('FillOval',window, [.75 .75 .75],fixRect);
                    Screen('Flip', window);
                end
                respFreq = respFreqnew
                %%increase staircase counter
                if curTrial > 1 && keyResp(curTrial,1) == 'U' && keyResp(curTrial-1,1) == 'D'
                    stairCount = stairCount+1
                elseif curTrial > 1 && keyResp(curTrial,1) == 'D' && keyResp(curTrial-1,1) == 'U'
                    stairCount = stairCount+1
                end
                experiment = 1;
                
                
            case 3 %%%Pre-Adaptation
                pStart = GetSecs;
                while GetSecs - pStart < adapTime
                    %% draw squares at at lumdetermined by sin function and timing
                    time = GetSecs-pStart;
                    for i = 1:5
                        for j = 1:5
                            %%sin wave vals = 0.5 is start y val, meaning it
                            %%shouldn't dip below 0, 0.5 is also amplitude,
                            %%phastMat makes each square start at random phase
                            lumVal = 0.5+(0.5*sin(freqMat(i,j)*time+(phaseMat(i,j))));
                            % rectColor = [lumVal*rand lumVal*rand lumVal*rand];
                            rectColor = [lumVal lumVal lumVal];
                            xPos = xFSquares+i*75;
                            yPos = yFSquares+j*75;
                            centeredRect = CenterRectOnPointd(baseRect, xPos, yPos);
                            Screen('FillRect', window, rectColor, centeredRect);
                        end
                    end
                    fixRect = CenterRectOnPointd(fixation,xCenter,yCenter);
                    %     Screen('FillRect', window, reponseC olor, sideRect);
                    Screen('FillOval',window, [.75 .75 .75],fixRect);
                    Screen('Flip', window);
                end
                experiment = 2;
        end
    end
    experiment = 3;
    stairCount = 0;
    mean = 10;
    mean2 = rand*20;
    Screen('FillOval',window, [.75 .75 .75],fixRect);
    Screen('Flip', window);
    KbStrokeWait;
end

KbStrokeWait;

sca;
% hist(freqMat);