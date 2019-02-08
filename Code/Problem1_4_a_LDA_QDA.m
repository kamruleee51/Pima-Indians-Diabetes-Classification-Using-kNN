%% This code is written by Md. Kamrul Hasan. 
%Problem 1.4 (a). This code is for LDA and QDA for the given Data.
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
Data_Mean=mean(Data); %Mean findings.
Data_std=std(Data); %Standard Deviations calculations.
for i=1:10
Data(:,i)=(Data(:,i)-Data_Mean(:,i))/Data_std(:,i); %Implement standardizations Formula.
end
Data_length=length(Data_Load); %length findings
Data_label=Data_Load(:,end); %Label Separations
indics_Class_1 = Data_Load(:,11) == 1;% indics for class 1
indics_Class_2 = Data_Load(:,11) == -1; % indics for class -1
Data_Class_1= Data(indics_Class_1,:); %Data correspondings to class +1
Data_Class_2= Data(indics_Class_2,:); %Data correspondings to class -1
%% Making 4 group of data for each class to select randomly for Training and Testing
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
% Taking group A, B, C from both class for Training 
Train_Class_1=cat(1,Class_1_Group_B,Class_1_Group_C,Class_1_Group_D);
Train_Class_2=cat(1,Class_2_Group_B,Class_2_Group_C,Class_2_Group_D);
Train=cat(1,Train_Class_1,Train_Class_2);
TrainLabel=cat(1,ones(length(Train_Class_1),1),(-1)*ones(length(Train_Class_2),1));
Test=cat(1,Class_1_Group_A,Class_2_Group_A);
Testlabel=cat(1,ones(length(Test)/2,1),(-1)*ones(length(Test)/2,1));
%% Calculations of Prior Probability
P1=length(Train_Class_1)/length(Train);
P2=length(Train_Class_2)/length(Train);
%% Parameters for the classifiers
Mean_Class_1=mean(Train_Class_1);
Mean_Class_2=mean(Train_Class_2);
Sigma_Class_1=cov(Train_Class_1);
Sigma_Class_2=cov(Train_Class_2);
Inv_Sigma_Class_1=inv(Sigma_Class_1);
Inv_Sigma_Class_2=inv(Sigma_Class_2);
%For LDA, we need only one sigma. We can get this by below formula.
Sigma_LDA=P1*Sigma_Class_1+P2*Sigma_Class_2;
Inv_Sigma_LDA=inv(Sigma_LDA);
%% Build LDA classifier
for i=1:length(Test(:,1))
Z1_LDA(i) = -0.5*((Test(i, :))' - Mean_Class_1')' * Inv_Sigma_LDA * ((Test(i, :))'-Mean_Class_1')+log(P1); 
Z2_LDA(i) = -0.5*((Test(i, :))' - Mean_Class_2')' * Inv_Sigma_LDA * ((Test(i, :))'-Mean_Class_2')+log(P2); 
end
%% Accuracy, ROC curve Calculations for LDA
Output_LDA=Z1_LDA-Z2_LDA;
Value_LDA=Output_LDA.*Testlabel';
correct_LDA=length(find(Value_LDA>0));
error_LDA=length(find(Value_LDA<0));
Rejection_LDA=length(find(Value_LDA==0));
Accuracy_LDA=(correct_LDA/length(Test))*100;
disp(['Accuracy for LDA: ', num2str(Accuracy_LDA)]);
[R_LDA, AUC_LDA]=EvalROC([Testlabel Output_LDA'],1,-1);
RChPlot(R_LDA, [],'ROC for LDA');
disp(['AUC for LDA: ', num2str(AUC_LDA)]);
%% TP, FP, FN and TN for LDA
TP_LDA=0;
FN_LDA=0;
for i=1:length_Class_1/4
    if Z1_LDA(i)>Z2_LDA(i)
        TP_LDA=TP_LDA+1; 
    else
       FN_LDA=FN_LDA+1;
    end
end
TN_LDA=0;
FP_LDA=0;
for i=length_Class_1/4+1:length_Class_1/2
    if Z1_LDA(i)<Z2_LDA(i)
        TN_LDA=TN_LDA+1;
    else
        FP_LDA=FP_LDA+1;
    end
end
%% Build QDA classifier
for i=1:length(Test(:,1))
Z1_QDA(i) = -0.5*((Test(i, :))' - Mean_Class_1')' * Inv_Sigma_Class_1 * ((Test(i, :))'-Mean_Class_1')+log(P1)-(0.5)*log(det(Sigma_Class_1)); 
Z2_QDA(i) = -0.5*((Test(i, :))' - Mean_Class_2')' * Inv_Sigma_Class_2 * ((Test(i, :))'-Mean_Class_2')+log(P2)-(0.5)*log(det(Sigma_Class_2)); 
end
%% Accuracy, ROC curve Calculations for QDA
Output_QDA=Z1_QDA-Z2_QDA;
Value_QDA=Output_QDA.*Testlabel';
correct_QDA=length(find(Value_QDA>0));
error_QDA=length(find(Value_QDA<0));
Rejection_QDA=length(find(Value_QDA==0));
Accuracy_QDA=(correct_QDA/length(Test))*100;
disp(['Accuracy for QDA: ', num2str(Accuracy_QDA)]);
[R_QDA, AUC_QDA]=EvalROC([Testlabel Output_QDA'],1,-1);
RChPlot(R_QDA, [],'ROC for QDA');
disp(['AUC for QDA: ', num2str(AUC_QDA)]);
%% %% TP, FP, FN and TN for QDA
TP_QDA=0;
FN_QDA=0;
for i=1:length_Class_1/4
    if Z1_QDA(i)>=Z2_QDA(i)
        TP_QDA=TP_QDA+1; 
    else
       FN_QDA=FN_QDA+1;
    end
end
TN_QDA=0;
FP_QDA=0;
for i=length_Class_1/4+1:length_Class_1/2
    if Z1_QDA(i)<Z2_QDA(i)
        TN_QDA=TN_QDA+1;
    else
        FP_QDA=FP_QDA+1;
    end
end
toc;
%%                  The END