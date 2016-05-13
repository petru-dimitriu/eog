fig=figure;
fig.Color='White';
fig.Visible = 'on';
fig.Tag = 'Calibration_fig';
scrsz = get(groot,'ScreenSize');
fig.Position=[1 1 scrsz(3)-10 scrsz(4)-10];

handles = guihandles(fig);
handles.a=axes;
handles.a.Parent = fig;
handles.c1 = viscircles(handles.a,[1 1],1);



for i=1:20
    if strcmp(handles.c1.Visible,'on')==1
        handles.c1.Visible = 'off';
    else
        handles.c1.Visible='on';
    end
    guidata(fig,handles);
    pause(1);
end