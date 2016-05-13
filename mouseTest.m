load('EOG_test2.mat');


scrsz = get(groot,'ScreenSize');
scrHeight = scrsz(4)-25 - 120;  %de ce -25???
scrWidth = scrsz(3) - 120;

m1 = 1.0563e+04;
m3 = 9.6484e+03;
m2 = -3.9457e+03;
m4 = -5.0168e+03;

eogHeight = m1 - m3;
eogWidth = m2 - m4;

pixelHeight = eogHeight / scrHeight;
pixelWidth = eogWidth / scrWidth;


currentx = zeros(1,size(y,2));
currenty = zeros(1,size(y,3));
currentx = y(2,:) / pixelWidth;
%block.Dwork(11).Data(1)
currenty = y(3,:) / pixelHeight;
%block.Dwork(11).Data(2)

timestamp = y(1,:);
plot(timestamp,currentx,'b');
hold on;
plot(timestamp,currenty,'r');
grid on;