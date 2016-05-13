load EOG_test2.mat;
win_size = 128; % 150
threshold = 45;
fraction = 1/6;

window = zeros(1,win_size);
out_ve1 = zeros(1,size(y,2));
out_ve2 = zeros(1,size(y,2));

%primul canal
for i=1:size(y,2)
    window(1:end-1)=window(2:end);% shiftare
    window(end)=y(2,i);
    if i>win_size
        if y(2,i)>mean(window)+threshold && abs(y(2,i)-y(2,floor(i-win_size*fraction))) >= threshold
            out_ve1(i)=out_ve1(i-1)+1;
        elseif y(2,i)<mean(window)-threshold && abs(y(2,i)-y(2,floor(i-win_size*fraction))) >= threshold
            out_ve1(i)=out_ve1(i-1)-1;
        else
            out_ve1(i) = out_ve1(i-1);
        end
    end
end

threshold = 67;
fraction = 1/8;

%al doilea canal
for i=1:size(y,2)
    window(1:end-1)=window(2:end);% shiftare
    window(end)=y(3,i);
    if i>win_size
        if y(3,i)>mean(window)+threshold && abs(y(3,i)-y(3,floor(i-win_size*fraction))) >= threshold
            out_ve2(i)=out_ve2(i-1)+1;
        elseif y(3,i)<mean(window)-threshold && abs(y(3,i)-y(3,floor(i-win_size*fraction))) >= threshold
            out_ve2(i)=out_ve2(i-1)-1;
        else
            out_ve2(i) = out_ve2(i-1);
        end
    end
end

% plotting the data
h=figure('color','w');
subplot(4,1,1);
plot(y(1,:),y(2,:),'b');
grid on;
hold on;
subplot(4,1,3);
plot(y(1,:),y(3,:),'r');
grid on;
subplot(4,1,2);
plot(y(1,:),out_ve1,'b');
grid on;
hold on;
subplot(4,1,4);
plot(y(1,:),out_ve2,'r');
grid on;

hold off;
