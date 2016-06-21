%% Clear the worksp  ace and the screen
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
escapeKey = KbName('ESCAPE');
%% set mean and sd for stim squares
% prompt = 'What is the mean frequency value? ';
% mean = input(prompt);
% prompt2 = 'What is the sd value? ';
% sd = input(prompt2);
mean = 10;
sd = 3;
mean2 = 10;

% screenNumber = max(screens);
screenNumber = 0;
black = BlackIndex(screenNumber);
% [window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);
  [window, windowRect] = PsychImaging('OpenWindow',screenNumber,black,[0 0 1000 500 ]);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

baseRect = [0 0 65 65]; %%stim squares size
rRect = [0 0 100 100]; %%response squares size
fixation = [0 0 20 20];  %%fixation size

[xCenter, yCenter] = RectCenter(windowRect); %%center points
xFSquares = xCenter/3.5 ;  %%location stim squares
yFSquares = yCenter/2;
xRSquare = xCenter*1.3;  %%location response squares
yRSquare = yCenter/2 ;

%% matrix of probabalistically distributed frequencies 
freqMat = normrnd(mean,sd,5,5); %%frequency of stim squares
respFreq = normrnd(mean2,sd,5,5);  %%response square freq

rectColor = [1 1 1];
pStart = GetSecs;
while GetSecs - pStart < 20
    %% draw squares at at lum det ermined by sin function and timing
    time = GetSecs-pStart;
    for i = 1:5
        for j = 1:5
            lumVal = sin(freqMat(i,j)*time);
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
        if keyCode(upKey)
            respFreq = respFreq.*1.05;
        elseif keyCode(downKey)
            respFreq = respFreq.*.95;
        end   
    end
    
    %% draw response square, fixation point 
    
    for i = 1:5
        for j = 1:5
            rlumVal = sin(respFreq(i,j)*time);
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

KbStrokeWait; 

sca; 
% hist(freqMat);