%% This code is written by Md. Kamrul Hasan. 
%Problem 1.4 (b)
%This is for kNN classifier on hw1data.data which has two class namly +1 and -1. 
%% Making the Platform and clean the workspace
clc
clear all
close all
tic;
%%
load('hw1data.mat');
Data_Load=Bdata; %Data Load
Data=Data_Load(:,1:10); %Only Taking Features, no Class. 
%Data Stardardization to make better distributions of Data.
mean=mean(Data); %Mean findings.
std=std(Data); %Standard Deviations calculations.
for i=1:10
Data(:,i)=(Data(:,i)-mean(:,i))/std(:,i); %Implement standardizations Formula.
end
Data_length=length(Data_Load); %length findings
Data_label=Data_Load(:,end); %Label Separations
indics_Class_1 = Data_Load(:,11) == 1;% indics for class 1
indics_Class_2 = Data_Load(:,11) == -1; % indics for class -1
Data_Class_1= Data(indics_Class_1,:); %Data correspondings to class +1
Data_Class_2= Data(indics_Class_2,:); %Data correspondings to class -1
%% Making 4 group of data of each class to select randomly.... 
%for Training and Testing
length_Class_1=length(Data_Class_1);
length_Class_2=length(Data_Class_2);
Class_1_Group_A=Data_Class_1(1:length_Class_1/4,:);
Class_1_Group_B=Data_Class_1(length_Class_1/4+1:length_Class_1/2,:);
Class_1_Group_C=Data_Class_1(length_Class_1/2+1:3*length_Class_1/4,:);
Class_1_Group_D=Data_Class_1(3*length_Class_1/4+1:length_Class_1,:);
Class_2_Group_A=Data_Class_2(1:length_Class_2/4,:);
Class_2_Group_B=Data_Class_2(length_Class_2/4+1:length_Class_2/2,:);
Class_2_Group_C=Data_Class_2(length_Class_2/2+1:3*length_Class_2/4,:);
Class_2_Group_D=Data_Class_2(3*length_Class_2/4+1:length_Class_2,:);
%% Select data for Training and testing
% Taking 3 groups from A, B, C, D from both class for Training 
Train_Class_1=cat(1,Class_1_Group_A,Class_1_Group_B,Class_1_Group_D);
Train_Class_2=cat(1,Class_2_Group_A,Class_2_Group_B,Class_2_Group_D);
Train=cat(1,Train_Class_1,Train_Class_2);
TrainLabel=cat(1,ones(length(Train_Class_1),1),(-1)*ones(length(Train_Class_2),1));
Test=cat(1,Class_1_Group_C,Class_2_Group_C);
Testlabel=cat(1,ones(length(Test)/2,1),(-1)*ones(length(Test)/2,1));
%% Taking hyper-Parameter Value that is K. K_Max is value 
%from the square roots of the total length of Train Data.
%K will be varied from 1 to K_Max with the step of 1.
K_Max=ceil(sqrt(length(Train)));
for K=1:17
%% Building the kNN Classifier for each observations of Test
for i_test=1:length(Test(:,1))
Target=Test(i_test,:); %Taking one observations from Test Data for one iterations of whole Test observations.
for i_Train=1:length(Train)
    Train_Data=Train(i_Train,:);
    for i=1:10
        Distance(i)=(Train_Data(i)-Target(i))^2;
    end
     Eclidean_Dist(i_Train)=sqrt(sum(Distance));% Findings the eclidean distance from one point of 
     %Test data to all of the Train Data.
end
%% Data Shorting and Min distance K number Values extraction
Assending_Distance=sort(Eclidean_Dist);
minDistance=Assending_Distance(:,1:K);
%% Finding the index from Train data correspondings to the index
for i_for_K_indx=1:K
    for j=1:length(Train)
        if minDistance(i_for_K_indx)==Eclidean_Dist(j)
           K_index_Train(i_for_K_indx)=j;
        end
    end
end
%% Which Class it belongs to.
for i_for_Lebel=1:length(K_index_Train)
      class(i_for_Lebel)=TrainLabel(K_index_Train(i_for_Lebel));
end
%% Calculating Posterior prob. for all test Data
K_in_class_1=0;
K_in_class_2=0;
for i_Train=1:length(class)
    if class(i_Train)==1
        K_in_class_1=K_in_class_1+1;
    elseif class(i_Train)==-1
        K_in_class_2=K_in_class_2+1;
    end
end
Prob_Class_1(i_test)=K_in_class_1/K;
Prob_Class_2(i_test)=K_in_class_2/K;
end
%% Finding out some performance Parameters from the Classifier.
%Let's +1 belongs to Positve and -1 belongs to Negative. Now, finding TP,
%FN, FP and TN
True_Positive=0;
False_Negative=0;
for i=1:length_Class_1/4
    if Prob_Class_1(i)>Prob_Class_2(i)
        True_Positive=True_Positive+1;
    else
       False_Negative=False_Negative+1; 
    end
end
True_Negative=0;
False_Positive=0;
for i_Train=length_Class_1/4+1:length_Class_1/2
    if Prob_Class_1(i_Train)<Prob_Class_2(i_Train)
        True_Negative=True_Negative+1;
    else
       False_Positive=False_Positive+1; 
    end
end
%%
Total_TP_TN=True_Positive+True_Negative;
Total_FN_FP=False_Negative+False_Positive;
% Error(K)=(Total_FN_FP/length(Test))*100;
Accuracy(K)=(Total_TP_TN/length(Test))*100;
Sensitivity(K)=(True_Positive/(True_Positive+False_Negative))*100;
Specificity(K)=(True_Negative/(True_Negative+False_Positive))*100;
PPV(K)=(True_Positive/(True_Positive+False_Positive))*100;
NPV(K)=(True_Negative/(True_Negative+False_Negative))*100;
FPR(K)=(False_Positive/(True_Negative+False_Positive))*100;
FNR(K)=(False_Negative/(True_Positive+False_Negative))*100;
F1_Score(K)=((2*True_Positive)/(2*True_Positive+False_Positive+False_Negative))*100;
end
%% Showing the Performance Parameters 
disp(['The Accuracy: ', num2str(max(Accuracy))]);
disp(['The Sensitivity: ', num2str(max(Sensitivity))]);
disp(['The Specificity: ', num2str(max(Specificity))]);
disp(['The Positive Predicted Value: ', num2str(max(PPV))]);
disp(['The Negative Predicted Value: ', num2str(max(NPV))]);
disp(['The False Positive Rate: ', num2str(max(FPR))]);
disp(['The False Negative Rate: ', num2str(max(FNR))]);
disp(['The F1 Score: ', num2str(max(F1_Score))]);
%% Ploting some performance Parameters w.r.t. different K.
K=1:17;
object = plot(K,Accuracy,K,F1_Score,K,Sensitivity,K,Specificity);
object(1).LineWidth = 2;
object(2).LineWidth = 2;
object(3).LineWidth = 2;
object(4).LineWidth = 2;
lgd = legend('Accuracy','F1 Score','Sensitivity','Specificity');
lgd.FontSize = 17;
Title=title('Accuracy, F1 Score, Sensitivity and Specificity VS K');
Title.FontSize = 17;
xTitle=xlabel('Different Values of K');
xTitle.FontSize = 17;
yTitle=ylabel('Accuracy, F1 Score, Sensitivity and Specificity');
yTitle.FontSize = 17;
grid on 
%%
Output_kNN=Prob_Class_1-Prob_Class_2;
[R_kNN, AUC_kNN]=EvalROC([Testlabel Output_kNN'],1,-1);
RChPlot(R_kNN, [],'ROC for kNN');
disp(['AUC for kNN: ', num2str(AUC_kNN)]);
toc;
%%                      END