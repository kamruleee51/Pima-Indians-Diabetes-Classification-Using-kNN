%% This code is written by Md. Kamrul Hasan. 
%Problem 1.3. To plot the density functions with minimum conditional risk
%% Making the Platform and clean the workspace
clc
clear all
close all
%% Taking the Varibales to plot
k1=1/(sqrt(0.2*pi)); %This variavle is calculated in Report
k2=1/(sqrt(0.6*pi));%This variavle is calculated in Report
x=-3:0.02:3; % Taking some values of X to see the corresponding Prob. Distribution.
%% Implement the density Functions that are given in Home Work
p1=k1*exp((-x.^2)/0.02);
p2=k2*exp(-(x-1.5).^2/0.18);
y_decision=(1/3000)*(400*x.^2+150*x-148.77); % Roots correspondings to minimum conditional risk.
%(1/3000) is used as a scalling to plot in a single graph
%% Ploting of the function in single graph with minimum conditional risk
object=plot(x,p1,x,p2);
hold on
plot(x,y_decision,'LineWidth',2,'Color','red');
object(1).LineWidth = 2;
object(2).LineWidth = 2;
lgd = legend('P(x|w1)','P(x|w2)','Decision Line');
lgd.FontSize = 17;
Title=title('Density function P(x|w1) and P(x|w2) with Minimum Conditional Risk Region');
Title.FontSize = 17;
xTitle=xlabel('Random Variable, x');
xTitle.FontSize = 17;
yTitle=ylabel('Probability Density Function, P (x|w)');
yTitle.FontSize = 17;
grid on 
%%                     The END