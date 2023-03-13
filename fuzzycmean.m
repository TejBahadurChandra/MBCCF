clear;
clc;
load fcmdata.dat
%[centers,U] = fcm(fcmdata,2);
%a=[1 2 3;5 6 7; 8 9 10];
[centers,U] = fcm1(fcmdata,2);