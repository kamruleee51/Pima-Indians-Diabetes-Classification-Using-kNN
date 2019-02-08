%% This code is written by Md. Kamrul Hasan. 
%Problem 1.5
%Here, A will be the Test Matrix that have any numbers of row but 
%having only 10 Features (columns).
%% Clear the workspace
clc
clear all 
close all
%% Load your Test Matrix here. 

%A= This is your test Matrix

%% Calling the test function having argument A.
y=test(A);
%% Count, How many rows belongs to Class +1 or Class -1.
class_1=0;
class_2=0;
for i=1:length(y)
if y(i)==1
    class_1=class_1+1;
else
    class_2=class_2+1;
end
end
disp(['Number of rows belongs to +1: ', num2str(class_1)]);
disp(['Number of rows belongs to -1: ', num2str(class_2)]);
%%                  The    END
    