% It don't work matlab 2010 so execute it in new version.
clear; close all; clc;

%%%%%%%%%%%%%%%%%% Read data %%%%%%%%%%%%%%%%%%%%%
% training_data = xlsread('Training_Data.xlsx');
% testing_data = xlsread('Testing_Data.xlsx');
  data=xlsread('result.xlsx');

%%%%%%%%%%%%%%%%% Extracting size of training and testing data %%%%%%%%%
% [tr_row, tr_col] = size(training_data);
% [tst_row, tst_col] = size(testing_data);
[tr_row, tr_col] = size(data);

% %%%%%%%%%%%%%%%% Separate features and class label %%%%%%%%%%%%%%%
% training_features = training_data(:,1:tr_col-1);
% training_label = training_data(:,tr_col);
% testing_features = testing_data(:,1:tst_col-1);
% testing_label = testing_data(:,tst_col);
training_features = data(:,1:tr_col-1);
label= data(:,tr_col);

%%%%%%%%%%%%%%% Cross validate the classifier %%%%%%%%%%%%%%%%
indices = crossvalind('Kfold',label,10);

%%%%%%%%%%%%%%%%%%% Evaluate performance of classifier %%%%%%%%%%%%%%%%%
cp = classperf(label);

%%%%%%%%%%%%%%%%%% Perform SVM Classification %%%%%%%%%%%%
for i = 1:10
    test = (indices == i); train = ~test;
    model = svmtrain(training_features(train,:),label(train,:));
    y = svmclassify(model,training_features(test,:));
    [C,order] = confusionmat(label(test,:),y);
    TP=C(1,1);
    FP=C(2,1);
    FN=C(1,2);
    TN=C(2,2);
    P=TP+FN;
    N=TN+FP;
    Accuracy(i)=((TP+TN)/(P+N))*100;
    xlswrite('Accuracy.xlsx',Accuracy');
    Secificity=(TN/N)*100;
    Precision=(TP/(TP+FP))*100;
    Recall=(TP/P)*100;
    Fmeasure=(2*Precision*Recall)/(Precision+Recall);
%   class = classify(training_features(test,:),training_features(train,:),label(train,:));
%%%%%%%%%%%%%%%%%%%Estimate the generalization error.%%%%%%%%%%%%%%%%%
     classperf(cp,y,test);
end
 cp.ErrorRate 
data1=xlsread('Accuracy.xlsx');

%%%%%%%%%%%%%%%%%% Training%%%%%%%%%%%%%%%%%%%
% model = svmtrain(training_features,training_label);

% %%%%%%%%%%%%%%%%%%Testing%%%%%%%%%%%%%%%%%%%%%%
% y = svmclassify(model,testing_features);

%%%%%%%%%%%%%%%%%%%%%%%% Accuracy Calculation %%%%%%%%%%%%%%%%%%%%%%
%  count = 0;        
% for i = 1:length(testing_label)
%     if testing_label(i)== y(i)
%         count = count+1;
%     end
% end
% Accuracy = count/length(testing_label)*100;
%A=load('G:\matlab code\paper2\Results\(11) Lession Coordinate\GT.txt');
%B=load('G:\matlab code\paper2\Results\(11) Lession Coordinate\Auto.txt');
%[C,order] = confusionmat(A,B)
% [C,order] = confusionmat(testing_label,y)
%imtool(BW);% to show the position of pixel
[rows, columns] = size(data1);
  for row = 1 : rows
    Sum =sum(data1);
  end
  % Now get the mean over all values in this column.
  avg = Sum / rows;
avgac=avgacc(data1)
% for i = 1:10
% test = (indices == i); train = ~test;
% SVMModel = fitcsvm(training_features(train,:),label(train,:),'Standardize',true,'KernelFunction','RBF',...
%    'KernelScale','auto');
% label1 = predict(SVMModel,training_features(test,:) );
% [C,order] = confusionmat(label(test,:),label1);
% TP=C(1,1);
%     FP=C(2,1);
%     FN=C(1,2);
%     TN=C(2,2);
%     P=TP+FN;
%     N=TN+FP;
%     Accuracy(i)=((TP+TN)/(P+N))*100;
% end