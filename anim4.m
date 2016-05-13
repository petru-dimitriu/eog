
%iptsetpref('ImshowBorder','tight'); 
set(0,'DefaultFigureMenu','none'); %fara meniu, toolbar
fig=figure;
scrsz = get(groot,'ScreenSize');
width=scrsz(3);
height=scrsz(4)-25;
centerw=width/2;
centerh=height/2;

axis([0 width 0 height]);
set(fig,'color','white')
set(fig,'visible','on')
set(fig,'Tag','Calibration_fig')

set(fig,'Position',[0 0 scrsz(3) scrsz(4)])
set(gca,'position',[0 0 1 1],'units','normalized') %fara margini
handles = guihandles(fig);
%undecorateFig(fig);
a=gca;
c1 = viscircles(a,[width/2 height-60],60); %sus
c2 = viscircles(a,[width-60 height/2], 60); %dreapta
c3 = viscircles(a,[width/2 60],60); %jos
c4 = viscircles(a,[60 height/2],60); %stanga
c5 = viscircles(a, [width/2 height/2],60);

set(c1,'visible','off')
set(c2,'visible','off')
set(c3,'visible','off')
set(c4,'visible','off')
set(c5,'visible','off')


for i=0:4
   
    for j=60:-1:10
        
        if i==0
            set(c1,'visible','off')
            c1=viscircles(a,[width/2 height-60],j);
        end
        if i==1
            set(c2,'visible','off')
            c2 = viscircles(a,[width-60 height/2], j);
        end
        if i==2
            set(c3,'visible','off')
            c3 = viscircles(a,[width/2 60],j);
        end
        if i==3
            set(c4,'visible','off')
            c4 = viscircles(a,[60 height/2],j);
        end
        if i==4
            set(c5,'visible','off')
            c5 = viscircles(a, [width/2 height/2],j);
        end
        pause(0.02)
    end
    
end