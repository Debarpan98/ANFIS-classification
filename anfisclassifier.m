clc
clear
close all
warning off all
load two.mat
epoch_n = 30;
dispOpt = zeros(1,4);
numMFs = 13;
inmftype= 'gbellmf';
outmftype= 'linear';
split_range=3;
Model=ANFIS.train(FMWR11c,round(two_out),split_range,numMFs,inmftype,outmftype,dispOpt,epoch_n);
disp('Model')
disp(Model)
Result=round(ANFIS.classify(Model,FMWR11c));
% Performance Calculation
Accuracy=mean(round(two_out)==Result);
disp('Accuracy')
disp(Accuracy)
n=1456;
disp('TestClass Predicted ')
disp(round([two_out(1:n),Result(1:n)]))