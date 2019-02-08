function y=test(A)
%% This code is written by Md. Kamrul Hasan. 
%Problem 1.5
%Here, A will be the Test Matrix that have any numbers of row but 
%having only 10 Features (columns).
%y is the return variable that have classes belonging by each rows A.
load('hw1data.mat'); %Data Load for Traing
Data_Load=Bdata; 
Data=Data_Load(:,1:10); %Only Taking Features, no Class. 
%Data Stardardization to make better distributions of Data.
mean_mu=mean(Data); %Mean findings.
std_Dev=std(Data); %Standard Deviations calculations.
for i=1:10
Data(:,i)=(Data(:,i)-mean_mu(:,i))/std_Dev(:,i); %Implement standardizations Formula.
end
%% Data separation for class +1 and Class -1.
Data_length=length(Data_Load); %length findings
Data_label=Data_Load(:,end); %Label Separations
indics_Class_1 = Data_Load(:,11) == 1;% indics for class 1
indics_Class_2 = Data_Load(:,11) == -1; % indics for class -1
Data_Class_1= Data(indics_Class_1,:); %Data correspondings to class +1
Data_Class_2= Data(indics_Class_2,:); %Data correspondings to class -1
%% Calculations of Prior Probability
P1=length(Data_Class_1)/Data_length;
P2=length(Data_Class_2)/Data_length;
%% Select data for Training 
P=0.75; % Percentage of data used for Training
length_Class_1=length(Data_Class_1);
length_Class_2=length(Data_Class_2);
Train_Class_1=Data_Class_1(1:ceil((P)*length_Class_1),:);
Train_Class_2=Data_Class_2(1:ceil((P)*length_Class_2),:);
Train=cat(1,Train_Class_1,Train_Class_2);
TrainLabel=cat(1,ones(length(Train_Class_1),1),(-1)*ones(length(Train_Class_2),1));
K=13; % Fixed Hyper-Parameter.
%% Building the kNN Classifier for each observations of Test
for i=1:10
A(:,i)=(A(:,i)-mean_mu(:,i))/std_Dev(:,i); %Implement standardizations Formula.
end
for row_test_A=1:length(A(:,1))
Target=A(row_test_A,:); 
%Taking one observations from Test Data for one iterations of whole Test observations.
for i_Train=1:length(Train)
    Train_Data=Train(i_Train,:);
    for i=1:10
        Distance(i)=(Train_Data(i)-Target(i))^2;
    end
     Eclidean_Dist(i_Train)=sqrt(sum(Distance));% Findings the eclidean distance from one point of 
     %Test data to all of the Train Data.
end
%% Data Shorting and Min distance Value extraction
Assending_Distance=sort(Eclidean_Dist);
minDistance=Assending_Distance(:,1:K);
%% Finding the index from Train data correspondings to the index
for i_for_K_indx=1:K
    for j=1:length(Eclidean_Dist)
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
class_1=0;
class_2=0;
for i_Train=1:length(class)
    if class(i_Train)==1
        class_1=class_1+1;
    elseif class(i_Train)==-1
        class_2=class_2+1;
    end
end
%%
Prob_Class_1(row_test_A)=class_1/K;
Prob_Class_2(row_test_A)=class_2/K;
end
%%
for i_Ret_A=1:length(A(:,1))
if Prob_Class_1(i_Ret_A)>Prob_Class_2 (i_Ret_A)
    y(i_Ret_A)=1;
else
    y(i_Ret_A)=-1;
end
end
end
%%