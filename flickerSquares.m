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
downKey =  KbName('DownArrow');
enterKey = KbName('RETURN');
escapeKey = KbName('ESCAPE');
%% set mean and sd for stim squares
% prompt = 'What is the mean frequency value? ';
% mean = input(prompt);
% prompt2 = 'What is the sd value? ';
% sd = input(prompt2);
mean = 20;
sd = 3;

% screenNumber = max(screens);
screenNumber = 0;
black = BlackIndex(screenNumber);
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);
%   [window, windowRect] = PsychImaging('OpenWindow',screenNumber,black,[0 0 1000 500 ]);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

baseRect = [0 0 65 65]; %%stim squares size
rRect = [0 0 100 100]; %%response squares size
fixation = [0 0 20 20];  %%fixation size

[xCenter, yCenter] = RectCenter(windowRect); %%center points
xFSquares = xCenter/3.5 ;  %%location stim squares
yFSquares = yCenter/2;
xRSquare = xCenter*1.3;  %%location response squares
yRSquare = yCenter ;

%% matrix of probabalistically distributed frequencies 
freqMat = normrnd(mean,sd,5,5); %%frequency of stim squares
respFreq = normrnd(mean,sd);  %%response square freq

rectColor = [1 1 1];
pStart = GetSecs;
while GetSecs - pStart < 20
    %% draw squares at at lum determined by sin function and timing
    for i = 1:5
        for j = 1:5
            lumVal = sin(freqMat(i,j)*(GetSecs-pStart));
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
    [ keyIsDown, seconds, keyCode ] = KbCheck;
    if respFreq <=0 
        respFreq = 1;
    end
    if keyIsDown
        if keyCode(upKey)
            respFreq = respFreq + 1;
        elseif keyCode(downKey)
            respFreq = respFreq - 1;
        end  
    end
    %% draw response square, fixation point 
    rLumVal = sin(respFreq*(GetSecs-pStart));
    reponseColor = [rLumVal rLumVal rLumVal];
    sideRect = CenterRectOnPointd(rRect, xRSquare,yRSquare);
    fixRect = CenterRectOnPointd(fixation,xCenter,yCenter);
    Screen('FillRect', window, reponseColor, sideRect);
    Screen('FillOval',window, [.75 .75 .75],fixRect);
    Screen('Flip', window);
end

KbStrokeWait; 

sca;
hist(freqMat)
