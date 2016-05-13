function sample_level2_s_function (block)
setup(block);
end

%% block setup
function setup(block)

% Register Dialog Params
block.NumDialogPrms = 2;
block.DialogPrmsTunable = {'NonTunable', 'NonTunable'};

% Register number of ports
block.NumInputPorts  = 2;
block.NumOutputPorts = 6;

% Setup port properties to be inherited or dynamic
block.SetPreCompInpPortInfoToDynamic;

% Override input port properties
block.InputPort(1).Dimensions = 1;
block.InputPort(1).DatatypeID = 0;
block.InputPort(1).Complexity = 'Real';
block.InputPort(1).SamplingMode = 'Inherited';
block.InputPort(1).DirectFeedthrough = false;

block.InputPort(2).Dimensions = 1;
block.InputPort(2).DatatypeID = 0;
block.InputPort(2).Complexity = 'Real';
block.InputPort(2).SamplingMode = 'Inherited';
block.InputPort(2).DirectFeedthrough = false;

% Override output port properties
block.OutputPort(1).Dimensions = 1;
block.OutputPort(1).DatatypeID  = 0;
block.OutputPort(1).Complexity  = 'Real';
block.OutputPort(1).SamplingMode = 'sample';

block.OutputPort(2).Dimensions = 1;
block.OutputPort(2).DatatypeID  = 0;
block.OutputPort(2).Complexity  = 'Real';
block.OutputPort(2).SamplingMode = 'sample';

block.OutputPort(3).Dimensions = 1;
block.OutputPort(3).DatatypeID  = 0;
block.OutputPort(3).Complexity  = 'Real';
block.OutputPort(3).SamplingMode = 'sample';

block.OutputPort(4).Dimensions = 1;
block.OutputPort(4).DatatypeID  = 0;
block.OutputPort(4).Complexity  = 'Real';
block.OutputPort(4).SamplingMode = 'sample';

block.OutputPort(5).Dimensions = 1;
block.OutputPort(5).DatatypeID  = 0;
block.OutputPort(5).Complexity  = 'Real';
block.OutputPort(5).SamplingMode = 'sample';

block.OutputPort(6).Dimensions = 1;
block.OutputPort(6).DatatypeID  = 0;
block.OutputPort(6).Complexity  = 'Real';
block.OutputPort(6).SamplingMode = 'sample';

% Register sample times
block.SampleTimes = [-1 0];

% Register functions
block.RegBlockMethod('SetInputPortSamplingMode', @SetInputPortSamplingMode);
block.RegBlockMethod('PostPropagationSetup', @DoPostPropSetup);
block.RegBlockMethod('InitializeConditions', @InitializeConditions);
block.RegBlockMethod('Update', @Update);
block.RegBlockMethod('Outputs', @Output);
block.RegBlockMethod('Terminate', @Terminate); % Required
end

%% SETINPUTPORTSAMPLINGMODE ***********************************************
function SetInputPortSamplingMode(block, idx, fd)
block.InputPort(idx).SamplingMode = fd;
end

%% PostPropagationSetup
function DoPostPropSetup(block)
block.NumDworks = 8;

% dwork1 %ch1
block.Dwork(1).Name            = 'Figure';
block.Dwork(1).Dimensions      = 128;
block.Dwork(1).DatatypeID      = 0;      % double
block.Dwork(1).Complexity      = 'Real'; % real
block.Dwork(1).UsedAsDiscState = false;


% dwork2 %ch2
block.Dwork(2).Name            = 'dwork2';
block.Dwork(2).Dimensions      = 128;
block.Dwork(2).DatatypeID      = 0;      % double
block.Dwork(2).Complexity      = 'Real'; % real
block.Dwork(2).UsedAsDiscState = false;

% dwork3 %medii
block.Dwork(3).Name            = 'currentMean';
block.Dwork(3).Dimensions      = 2;
block.Dwork(3).DatatypeID      = 0;      % double
block.Dwork(3).Complexity      = 'Real'; % real
block.Dwork(3).UsedAsDiscState = false;

% dwork2 %out_ve1
block.Dwork(4).Name            = 'dwork4';
block.Dwork(4).Dimensions      = 2;
block.Dwork(4).DatatypeID      = 0;      % double
block.Dwork(4).Complexity      = 'Real'; % real
block.Dwork(4).UsedAsDiscState = false;

% dwork2 %out_ve2
block.Dwork(5).Name            = 'dwork5';
block.Dwork(5).Dimensions      = 2;
block.Dwork(5).DatatypeID      = 0;      % double
block.Dwork(5).Complexity      = 'Real'; % real
block.Dwork(5).UsedAsDiscState = false;

% indexes
block.Dwork(6).Name            = 'dwork6';
block.Dwork(6).Dimensions      = 3;
block.Dwork(6).DatatypeID      = 0;      % double
block.Dwork(6).Complexity      = 'Real'; % real
block.Dwork(6).UsedAsDiscState = false;

% vectori calibrare ch1
block.Dwork(7).Name            = 'dwork7';
block.Dwork(7).Dimensions      = 1280;
block.Dwork(7).DatatypeID      = 0;      % double
block.Dwork(7).Complexity      = 'Real'; % real
block.Dwork(7).UsedAsDiscState = false;

% vectori calibrare ch2
block.Dwork(8).Name            = 'dwork8';
block.Dwork(8).Dimensions      = 1280;
block.Dwork(8).DatatypeID      = 0;      % double
block.Dwork(8).Complexity      = 'Real'; % real
block.Dwork(8).UsedAsDiscState = false;
end

%% InitializeConditions
function InitializeConditions(block)
% Initialize the figure for use with this simulation
fig=figure;
set(0,'DefaultFigureMenu','none');
scrsz = get(groot,'ScreenSize');
width=scrsz(3);
height=scrsz(4)-25;
axis([0 width 0 height]);
set(fig,'color','white')
set(fig,'visible','on')
set(fig,'Tag','Calibration_fig')
set(fig,'Position',[0 0 scrsz(3) scrsz(4)])
set(gca,'position',[0 0 1 1],'units','normalized') %fara margini



block.Dwork(1).Data = zeros(1,128); % 0.5 sec
block.Dwork(2).Data = zeros(1,128);
block.Dwork(4).Data = zeros(1,2);
block.Dwork(5).Data = zeros(1,2);
block.Dwork(6).Data = [1 1 0]; %index
% ...

end

%% %%%%%%%%%%%%%%%%%%%%%% UPDATE FUNCTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Update(block)
a=gca;
scrsz = get(groot,'ScreenSize');
width=scrsz(3);
height=scrsz(4)-25;
posc1 = [width/2 height-60 1 1];
posc2 = [width-60 height/2 1 1];
posc3 = [width/2 60 1 1];
posc4 = [60 height/2 1 1];
posc5 = [width/2 height/2 1 1];
c1 = rectangle('Position',posc1,'FaceColor','red','EdgeColor','red','curvature',[1 1]); %sus
c2 = rectangle('Position',posc2,'FaceColor','red','EdgeColor','red','curvature',[1 1]); %dreapta
c3 = rectangle('Position',posc3,'FaceColor','red','EdgeColor','red','curvature',[1 1]); %jos
c4 = rectangle('Position',posc4,'FaceColor','red','EdgeColor','red','curvature',[1 1]); %stanga
c5 = rectangle('Position',posc5,'FaceColor','red','EdgeColor','red','curvature',[1 1]); %centru
%set(c1,'visible','off')
set(c2,'visible','off')
set(c3,'visible','off')
set(c4,'visible','off')
set(c5,'visible','off')
%for i=0:4
if block.CurrentTime<10
   i=0;
end
if block.CurrentTime>=10 && block.CurrentTime<20
   i=1;
              set(c2,'visible','on')
end
if block.CurrentTime>=20 && block.CurrentTime<30
   i=2;
                 set(c3,'visible','on')
end
if block.CurrentTime>=30 && block.CurrentTime<40
   i=3;
                 set(c4,'visible','on')
end
if block.CurrentTime>=40 && block.CurrentTime<50
   i=4;
                 set(c5,'visible','on')
end
if block.CurrentTime>=50
   i=50;
end
if block.CurrentTime > 10 && block.Dwork(6).Data(3) < 10
    block.Dwork(6).Data(1)=1;
end
if block.CurrentTime > 20 && block.Dwork(6).Data(3) < 20
    block.Dwork(6).Data(1)=1;
end
if block.CurrentTime > 30 && block.Dwork(6).Data(3) < 30
    block.Dwork(6).Data(1)=1;
end
if block.CurrentTime > 40 && block.Dwork(6).Data(3) < 40
    block.Dwork(6).Data(1)=1;
end
 %   for j=60:-1:10
% block.CurrentTime
       
        if i==0
            set(c1,'Position',[width/2-block.Dwork(6).Data(1) height-60-block.Dwork(6).Data(1) block.Dwork(6).Data(1)*2 block.Dwork(6).Data(1)*2]);
            block.Dwork(7).Data(block.Dwork(6).Data(2))=block.InputPort(1).Data;
            %block.Dwork(7).Data(block.Dwork(6).Data(2))
            block.Dwork(8).Data(block.Dwork(6).Data(2))=block.InputPort(2).Data;
          %  block.Dwork(8).Data(block.Dwork(6).Data(2))
           % block.InputPort(2).Data
        end
        if i==1
            %set(c1,'visible','on')

            set(c2,'Position',[width-60-block.Dwork(6).Data(1) height/2-block.Dwork(6).Data(1) block.Dwork(6).Data(1)*2 block.Dwork(6).Data(1)*2]);
            block.Dwork(7).Data(block.Dwork(6).Data(2))=block.InputPort(1).Data;
            %block.Dwork(7).Data(block.Dwork(6).Data(2))
            block.Dwork(8).Data(block.Dwork(6).Data(2))=block.InputPort(2).Data;
            %block.Dwork(8).Data(block.Dwork(6).Data(2))
        end
        if i==2
            %set(c1,'visible','on')
            set(c3,'Position',[width/2-block.Dwork(6).Data(1) 60-block.Dwork(6).Data(1) block.Dwork(6).Data(1)*2 block.Dwork(6).Data(1)*2]);
            block.Dwork(7).Data(block.Dwork(6).Data(2))=block.InputPort(1).Data;
            %block.Dwork(7).Data(block.Dwork(6).Data(2))
            block.Dwork(8).Data(block.Dwork(6).Data(2))=block.InputPort(2).Data;
            %block.Dwork(8).Data(block.Dwork(6).Data(2))
        end
        if i==3
            %set(c1,'visible','on')
            set(c4,'Position',[60-block.Dwork(6).Data(1) height/2-block.Dwork(6).Data(1) block.Dwork(6).Data(1)*2 block.Dwork(6).Data(1)*2]);
            block.Dwork(7).Data(block.Dwork(6).Data(2))=block.InputPort(1).Data;
            %block.Dwork(7).Data(block.Dwork(6).Data(2))
            block.Dwork(8).Data(block.Dwork(6).Data(2))=block.InputPort(2).Data;
            %block.Dwork(8).Data(block.Dwork(6).Data(2))
        end
        if i==4
            %set(c1,'visible','on')
            set(c5,'Position',[width/2-block.Dwork(6).Data(1) height/2-block.Dwork(6).Data(1) block.Dwork(6).Data(1)*2 block.Dwork(6).Data(1)*2]);
            block.Dwork(7).Data(block.Dwork(6).Data(2))=block.InputPort(1).Data;
            %block.Dwork(7).Data(block.Dwork(6).Data(2))
            block.Dwork(8).Data(block.Dwork(6).Data(2))=block.InputPort(2).Data;
            %block.Dwork(8).Data(block.Dwork(6).Data(2))
        end
       % pause(0.1)
        block.Dwork(6).Data(1)=block.Dwork(6).Data(1)+1;
        block.Dwork(6).Data(2)=block.Dwork(6).Data(2)+1;
        if i==50
            block.Dwork(8).Data(1:256)
        end
      
 %   end
   
%end
block.Dwork(1).Data(1:127) = block.Dwork(1).Data(2:128); % mut la stanga vectorul
block.Dwork(1).Data(128) = block.InputPort(1).Data;
block.Dwork(3).Data(1) = mean(block.Dwork(1).Data); %medie ch1

block.Dwork(2).Data(1:127) = block.Dwork(2).Data(2:128); % mut la stanga vectorul
block.Dwork(2).Data(128) = block.InputPort(2).Data;
block.Dwork(3).Data(2) = mean(block.Dwork(2).Data); %medie ch2

threshold = 45;
fraction = 1/6;

if block.Dwork(1).Data(128) > block.Dwork(3).Data(1) + threshold %&& abs(block.Dwork(1).Data(128)-block.Dwork(1).Data(floor(128-128*fraction)))>=threshold
    block.Dwork(4).Data(2) = block.Dwork(4).Data(1)+1;
elseif block.Dwork(1).Data(128) < block.Dwork(3).Data(1) - threshold %&& abs(block.Dwork(1).Data(128)-block.Dwork(1).Data(floor(128-128*fraction)))>=threshold
    block.Dwork(4).Data(2) = block.Dwork(4).Data(1)-1;
else
    block.Dwork(4).Data(2) = block.Dwork(4).Data(1);
end

block.Dwork(4).Data(1)=block.Dwork(4).Data(2);

threshold = 0.1;
fraction = 1/6;

if block.Dwork(2).Data(128) > block.Dwork(3).Data(2) + threshold %&& abs(block.Dwork(2).Data(128)-block.Dwork(2).Data(floor(128-128*fraction)))>=threshold
    block.Dwork(5).Data(2) = block.Dwork(5).Data(1)+1;
elseif block.Dwork(2).Data(128) < block.Dwork(3).Data(2) - threshold %&& abs(block.Dwork(2).Data(128)-block.Dwork(2).Data(floor(128-128*fraction)))>=threshold
    block.Dwork(5).Data(2) = block.Dwork(5).Data(1)-1;
else
    block.Dwork(5).Data(2) = block.Dwork(5).Data(1);
end

block.Dwork(5).Data(1)=block.Dwork(5).Data(2);

block.Dwork(6).Data(3)=block.CurrentTime;

end

%% Output function
function Output(block)

block.OutputPort(1).Data = block.Dwork(1).Data(128);   % ch1
block.OutputPort(2).Data = block.Dwork(2).Data(128);   % ch2
block.OutputPort(3).Data = block.Dwork(3).Data(1);      % mean 1
block.OutputPort(4).Data = block.Dwork(3).Data(2);      % mean 2
block.OutputPort(5).Data=block.Dwork(4).Data(2);    %out_ve1
block.OutputPort(6).Data=block.Dwork(5).Data(2);    %out_ve2

end
%% Terminate
function Terminate(block)
end