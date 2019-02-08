%% This code is written by Md. Kamrul Hasan. 
%Problem 1.2 (b). To plot the density functions with the decision boundary.
%% Making the Platform and clean the workspace
clc
clear all
close all
%% Taking the Varibales to plot
k1=1/(sqrt(15*pi)); %This variavle is calculated in Report
k2=1/(sqrt(14*pi));%This variavle is calculated in Report
x=-15:0.2:21; %Taking some values of X to see the corresponding Prob. Distribution.
x_1=3.52; %Root of quadratic Eq. when Prior ratio is 1.
x_05=4.24; %Root of quadratic Eq. when Prior ratio is 0.5.
x_4=2.10; %Root of quadratic Eq. when Prior ratio is 4.
%% Implement the density Functions that are given in Home Work
p1=k1*exp((-x.^2)/15);
p2=k2*exp(-(x-7).^2/14);
%% Ploting of the function in single graph with Decision Line
% Ploting for the 1st condition when Prior ratio is 1.
figure (1) 
object=plot(x,p1,x,p2);
hold on
line([x_1 x_1],[0 max(p2)],'LineWidth',2,'Color','red');
object(1).LineWidth = 2;
object(2).LineWidth = 2;
lgd = legend('P(x|w1)','P(x|w2)','Decision Line');
lgd.FontSize = 17;
Title=title('Density function P(x|w1) and P(x|w2) with Decision Region');
Title.FontSize = 17;
xTitle=xlabel('Random Variable, x');
xTitle.FontSize = 17;
yTitle=ylabel('Probability Density Function, P (x|w)');
yTitle.FontSize = 17;
grid on 
%Ploting for thr 2nd Conditions when Prior ratio is 0.5.
figure (2)
object=plot(x,p1,x,p2);
hold on
line([x_05 x_05],[0 max(p2)],'LineWidth',2,'Color','red');
object(1).LineWidth = 2;
object(2).LineWidth = 2;
lgd = legend('P(x|w1)','P(x|w2)','Decision Line');
lgd.FontSize = 17;
Title=title('Density function P(x|w1) and P(x|w2) with Decision Region');
Title.FontSize = 17;
xTitle=xlabel('Random Variable, x');
xTitle.FontSize = 17;
yTitle=ylabel('Probability Density Function, P (x|w)');
yTitle.FontSize = 17;
grid on 
% Ploting for the 3rd Condition when Prior ratio is 4.
figure (3)
object=plot(x,p1,x,p2);
hold on
line([x_4 x_4],[0 max(p2)],'LineWidth',2,'Color','red');
object(1).LineWidth = 2;
object(2).LineWidth = 2;
lgd = legend('P(x|w1)','P(x|w2)','Decision Line');
lgd.FontSize = 17;
Title=title('Density function P(x|w1) and P(x|w2) with Decision Region');
Title.FontSize = 17;
xTitle=xlabel('Random Variable, x');
xTitle.FontSize = 17;
yTitle=ylabel('Probability Density Function, P (x|w)');
yTitle.FontSize = 17;
grid on 
%%                        The END