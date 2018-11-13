function varargout = inverse_kinematic_gui(varargin)
% INVERSE_KINEMATIC_GUI MATLAB code for inverse_kinematic_gui.fig
%      INVERSE_KINEMATIC_GUI, by itself, creates a new INVERSE_KINEMATIC_GUI or raises the existing
%      singleton*.
%
%      H = INVERSE_KINEMATIC_GUI returns the handle to a new INVERSE_KINEMATIC_GUI or the handle to
%      the existing singleton*.
%
%      INVERSE_KINEMATIC_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INVERSE_KINEMATIC_GUI.M with the given input arguments.
%
%      INVERSE_KINEMATIC_GUI('Property','Value',...) creates a new INVERSE_KINEMATIC_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before inverse_kinematic_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to inverse_kinematic_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help inverse_kinematic_gui

% Last Modified by GUIDE v2.5 12-Nov-2018 22:33:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @inverse_kinematic_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @inverse_kinematic_gui_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before inverse_kinematic_gui is made visible.
function inverse_kinematic_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to inverse_kinematic_gui (see VARARGIN)

% Choose default command line output for inverse_kinematic_gui
handles.output = hObject;
axes(handles.axes1);
rotate3d on;
update_robot(handles);
global selected_menu
global last_pos
last_pos = [ 0 0 0];
selected_menu = 0;
global arrob_serie
global incremento
incremento = 0;
try
    fopen(arrob_serie)
end

controllerLibrary = NET.addAssembly([pwd '\SharpDX.XInput.dll']);
global myController
myController = SharpDX.XInput.Controller(SharpDX.XInput.UserIndex.One);
global VibrationLevel
VibrationLevel = SharpDX.XInput.Vibration;
global t
t = timer('Period',.05,'ExecutionMode','fixedSpacing');
t.TimerFcn = {@my_callback_fcn,handles};
start(t);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes inverse_kinematic_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = inverse_kinematic_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function value_x_Callback(hObject, eventdata, handles)
% hObject    handle to value_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
update_robot(handles)
% Hints: get(hObject,'String') returns contents of value_x as text
%        str2double(get(hObject,'String')) returns contents of value_x as a double


% --- Executes during object creation, after setting all properties.
function value_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to value_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function value_y_Callback(hObject, eventdata, handles)
% hObject    handle to value_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of value_y as text
%        str2double(get(hObject,'String')) returns contents of value_y as a double
update_robot(handles)

% --- Executes during object creation, after setting all properties.
function value_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to value_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function maped = map_function(x,in_min,in_max,out_min,out_max)
%long map(long x, long in_min, long in_max, long out_min, long out_max){
%  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
%}
maped = (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;

function value_z_Callback(hObject, eventdata, handles)
% hObject    handle to value_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of value_z as text
%        str2double(get(hObject,'String')) returns contents of value_z as a double
update_robot(handles)

% --- Executes during object creation, after setting all properties.
function value_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to value_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function tcp_angle_Callback(hObject, eventdata, handles)
% hObject    handle to tcp_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
update_robot(handles)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function tcp_angle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tcp_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function update_robot(handles)
global last_pos
global arrob_serie
x = str2double(get(handles.value_x,'String'));
y = str2double(get(handles.value_y,'String'));
z = str2double(get(handles.value_z,'String'));

axes(handles.axes1);

tcp_theta=get(handles.tcp_angle,'Value');

set(handles.text5,'String',strcat("TCP angle=",num2str(tcp_theta)));
[pos,alpha,theta_arriba] = inverse_kinematic_arrob([x,y,z],tcp_theta);

diffx = abs(x)-abs(pos(1));
diffy = abs(y)-abs(pos(2));
diffz = abs(z)-abs(pos(3));
alpha
theta_arriba

if (diffx > -3 && diffx < 3) && (diffy > -3 && diffy < 3) && (diffz > -3 && diffz < 3)
    last_pos = [x y z];
    fprintf(arrob_serie,strcat("p0,1,",num2str(round(alpha))));  %WAIST
    fprintf(arrob_serie,strcat("p1,1,",num2str(round(theta_arriba(1))))); %SHOULDER 1
    fprintf(arrob_serie,strcat("p3,1,",num2str(round(theta_arriba(2))))); %ELBOW
    fprintf(arrob_serie,strcat("p4,1,",num2str(round(theta_arriba(2))))); %PREDOLL
else
    fprintf("Error pos 2\n");
    set(handles.value_x,'String',num2str(last_pos(1)));
    set(handles.value_y,'String',num2str(last_pos(2)));
    set(handles.value_z,'String',num2str(last_pos(3)));
    pos = inverse_kinematic_arrob([last_pos(1) last_pos(2) last_pos(3)],tcp_theta);
end


% --- Executes on button press in subtract_x.
function subtract_x_Callback(hObject, eventdata, handles)
% hObject    handle to subtract_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = str2double(get(handles.value_x,'String'));
increment = str2double(get(handles.increment_x,'String'));
x = x-increment;
set(handles.value_x,'String',x);
update_robot(handles);

% --- Executes on button press in add_x.
function add_x_Callback(hObject, eventdata, handles)
% hObject    handle to add_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = str2double(get(handles.value_x,'String'));
increment = str2double(get(handles.increment_x,'String'));
x = x+increment;
set(handles.value_x,'String',x);
update_robot(handles);

% --- Executes on button press in subtract_y.
function subtract_y_Callback(hObject, eventdata, handles)
% hObject    handle to subtract_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
y= str2double(get(handles.value_y,'String'));
increment = str2double(get(handles.increment_y,'String'));
y = y-increment;
set(handles.value_y,'String',y);
update_robot(handles);

% --- Executes on button press in add_y.
function add_y_Callback(hObject, eventdata, handles)
% hObject    handle to add_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
y= str2double(get(handles.value_y,'String'));
increment = str2double(get(handles.increment_y,'String'));
y = y+increment;
set(handles.value_y,'String',y);
update_robot(handles);

% --- Executes on button press in subtract_z.
function subtract_z_Callback(hObject, eventdata, handles)
% hObject    handle to subtract_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
z= str2double(get(handles.value_z,'String'));
increment = str2double(get(handles.increment_z,'String'));
z = z-increment;
set(handles.value_z,'String',z);
update_robot(handles);

% --- Executes on button press in add_z.
function add_z_Callback(hObject, eventdata, handles)
% hObject    handle to add_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
z= str2double(get(handles.value_z,'String'));
increment = str2double(get(handles.increment_z,'String'));
z = z+increment;
set(handles.value_z,'String',z);
update_robot(handles);

function my_callback_fcn(obj, event,handles)
global myController;
global arrob_serie;
State = myController.GetState();
global VibrationLevel;
global selected_menu

%global VibrationLevel
%VibrationLevel.LeftMotorSpeed = double(State.Gamepad.LeftTrigger)*255;
%myController.SetVibration(VibrationLevel);
%ButtonStates = ButtonStateParser(State.Gamepad.Buttons);
global incremento

if State.Gamepad.LeftTrigger > 50
    incremento=round(map_function(double(State.Gamepad.LeftTrigger),50,255,1,-10));
    add_value(handles,selected_menu,incremento);
    update_robot(handles);

elseif State.Gamepad.RightTrigger > 50
    incremento=round(map_function(double(State.Gamepad.RightTrigger),50,255,1,10));
    add_value(handles,selected_menu,incremento);
    update_robot(handles);
else
    incremento = 0;
end
        
[keys,buttons] = update_buttons();
if keys == 1
    try
        if buttons.RightBumper
            selected_menu = selected_menu+1;
            if selected_menu > 3
                selected_menu=0;
            end
            fprintf("Modificando el valor del menu a %d \n",selected_menu);
            while buttons.RightBumper
                [keys,buttons] = update_buttons();
            end
        elseif buttons.LeftBumper
             selected_menu = selected_menu-1;
             if selected_menu < 0
                 selected_menu = 3;
             end
            fprintf("Modificando el valor del menu a %d \n",selected_menu);
            while buttons.LeftBumper
                [keys,buttons] = update_buttons();
            end                   
        end
    end
else
    VibrationLevel.LeftMotorSpeed = 0;
    VibrationLevel.RightMotorSpeed = 0;
    myController.SetVibration(VibrationLevel);
end
    
function [keys_pressed,ButtonStates] = update_buttons()
global myController
State = myController.GetState();
ButtonStates = ButtonStateParser(State.Gamepad.Buttons);
buttons = struct2array(ButtonStates);
keys_pressed = 0;
for i = buttons
    if i
        keys_pressed=keys_pressed+1;
    end        
end

function add_value(handles,pos,val)

switch pos
    case 0
        x = str2double(get(handles.value_x,'String'));
        x = x+val;
        set(handles.value_x,'String',x);
    case 1
        y = str2double(get(handles.value_y,'String'));
        y = y+val;
        set(handles.value_y,'String',y);
    case 2
        z = str2double(get(handles.value_z,'String'));
        z = z+val;
        set(handles.value_z,'String',z);
    case 3
        tcp_theta=get(handles.tcp_angle,'Value');
        tcp_theta = tcp_theta+val;
        set(handles.tcp_angle,'Value',tcp_theta);
end
update_robot(handles);
        


% --- Executes on button press in subtract_tcp.
function subtract_tcp_Callback(hObject, eventdata, handles)
% hObject    handle to subtract_tcp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tcp= get(handles.tcp_angle,'Value');
tcp = tcp-1;
set(handles.tcp_angle,'Value',tcp);
update_robot(handles);

% --- Executes on button press in add_tcp.
function add_tcp_Callback(hObject, eventdata, handles)
% hObject    handle to add_tcp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tcp= get(handles.tcp_angle,'Value');
tcp = tcp+1;
set(handles.tcp_angle,'Value',tcp);
update_robot(handles);



function increment_x_Callback(hObject, eventdata, handles)
% hObject    handle to increment_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of increment_x as text
%        str2double(get(hObject,'String')) returns contents of increment_x as a double


% --- Executes during object creation, after setting all properties.
function increment_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to increment_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function increment_y_Callback(hObject, eventdata, handles)
% hObject    handle to increment_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of increment_y as text
%        str2double(get(hObject,'String')) returns contents of increment_y as a double


% --- Executes during object creation, after setting all properties.
function increment_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to increment_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function increment_z_Callback(hObject, eventdata, handles)
% hObject    handle to increment_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of increment_z as text
%        str2double(get(hObject,'String')) returns contents of increment_z as a double


% --- Executes during object creation, after setting all properties.
function increment_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to increment_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in close_button.
function close_button_Callback(hObject, eventdata, handles)
% hObject    handle to close_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(inverse_kinematic_gui)
