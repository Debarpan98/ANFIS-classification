%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPFZ101
% Project Title: Nonlinear Regression using ANFIS
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

clc;
clear;
close all;

%% Create Time-Series Data

data = load('TrainTest1456_1.mat');

TrainInputs = data.Train_set1456_1(:,1:20);
TrainTargets = data.Train_set1456_1(:,21);

TestInputs = data.Test_set1456_1(:,1:20);
TestTargets = data.Test_set1456_1(:,21);

%nData = size(Inputs,1);
%PERM = randperm(nData);
%index = PERM(1:nData);
%Inputs=Inputs(index,:);
%Targets=Targets(index,:);

%Targets = Targets(:,2); % Select 1st Output to Model

%% Shuffling Data

%PERM = randperm(nData); % Permutation to Shuffle Data


%pTrain=0.85;
%nTrainData=round(pTrain*nData);
%TrainInd=PERM(1:nTrainData);
%TrainInputs=Train_Inputs(:,1:20);
%TrainTargets=Train_Inputs(:,21);

%pTest=1-pTrain;
%nTestData=nData-nTrainData;
%TestInd=PERM(nTrainData+1:end);
%TestInputs=TestInputs(:,1:20);
%TestTargets=TestInputs(:,21);

%% Selection of FIS Generation Method

%Option{1}='Grid Partitioning (genfis1)';
%Option{2}='Subtractive Clustering (genfis2)';
%Option{3}='FCM (genfis3)';

%ANSWER=questdlg('Select FIS Generation Approach:',...
 %               'Select GENFIS',...
  %              Option{1},Option{2},Option{3},...
   %             Option{3});
%pause(0.01);

%% Setting the Parameters of FIS Generation Methods

%switch ANSWER
 %   case Option{1}
  %      Prompt={'Number of MFs','Input MF Type:','Output MF Type:'};
   %    Title='Enter genfis1 parameters';
   %     DefaultValues={'5', 'gaussmf', 'linear'};
        
    %    PARAMS=inputdlg(Prompt,Title,1,DefaultValues);
     %   pause(0.01);

      %  nMFs=str2num(PARAMS{1});	%#ok
       % InputMF=PARAMS{2};
        %OutputMF=PARAMS{3};
        
   %     fis=genfis1([TrainInputs TrainTargets],nMFs,InputMF,OutputMF);

    %case Option{2}
     %   Prompt={'Influence Radius:'};
      %  Title='Enter genfis2 parameters';
       % DefaultValues={'0.3'};
        
      %  PARAMS=inputdlg(Prompt,Title,1,DefaultValues);
       % pause(0.01);

      %  Radius=str2num(PARAMS{1});	%#ok
        
      %  fis=genfis2(TrainInputs,TrainTargets,Radius);
        
   % case Option{3}
        Prompt={'Number of Clusters:',...
                'Partition Matrix Exponent:',...
                'Maximum Number of Iterations:',...
                'Minimum Improvemnet:'};
        Title='Enter genfis3 parameters';
        DefaultValues={'15', '2', '200', '1e-5'};
        
        PARAMS=inputdlg(Prompt,Title,1,DefaultValues);
        pause(0.01);

        nCluster=str2num(PARAMS{1});        %#ok
        Exponent=str2num(PARAMS{2});        %#ok
        MaxIt=str2num(PARAMS{3});           %#ok
        MinImprovment=str2num(PARAMS{4});	%#ok
        DisplayInfo=1;
        FCMOptions=[Exponent MaxIt MinImprovment DisplayInfo];
        
        fis=genfis3(TrainInputs,TrainTargets,'sugeno',nCluster,FCMOptions);
%end

%% Training ANFIS Structure

%prev_accuracy=0;
%for x=1 : 5 
    Prompt={'Maximum Number of Epochs:',...
            'Error Goal:',...
            'Initial Step Size:',...
           'Step Size Decrease Rate:',...
         'Step Size Increase Rate:'};
    Title='Enter genfis3 parameters';
    DefaultValues={'200', '0', '0.01', '0.9', '1.1'};

    PARAMS=inputdlg(Prompt,Title,1,DefaultValues);
    pause(0.01);

    MaxEpoch=str2num(PARAMS{1});                %#ok
    ErrorGoal=str2num(PARAMS{2});               %#ok
    InitialStepSize=str2num(PARAMS{3});         %#ok
    StepSizeDecreaseRate=str2num(PARAMS{4});    %#ok
    StepSizeIncreaseRate=str2num(PARAMS{5});    %#ok
    TrainOptions=[MaxEpoch ...
                  ErrorGoal ...
                  InitialStepSize ...
                  StepSizeDecreaseRate ...
                  StepSizeIncreaseRate];

    DisplayInfo=true;
    DisplayError=true;
    DisplayStepSize=true;
    DisplayFinalResult=true;
    DisplayOptions=[DisplayInfo ...
                    DisplayError ...
                    DisplayStepSize ...
                    DisplayFinalResult];
    
    OptimizationMethod=1;
% 0: Backpropagation
% 1: Hybrid
            
    [fis,trainError,stepSize,chkFIS,chkError]=anfis([TrainInputs TrainTargets],fis,TrainOptions,DisplayOptions,[],OptimizationMethod);
    
%% Apply ANFIS to Data

    TrainOutputs=evalfis(TrainInputs,fis);
    TestOutputs=evalfis(TestInputs,fis);

%% Accurate Calculation

    compareTrain = [TrainOutputs, TrainTargets];
    compareTrain(:,1) = round(compareTrain(:,1));
    match = 0;
    for i = 1:length(compareTrain)
         if compareTrain(i,1) == compareTrain(i,2)
         match = match+1;
         end
    end

    accuracy =( match / length(compareTrain) ) * 100;
    fprintf('Training Accuracy: %f\n', accuracy);
 %   if(accuracy>prev_accuracy)
 %       fis1=fis;
 %   end
%disp('Training Class Predicted ')
%disp(round([TrainOutputs(:),TrainTargets(:)]))

    compareTest = [TestOutputs, TestTargets];
    compareTest(:,1) = round(compareTest(:,1));
    match = 0;
    for i = 1:length(compareTest)
        if compareTest(i,1) == compareTest(i,2)
            match = match+1;
        end
    end

    accuracy =( match / length(compareTest) ) * 100;
    fprintf('Testing Accuracy: %f\n', accuracy);
    
%disp('Test Class Predicted ')
%disp(round([TestOutputs(:),TestTargets(:)]))

%% Error Calculation


%TrainErrors=TrainTargets-TrainOutputs;

%TrainMSE=mean(TrainErrors.^2);
%TrainRMSE=sqrt(TrainMSE);
%TrainErrorMean=mean(TrainErrors);
%TrainErrorSTD=std(TrainErrors);

%TestErrors=TestTargets-TestOutputs;
%TestMSE=mean(TestErrors.^2);
%TestRMSE=sqrt(TestMSE);
%TestErrorMean=mean(TestErrors);
%TestErrorSTD=std(TestErrors);

%end
%m = matfile('TrainTest1456_1.mat','Writable',true);
%m.fis1=fis1;
%% Plot Results

figure;
PlotResults(TrainTargets,TrainOutputs,'Train Data');

figure;
PlotResults(TestTargets,TestOutputs,'Test Data');

figure;
PlotResults(TrainTargets,Outputs,'All Data');

if ~isempty(which('plotregression'))
    figure;
    plotregression(TrainTargets, TrainOutputs, 'Train Data', ...
                   TestTargets, TestOutputs, 'Test Data');
    set(gcf,'Toolbar','figure');
end

figure;
gensurf(fis, [1 2], 1, [30 30]);
xlim([min(Inputs(:,1)) max(Inputs(:,1))]);
ylim([min(Inputs(:,2)) max(Inputs(:,2))]);
