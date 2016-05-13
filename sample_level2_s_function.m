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
block.NumOutputPorts = 8;

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

block.OutputPort(7).Dimensions = 1;
block.OutputPort(7).DatatypeID  = 0;
block.OutputPort(7).Complexity  = 'Real';
block.OutputPort(7).SamplingMode = 'sample';

block.OutputPort(8).Dimensions = 1;
block.OutputPort(8).DatatypeID  = 0;
block.OutputPort(8).Complexity  = 'Real';
block.OutputPort(8).SamplingMode = 'sample';

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
block.NumDworks = 10;

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
block.Dwork(7).Dimensions      = 12800;
block.Dwork(7).DatatypeID      = 0;      % double
block.Dwork(7).Complexity      = 'Real'; % real
block.Dwork(7).UsedAsDiscState = false;

% vectori calibrare ch2
block.Dwork(8).Name            = 'dwork8';
block.Dwork(8).Dimensions      = 12800;
block.Dwork(8).DatatypeID      = 0;      % double
block.Dwork(8).Complexity      = 'Real'; % real
block.Dwork(8).UsedAsDiscState = false;

% dwork3 %medii
block.Dwork(9).Name            = 'meanCh1';
block.Dwork(9).Dimensions      = 5;
block.Dwork(9).DatatypeID      = 0;      % double
block.Dwork(9).Complexity      = 'Real'; % real
block.Dwork(9).UsedAsDiscState = false;
% dwork3 %medii
block.Dwork(10).Name            = 'meanCh2';
block.Dwork(10).Dimensions      = 5;
block.Dwork(10).DatatypeID      = 0;      % double
block.Dwork(10).Complexity      = 'Real'; % real
block.Dwork(10).UsedAsDiscState = false;
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

   i = 0; 

if block.CurrentTime > 5  && block.Dwork(6).Data(3) < 5
    i = 0;
    scrsz = get(groot,'ScreenSize');
    width=scrsz(3);
    height=scrsz(4)-25;
    posc1 = [width/2-60 height-120 120 120];
    c1 = rectangle('Position',posc1,'FaceColor','red','EdgeColor','red','curvature',[1 1]); %sus
end
if block.CurrentTime > 15 && block.Dwork(6).Data(3) < 15
    i = 1;
  %  set(c1,'visible','on');
      scrsz = get(groot,'ScreenSize');
    width=scrsz(3);
    height=scrsz(4)-25;
    posc2 = [width-120 height/2-60 120 120];
   c2 = rectangle('Position',posc2,'FaceColor','red','EdgeColor','red','curvature',[1 1]); %dreapta 
   block.Dwork(6).Data(1)=1;
   block.Dwork(9).Data(1) = mean(block.Dwork(7).Data);
   block.Dwork(10).Data(1) = mean(block.Dwork(8).Data);
   block.Dwork(6).Data(2) = 1;
end
if block.CurrentTime > 25 && block.Dwork(6).Data(3) < 25
    i = 2;
    %set(c2,'visible','off')
        scrsz = get(groot,'ScreenSize');
    width=scrsz(3);
    height=scrsz(4)-25;
    posc3 = [width/2-60 0 120 120];
    c3 = rectangle('Position',posc3,'FaceColor','red','EdgeColor','red','curvature',[1 1]); %jos
   block.Dwork(6).Data(1)=1;
   block.Dwork(9).Data(2) = mean(block.Dwork(7).Data);
   block.Dwork(10).Data(2) = mean(block.Dwork(8).Data);
   block.Dwork(6).Data(2) = 1;
end
if block.CurrentTime > 35 && block.Dwork(6).Data(3) < 35
    i = 3;
    %set(c3,'visible','off')
        scrsz = get(groot,'ScreenSize');
    width=scrsz(3);
    height=scrsz(4)-25;
    posc4 = [0 height/2-60 120 120];
    c4 = rectangle('Position',posc4,'FaceColor','red','EdgeColor','red','curvature',[1 1]); %stanga
   block.Dwork(6).Data(1)=1;
   block.Dwork(9).Data(3) = mean(block.Dwork(7).Data);
   block.Dwork(10).Data(3) = mean(block.Dwork(8).Data);
   block.Dwork(6).Data(2) = 1;
end
if block.CurrentTime > 45 && block.Dwork(6).Data(3) < 45
    i = 4;
    %set(c4,'visible','off')
        scrsz = get(groot,'ScreenSize');
    width=scrsz(3);
    height=scrsz(4)-25;
    posc5 = [width/2-60 height/2-60 120 120];
    c5 = rectangle('Position',posc5,'FaceColor','red','EdgeColor','red','curvature',[1 1]); %centru
   block.Dwork(6).Data(1)=1;
   block.Dwork(9).Data(4) = mean(block.Dwork(7).Data);
   block.Dwork(10).Data(4) = mean(block.Dwork(8).Data);
   block.Dwork(6).Data(2) = 1;
end
if block.CurrentTime > 55 && block.Dwork(6).Data(3) < 55
    i = 50;
   block.Dwork(9).Data(5) = mean(block.Dwork(7).Data);
   block.Dwork(10).Data(5) = mean(block.Dwork(8).Data);
   block.Dwork(6).Data(2) = 1;
end
 %   for j=60:-1:10
% block.CurrentTime
       
        if i==0 && block.CurrentTime >= 5
      
            block.Dwork(7).Data(block.Dwork(6).Data(2))=block.InputPort(1).Data;
            %block.Dwork(7).Data(block.Dwork(6).Data(2))
            block.Dwork(8).Data(block.Dwork(6).Data(2))=block.InputPort(2).Data;
          %  block.Dwork(8).Data(block.Dwork(6).Data(2))
           % block.InputPort(2).Data
        end
        if i==1 && block.CurrentTime > 5
            %set(c1,'visible','on')

           
            block.Dwork(7).Data(block.Dwork(6).Data(2))=block.InputPort(1).Data;
            %block.Dwork(7).Data(block.Dwork(6).Data(2))
            block.Dwork(8).Data(block.Dwork(6).Data(2))=block.InputPort(2).Data;
            %block.Dwork(8).Data(block.Dwork(6).Data(2))
        end
        if i==2 && block.CurrentTime > 5
            %set(c1,'visible','on')
           
            block.Dwork(7).Data(block.Dwork(6).Data(2))=block.InputPort(1).Data;
            %block.Dwork(7).Data(block.Dwork(6).Data(2))
            block.Dwork(8).Data(block.Dwork(6).Data(2))=block.InputPort(2).Data;
            %block.Dwork(8).Data(block.Dwork(6).Data(2))
        end
        if i==3 && block.CurrentTime > 5
            %set(c1,'visible','on')
           
            block.Dwork(7).Data(block.Dwork(6).Data(2))=block.InputPort(1).Data;
            %block.Dwork(7).Data(block.Dwork(6).Data(2))
            block.Dwork(8).Data(block.Dwork(6).Data(2))=block.InputPort(2).Data;
            %block.Dwork(8).Data(block.Dwork(6).Data(2))
        end
        if i==4 && block.CurrentTime > 5
            %set(c1,'visible','on')
           
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
block.OutputPort(3).Data = block.Dwork(3).Data(1);     % means
block.OutputPort(4).Data = block.Dwork(3).Data(2);     %out_ve1
block.OutputPort(5).Data=block.Dwork(4).Data(2);    %out_ve2
block.OutputPort(6).Data=block.Dwork(5).Data(2);    %index
block.OutputPort(7).Data=block.Dwork(9).Data(5);    %meanCh1
block.OutputPort(8).Data=block.Dwork(10).Data(5);   %meanCh2

end
%% Terminate
function Terminate(block)
end