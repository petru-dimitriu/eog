load EOG_test2.mat;
x=detrend (y(2,:));
subplot (2,1,1);
plot(y(1,:),y(2,:),'r');
subplot(2,1,2);
plot(y(1,:),x,'b');