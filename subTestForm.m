function varargout = subTestForm(varargin)
%% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @subTestForm_OpeningFcn, ...
    'gui_OutputFcn',  @subTestForm_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

%% Executes just before subTestForm is made visible
function subTestForm_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to subTestForm (see VARARGIN)
handles.output = hObject;
% add a continuous value change listener
if ~isfield(handles,'hListener')
    handles.hListener = ...
        addlistener(handles.slider1,'ContinuousValueChange',@respondToContSlideCallback);
end

%% Include all the names of compared pairs
data = {
    
    {'A.bmp','B.bmp';[],[]},...
    {'A.bmp','C.bmp';[],[]},...
    {'B.bmp','C.bmp';[],[]},...
    %    .
    %    .
    %    .
      };

%% Output
result= cell(length(data),5);
result{1,1}='No. Comparisons';
result{1,2}='Left';
result{1,3}='Right';
result{1,4}='Score Left';
result{1,5}='Score Right';

%% Read paired images
handles.DataLen = length(data);
for i=1:length(data)
    for j=1:2
        seq_name = data{1,i}(1,j);
        I = imread(seq_name{1,1});
        temp = cell(1);
        temp{1,1} = I;
        data{1,i}(2,j) = temp;
        s = strcat('Loading ', seq_name ,' sequence');
        hand = waitbar(0,s);
        close(hand);
    end
end

handles.data = data;
handles.result = result;
handles.Tc =1;
%% Initialize the UI
set(handles.InsOrig, 'Visible', 'off');
set(handles.InsImp, 'Visible', 'off');
set(handles.axes1, 'Visible', 'off');
set(handles.axes2, 'Visible', 'off');
set(handles.finish, 'Visible', 'off');
set(handles.title, 'Visible', 'off');
set(handles.text17, 'Visible', 'off');
set(handles.text18, 'Visible', 'off');
set(handles.pushbutton10,'Visible', 'off')

%% set the slider range and step size
numSteps = 7;
set(handles.slider1, 'Min', -3);
set(handles.slider1, 'Max',3);
set(handles.slider1, 'Value',0);
set(handles.slider1, 'SliderStep', [1/(numSteps-1) , 1/(numSteps-1) ]);
set(handles.pushbutton6,'backgroundcolor',[1 1 0])
set(handles.pushbutton7,'backgroundcolor',[1 1 0])
set(handles.text24, 'FontSize', 12);

%% save the current/last slider value
handles.lastSliderVal = get(handles.slider1,'Value');
roundCounter = 1;
handles.RC = roundCounter;
% Update handles structure
guidata(hObject, handles);

%% Outputs from this function are returned to the command line.
function varargout = subTestForm_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;

%% Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel2, 'Visible', 'off');
set(handles.uipanel1, 'Visible', 'off');
set(handles.InsOrig, 'Visible', 'on');
filename = get(handles.nameBox, 'String');
handles.filename = filename;
handles.fileage= str2double(handles.ageBox.String); %returns contents of ageBox as a double
% Update handles structure
guidata(hObject, handles);

%% Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
%eventdata % reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ( handles.lastSliderVal ==0)
    set(handles.text24, 'FontSize', 12);
    set(handles.text25, 'FontSize', 10);
    set(handles.text26, 'FontSize', 10);
    set(handles.text33, 'FontSize', 10);
    set(handles.text23, 'FontSize', 10);
    set(handles.text22, 'FontSize', 10);
    set(handles.text32, 'FontSize', 10);
    set(handles.pushbutton6,'backgroundcolor',[1 1 0])
    set(handles.pushbutton7,'backgroundcolor',[1 1 0])
    
end
if ( handles.lastSliderVal==1)
    set(handles.text24, 'FontSize', 10);
    set(handles.text25, 'FontSize', 12);
    set(handles.text26, 'FontSize', 10);
    set(handles.text33, 'FontSize', 10);
    set(handles.text23, 'FontSize', 10);
    set(handles.text22, 'FontSize', 10);
    set(handles.text32, 'FontSize', 10);
    set(handles.pushbutton6,'backgroundcolor',[0  1 0])
    set(handles.pushbutton7,'backgroundcolor',[1 0.5 0])
    
end
if (( handles.lastSliderVal==2))
    set(handles.text24, 'FontSize', 10);
    set(handles.text25, 'FontSize', 10);
    set(handles.text26, 'FontSize', 12);
    set(handles.text33, 'FontSize', 10);
    set(handles.text23, 'FontSize', 10);
    set(handles.text22, 'FontSize', 10);
    set(handles.text32, 'FontSize', 10);
    set(handles.pushbutton6,'backgroundcolor',[0 0.8 0])
    set(handles.pushbutton7,'backgroundcolor',[1 0 0])
end
if (( handles.lastSliderVal==3))
    set(handles.text24, 'FontSize', 10);
    set(handles.text25, 'FontSize', 10);
    set(handles.text26, 'FontSize', 10);
    set(handles.text33, 'FontSize', 12);
    set(handles.text23, 'FontSize', 10);
    set(handles.text22, 'FontSize', 10);
    set(handles.text32, 'FontSize', 10);
    set(handles.pushbutton6,'backgroundcolor',[0 0.5 0])
    set(handles.pushbutton7,'backgroundcolor',[0.5 0 0])
end

if ( handles.lastSliderVal==-1)
    set(handles.text24, 'FontSize', 10);
    set(handles.text25, 'FontSize', 10);
    set(handles.text26, 'FontSize', 10);
    set(handles.text33, 'FontSize', 10);
    set(handles.text23, 'FontSize', 12);
    set(handles.text22, 'FontSize', 10);
    set(handles.text32, 'FontSize', 10);
    set(handles.pushbutton7,'backgroundcolor',[0  1 0])
    set(handles.pushbutton6,'backgroundcolor',[1 0.5 0])
end
if (( handles.lastSliderVal==-2))
    set(handles.text24, 'FontSize', 10);
    set(handles.text25, 'FontSize', 10);
    set(handles.text26, 'FontSize', 10);
    set(handles.text33, 'FontSize', 10);
    set(handles.text23, 'FontSize', 10);
    set(handles.text22, 'FontSize', 12);
    set(handles.text32, 'FontSize', 10);
    set(handles.pushbutton7,'backgroundcolor',[0 0.8 0])
    set(handles.pushbutton6,'backgroundcolor',[1 0 0])
end
if (( handles.lastSliderVal==-3))
    set(handles.text24, 'FontSize', 10);
    set(handles.text25, 'FontSize', 10);
    set(handles.text26, 'FontSize', 10);
    set(handles.text33, 'FontSize', 10);
    set(handles.text23, 'FontSize', 10);
    set(handles.text22, 'FontSize', 10);
    set(handles.text32, 'FontSize', 12);
    set(handles.pushbutton7,'backgroundcolor',[0 0.5 0])
    set(handles.pushbutton6,'backgroundcolor',[0.5 0 0])
end

%% Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%% Executes on button press in vote.
function vote_Callback(hObject, eventdata, handles)
% hObject    handle to vote (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Tc = handles.Tc;
seq_name_1 = handles.seq_name_1;
seq_name_2=  handles.seq_name_2;
result = handles.result;

% Update handles structure
slidervalue=get(handles.slider1,'Value');

if slidervalue==0
    I1_Score=slidervalue;
    I2_Score=slidervalue;
end
if slidervalue<0
    I1_Score=slidervalue *(-1);
    I2_Score=slidervalue;
else
    I2_Score=slidervalue;
    I1_Score=slidervalue *(-1);
    
end
I1_Score=0+(I1_Score-(-3))*(10-0)/(3-(-3));
I2_Score=0+(I2_Score-(-3))*(10-0)/(3-(-3));
result(Tc+1,1) =num2cell(Tc);
result(Tc+1,2) = seq_name_1;
result(Tc+1,3) = seq_name_2;
result(Tc+1,4) =num2cell(I1_Score);
result(Tc+1,5) =num2cell(I2_Score);

handles.seq_name_1=[];
handles.seq_name_2=[];

Tc = Tc+1;
handles.Tc=Tc;
handles.result = result;

if Tc > handles.DataLen
    result=handles.result;
    filename = handles.filename;
    result{Tc+1,1}='Age';
    result(Tc+1,2)=num2cell(handles.fileage);
    
    xlswrite(filename,result);
    cla(handles.axes1);
    cla(handles.axes2);
    set(handles.axes1, 'Visible', 'off');
    set(handles.axes2, 'Visible', 'off');
    set(handles.InsImp, 'Visible', 'off');
    set(handles.text17, 'Visible', 'off');
    set(handles.text18, 'Visible', 'off');
    set(handles.InsOrig, 'Visible', 'off');
    set(handles.pushbutton10,'Visible', 'off')
    set(handles.finish, 'Visible', 'on');
    
else
    cla(handles.axes1);
    cla(handles.axes2);
    set(handles.axes1, 'Visible', 'off');
    set(handles.axes2, 'Visible', 'off');
    set(handles.InsImp, 'Visible', 'off');
    set(handles.text17, 'Visible', 'off');
    set(handles.text18, 'Visible', 'off');
    set(handles.InsOrig, 'Visible', 'off');
    set(handles.text37, 'Visible', 'off');
    set(handles.pushbutton10,'Visible', 'on')
    set(handles.pushbutton9, 'String', 'Start Next Task');
    set(handles.text24, 'FontSize', 12);
end
set(handles.slider1, 'Value', 0);
set(handles.pushbutton6,'backgroundcolor',[1 1 0])
set(handles.pushbutton7,'backgroundcolor',[1 1 0])
handles.lastSliderVal = get(handles.slider1,'Value'); %% whyyyy
guidata(hObject, handles);

%% Executes on slider movement.
function respondToContSlideCallback(hObject, eventdata)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% first we need the handles structure which we can get from hObject
handles = guidata(hObject);
% get the slider value and convert it to the nearest integer that is less
% than this value
newVal = floor(get(hObject,'Value'));
% set the slider value to this integer which will be in the set {1,2,3,...,12,13}
set(hObject,'Value',newVal);
% now only do something in response to the slider movement if the
% new value is different from the last slider value
if newVal ~= handles.lastSliderVal
    % it is different, so we have moved up or down from the previous integer
    % save the new value
    handles.lastSliderVal = newVal;
    guidata(hObject,handles);
    % display the current value of the slider
    %disp(['at slider value ' num2str(get(hObject,'Value'))]);
end

%% Executes on button press in playOrig.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to playOrig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Tc = handles.Tc;
data = handles.data;
set(handles.uipanel1, 'Visible', 'off');
set(handles.InsOrig, 'Visible', 'off');
set(handles.axes1, 'Visible', 'on');
set(handles.axes2, 'Visible', 'on');
set(handles.text17, 'Visible', 'on');
set(handles.text18, 'Visible', 'on');
set(handles.pushbutton10,'Visible', 'off')
handles.seq_name_1 = data{1,Tc}(1,1);
I1 = data{1,Tc}(2,1);
handles.seq_name_2= data{1,Tc}(1,2);
I2 = data{1,Tc}(2,2);
guidata(hObject, handles);

I1=cell2mat(I1);
I2=cell2mat(I2);

imshow(I1,'Parent',handles.axes1);
imshow(I2,'Parent',handles.axes2);

set(handles.axes1, 'Visible', 'off');
set(handles.axes2, 'Visible', 'off');
set(handles.InsImp, 'Visible', 'on');
set(handles.text17, 'Visible', 'on');
set(handles.text18, 'Visible', 'on');
set(handles.text22, 'Visible', 'on');
set(handles.text23, 'Visible', 'on');
set(handles.text24, 'Visible', 'on');
set(handles.text25, 'Visible', 'on');
set(handles.text26, 'Visible', 'on');
set(handles.text27, 'Visible', 'on');
set(handles.text28, 'Visible', 'on');
set(handles.text29, 'Visible', 'on');
set(handles.text30, 'Visible', 'on');
set(handles.text31, 'Visible', 'on');
uicontrol(handles.slider1);

%% Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%% Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pushbutton9_Callback(hObject, eventdata, handles)

%% 
function ageBox_Callback(hObject, eventdata, handles)
% hObject    handle to ageBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%
function ageBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ageBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%%
function nameBox_Callback(hObject, eventdata, handles)
% hObject    handle to nameBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%
function nameBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nameBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
