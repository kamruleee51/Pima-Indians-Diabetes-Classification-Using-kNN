%% This code is written by Md. Kamrul Hasan. 
%Problem 1.2 (a). To plot the density functions.
%% Making the Platform and clean the workspace
clc
clear all
close all
%% Taking the Varibales to plot
k1=1/(sqrt(15*pi)); %This variavle is calculated in Report
k2=1/(sqrt(14*pi));%This variavle is calculated in Report
x=-15:0.2:20; % Taking some values of X to see the corresponding Prob. Distribution.
%% Implement the density Functions that are given in Home Work
p1=k1*exp((-x.^2)/15);
p2=k2*exp(-(x-7).^2/14);
%% Ploting of the function in single graph for comparing.
object = plot(x,p1,x,p2);
object(1).LineWidth = 2;
object(2).LineWidth = 2;
lgd = legend('P(x|w1)','P(x|w2)');
lgd.FontSize = 17;
Title=title('Density function P(x|w1) and P(x|w2)');
Title.FontSize = 17;
xTitle=xlabel('Random Variable, x');
xTitle.FontSize = 17;
yTitle=ylabel('Probability Density Function, P (x|w)');
yTitle.FontSize = 17;
grid on 
%%                   The END