function varargout = forward_kinematics(varargin)
% FORWARD_KINEMATICS MATLAB code for forward_kinematics.fig
%      FORWARD_KINEMATICS, by itself, creates a new FORWARD_KINEMATICS or raises the existing
%      singleton*.
%
%      H = FORWARD_KINEMATICS returns the handle to a new FORWARD_KINEMATICS or the handle to
%      the existing singleton*.
%
%      FORWARD_KINEMATICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FORWARD_KINEMATICS.M with the given input arguments.
%
%      FORWARD_KINEMATICS('Property','Value',...) creates a new FORWARD_KINEMATICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before forward_kinematics_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to forward_kinematics_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help forward_kinematics

% Last Modified by GUIDE v2.5 27-Oct-2018 04:01:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @forward_kinematics_OpeningFcn, ...
                   'gui_OutputFcn',  @forward_kinematics_OutputFcn, ...
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


% --- Executes just before forward_kinematics is made visible.
function forward_kinematics_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to forward_kinematics (see VARARGIN)

% Choose default command line output for forward_kinematics
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
view(50,25)
update_arrob(handles);
set(handles.text8,'String',round(get(handles.slider1,'value')));
set(handles.text9,'String',round(get(handles.slider2,'value')));
set(handles.text10,'String',round(get(handles.slider3,'value')));
set(handles.text11,'String',round(get(handles.slider4,'value')));
set(handles.text12,'String',round(get(handles.slider5,'value')));
set(handles.text13,'String',round(get(handles.slider6,'value')));
% UIWAIT makes forward_kinematics wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global arrob_serie
try
    fopen(arrob_serie)
end
arrob_serie.BytesAvailableFcn = {@arrob_serial_complete_kinematic,handles};
%read_values(handles)

controllerLibrary = NET.addAssembly([pwd '\SharpDX.XInput.dll']);
global myController
myController = SharpDX.XInput.Controller(SharpDX.XInput.UserIndex.One);
global VibrationLevel
VibrationLevel = SharpDX.XInput.Vibration;
global t
t = timer('Period',.05,'ExecutionMode','fixedSpacing');
t.TimerFcn = {@my_callback_fcn_kinematics,handles};
start(t);

% --- Outputs from this function are returned to the command line.
function varargout = forward_kinematics_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
update_arrob(handles)
set(handles.text8,'String',get(handles.slider1,'value'));

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
update_arrob(handles)
set(handles.text9,'String',get(handles.slider2,'value'));

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
update_arrob(handles)
set(handles.text10,'String',get(handles.slider3,'value'));

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
update_arrob(handles)
set(handles.text11,'String',get(handles.slider4,'value'));

% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
update_arrob(handles)
set(handles.text12,'String',get(handles.slider5,'value'));

% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
update_arrob(handles)
set(handles.text13,'String',get(handles.slider6,'value'));

% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function update_arrob(handles)
    axes(handles.axes1);
    draw_arrob([get(handles.slider1,'value') get(handles.slider2,'value') get(handles.slider3,'value') get(handles.slider4,'value') get(handles.slider5,'value')]);

function arrob_serial_complete(hObject,event,handles)
global arrob_serie
input = fgetl(arrob_serie);
size_i = size(input);
size_i = size_i(2);
input = input(1:size_i-1);

pattern = '[A-Za-z][-]?[0-9]+([,][-]?[0-9]+)*$';
try
dof = num2str(get(handles.pop_selected_dof,'Value')-1);

if size(regexp(input,pattern,'match')) == 1 %%Si la expression es correcta
    character = input(1);
    input = erase(input,character);
    numbers_str=split(input,',');
    
    n_size = size(numbers_str);
    n_size = n_size(1);
    
    numbers=[];
    for i=1:n_size
        numbers(i) = str2double(char(numbers_str(i)));
    end
    
    switch character
        case 'e'
            if numbers(1) ~= 0
                fprintf("Error: %d\n",numbers(1));
            end
        case 'p'
            if (numbers(1) == str2num(dof)) && (n_size == 3)
                if numbers(2) == 0
                    set(handles.position_input,'String',num2str(numbers(3)));
                else
                    set(handles.map_position_input,'String',num2str(numbers(3)));
                end
            end
        otherwise
            fprintf("No spected");
    end  
else
        fprintf("No coincide\n %s\n",input);
       
end
end

function my_callback_fcn_kinematics(obj, event,handles)
global myController;
global arrob_serie;
State = myController.GetState();
global VibrationLevel;

[keys,buttons] = update_buttons();
if keys == 1
    try
        if buttons.DPadRight == 1
            fprintf("DPad Right\n");
            
            while buttons.DPadRight == 1
                [keys,buttons] = update_buttons();
            end
        elseif buttons.DPadLeft == 1
            fprintf("DPad Left\n");
            while buttons.DPadLeft == 1
                [keys,buttons] = update_buttons();
            end
        elseif buttons.Back == 1
            fprintf("Preparing to close...\n");
            while buttons.Back == 1
                [keys,buttons] = update_buttons();
            end
            fprintf("Closing...\n");
            closing();
        elseif buttons.DPadUp == 1
            fprintf("DPad Up\n");
            while buttons.DPadUp == 1
                [keys,buttons] = update_buttons();
            end
        elseif buttons.DPadDown == 1
            fprintf("DPad Down\n");
            while buttons.DPadDown == 1
                [keys,buttons] = update_buttons();
            end
        elseif buttons.A == 1
            fprintf("A\n");
        elseif buttons.X == 1
            fprintf("X\n"); 
        elseif buttons.LeftBumper == 1
            fprintf("Left Bumper\n");  
        elseif buttons.RightBumper == 1
            fprintf("Right Bumper\n");    
        elseif buttons.Start == 1
            fprintf("Start\n");
            while buttons.Start == 1
                [keys,buttons] = update_buttons();
            end
        elseif buttons.LeftStick == 1
            fprintf("LeftStick\n");
            while buttons.LeftStick == 1
                [keys,buttons] = update_buttons();
            end
        elseif buttons.RightStick == 1
            fprintf("Right Stick\n");
            while buttons.RightStick == 1
                [keys,buttons] = update_buttons();
            end
        elseif buttons.B == 1
             fprintf("B\n");
             while buttons.B == 1
                [keys,buttons] = update_buttons();
             end
        elseif buttons.Y == 1
            fprintf("Y\n");
            while buttons.Y == 1
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

function closing()
global VibrationLevel
global myController
VibrationLevel.LeftMotorSpeed = 0;
myController.SetVibration(VibrationLevel);
global t
stop(t);
close();
