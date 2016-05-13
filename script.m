%incarcare fisier *.mat
load('EOG_test2.mat');

feqs = 255;
seconds = 10;

timestamp = y(1,:);
samples = length(timestamp);
ch1 = y(2,:);
ch2 = y(3,:);

ch1 = ch1((feqs*seconds+1):samples);
ch2 = ch2((feqs*seconds+1):samples);
timestamp = timestamp(feqs*seconds+1:samples);

avg1 = mean(ch1(1:(feqs*5)));
avg2 = mean(ch2(1:(feqs*5)));

ch1 = ch1 - avg1;
ch2 = ch2 - avg2;

x1 = 50 * 255;
x2 = 52 * 255;
delta = (ch2(x2)-ch2(x1)) / ((52-50)*255);
cdelta = 0;

%{
for i=1:length(ch2)
    ch2(i) = ch2(i) - cdelta;
    cdelta = cdelta + delta;
end
%}

plot(timestamp,ch1,'b');
hold on;
plot(timestamp,ch2,'r');
grid on;