function varargout = settings_guide(varargin)
% SETTINGS_GUIDE MATLAB code for settings_guide.fig
%      SETTINGS_GUIDE, by itself, creates a new SETTINGS_GUIDE or raises the existing
%      singleton*.
%
%      H = SETTINGS_GUIDE returns the handle to a new SETTINGS_GUIDE or the handle to
%      the existing singleton*.
%
%      SETTINGS_GUIDE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SETTINGS_GUIDE.M with the given input arguments.
%
%      SETTINGS_GUIDE('Property','Value',...) creates a new SETTINGS_GUIDE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before settings_guide_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to settings_guide_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help settings_guide

% Last Modified by GUIDE v2.5 21-Oct-2018 11:26:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @settings_guide_OpeningFcn, ...
                   'gui_OutputFcn',  @settings_guide_OutputFcn, ...
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


% --- Executes just before settings_guide is made visible.
function settings_guide_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to settings_guide (see VARARGIN)

% Choose default command line output for settings_guide
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global arrob_serie
try
    fopen(arrob_serie)
end
arrob_serie.BytesAvailableFcn = {@arrob_serial_complete,handles};
read_values(handles)

controllerLibrary = NET.addAssembly([pwd '\SharpDX.XInput.dll']);
global myController
myController = SharpDX.XInput.Controller(SharpDX.XInput.UserIndex.One);
global VibrationLevel
VibrationLevel = SharpDX.XInput.Vibration;
global t
t = timer('Period',.05,'ExecutionMode','fixedSpacing');
t.TimerFcn = {@my_callback_fcn,handles};
start(t);


% UIWAIT makes settings_guide wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = settings_guide_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in pop_selected_dof.
function pop_selected_dof_Callback(hObject, eventdata, handles)
% hObject    handle to pop_selected_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_selected_dof contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_selected_dof
read_values(handles)


% --- Executes during object creation, after setting all properties.
function pop_selected_dof_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_selected_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in read_button.
function read_button_Callback(hObject, eventdata, handles)
% hObject    handle to read_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arrob_serie
fprintf(arrob_serie,"e0");
pause(.25)
read_values(handles)


% --- Executes on button press in save_button.
function save_button_Callback(hObject, eventdata, handles)
% hObject    handle to save_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arrob_serie
fprintf(arrob_serie,"e1");

% --- Executes on button press in close_button.
function close_button_Callback(hObject, eventdata, handles)
% hObject    handle to close_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closing()

% --- Executes on button press in test_button.
function test_button_Callback(hObject, eventdata, handles)
% hObject    handle to test_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arrob_serie
dof = num2str(get(handles.pop_selected_dof,'Value')-1);
fprintf(arrob_serie,strcat("t",dof,",10"));


function input_servo_pin_Callback(hObject, eventdata, handles)
% hObject    handle to input_servo_pin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_servo_pin as text
%        str2double(get(hObject,'String')) returns contents of input_servo_pin as a double
global arrob_serie
dof = num2str(get(handles.pop_selected_dof,'Value')-1);
setting = get(handles.input_servo_pin,'String');
fprintf(arrob_serie,strcat("s",dof,",0,",setting));

% --- Executes during object creation, after setting all properties.
function input_servo_pin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_servo_pin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function min_signal_input_Callback(hObject, eventdata, handles)
% hObject    handle to min_signal_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of min_signal_text as text
%        str2double(get(hObject,'String')) returns contents of min_signal_text as a double
global arrob_serie
dof = num2str(get(handles.pop_selected_dof,'Value')-1);
setting = get(handles.min_signal_input,'String');
fprintf(arrob_serie,strcat("s",dof,",2,",setting));


% --- Executes during object creation, after setting all properties.
function min_signal_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min_signal_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function max_signal_input_Callback(hObject, eventdata, handles)
% hObject    handle to max_signal_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_signal_input as text
%        str2double(get(hObject,'String')) returns contents of max_signal_input as a double
global arrob_serie
dof = num2str(get(handles.pop_selected_dof,'Value')-1);
setting = get(handles.max_signal_input,'String');
fprintf(arrob_serie,strcat("s",dof,",1,",setting));


% --- Executes during object creation, after setting all properties.
function max_signal_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_signal_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function home_degree_input_Callback(hObject, eventdata, handles)
% hObject    handle to home_degree_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of home_degree_input as text
%        str2double(get(hObject,'String')) returns contents of home_degree_input as a double
global arrob_serie
dof = num2str(get(handles.pop_selected_dof,'Value')-1);
setting = get(handles.home_degree_input,'String');
fprintf(arrob_serie,strcat("s",dof,",5,",setting));


% --- Executes during object creation, after setting all properties.
function home_degree_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to home_degree_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function min_degree_input_Callback(~, eventdata, handles)
% hObject    handle to min_degree_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of min_degree_input as text
%        str2double(get(hObject,'String')) returns contents of min_degree_input as a double
global arrob_serie
dof = num2str(get(handles.pop_selected_dof,'Value')-1);
setting = get(handles.min_degree_input,'String');
fprintf(arrob_serie,strcat("s",dof,",4,",setting));


% --- Executes during object creation, after setting all properties.
function min_degree_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min_degree_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function min_signal_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min_degree_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function max_degree_input_Callback(hObject, eventdata, handles)
% hObject    handle to max_degree_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_degree_input as text
%        str2double(get(hObject,'String')) returns contents of max_degree_input as a double
global arrob_serie
dof = num2str(get(handles.pop_selected_dof,'Value')-1);
setting = get(handles.max_degree_input,'String');
fprintf(arrob_serie,strcat("s",dof,",3,",setting));


% --- Executes during object creation, after setting all properties.
function max_degree_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_degree_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in attach_button.
function attach_button_Callback(hObject, eventdata, handles)
% hObject    handle to attach_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arrob_serie
dof = num2str(get(handles.pop_selected_dof,'Value')-1);
fprintf(arrob_serie,strcat("d",dof,",1"));
set(handles.state,'String','ATTACHED');

% --- Executes on button press in detach_button.
function detach_button_Callback(hObject, eventdata, handles)
% hObject    handle to detach_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arrob_serie
dof = num2str(get(handles.pop_selected_dof,'Value')-1);
fprintf(arrob_serie,strcat("d",dof,",0"));
set(handles.state,'String','DETACHED');

function position_input_Callback(hObject, eventdata, handles)
% hObject    handle to position_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arrob_serie
dof = num2str(get(handles.pop_selected_dof,'Value')-1);
degree = get(handles.position_input,'String');
%%fprintf(strcat("p",dof,",0,",degree+"\n"));
fprintf(arrob_serie,strcat("p",dof,",0,",degree));
% Hints: get(hObject,'String') returns contents of position_input as text
%        str2double(get(hObject,'String')) returns contents of position_input as a double


% --- Executes during object creation, after setting all properties.
function position_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to position_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function map_position_input_Callback(hObject, eventdata, handles)
% hObject    handle to map_position_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of map_position_input as text
%        str2double(get(hObject,'String')) returns contents of map_position_input as a double
global arrob_serie
dof = num2str(get(handles.pop_selected_dof,'Value')-1);
degree = get(handles.map_position_input,'String');
%fprintf(strcat("p",dof,",1,",degree+"\n"));
fprintf(arrob_serie,strcat("p",dof,",1,",degree));

% --- Executes during object creation, after setting all properties.
function map_position_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to map_position_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arrob_serie
dof = num2str(get(handles.pop_selected_dof,'Value')-1);
degree = get(handles.position_input,'String');
set(handles.max_signal_input,'String',degree);
fprintf(arrob_serie,strcat("s",dof,",1,",degree));

% --- Executes on button press in min_signal_button.
function min_signal_button_Callback(hObject, eventdata, handles)
% hObject    handle to min_signal_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arrob_serie
global dof 
dof = num2str(get(handles.pop_selected_dof,'Value')-1);
degree = get(handles.position_input,'String');
set(handles.min_signal_input,'String',degree);
fprintf(arrob_serie,strcat("s",dof,",2,",degree));
fprintf(arrob_serie,strcat("r",dof,",",num2str(6)));

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
        numbers(i) = str2num(char(numbers_str(i)));
    end
    
    switch character
        case 'v'
            if (numbers(1) == str2num(dof)) && (n_size == 3)
                switch numbers(2)
                    case 0
                        set(handles.input_servo_pin,'String',num2str(numbers(3)));
                    case 1
                        set(handles.max_signal_input,'String',num2str(numbers(3)));
                    case 2
                        set(handles.min_signal_input,'String',num2str(numbers(3)));
                    case 3
                        set(handles.max_degree_input,'String',num2str(numbers(3)));
                    case 4
                        set(handles.min_degree_input,'String',num2str(numbers(3)));
                    case 5
                        set(handles.home_degree_input,'String',num2str(numbers(3)));
                end
            end
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
        case 'd'
            if (numbers(1) == str2num(dof)) && (n_size == 2)
                if numbers(2) == 0
                    set(handles.state,'String','DETACHED');
                else
                    set(handles.state,'String','ATTACHED');
                end
            end
        otherwise
            fprintf("No spected");
    end  
else
        fprintf("No coincide\n %s\n",input);
       
end
end
%%fprintf("Interrupcion .. 2\n");
%fprintf(strcat(input,"\n"));

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arrob_serie
dof = num2str(get(handles.pop_selected_dof,'Value')-1);
degree = get(handles.map_position_input,'String');
set(handles.home_degree_input,'String',degree);
fprintf(arrob_serie,strcat("s",dof,",5,",degree));

function my_callback_fcn(obj, event,handles)
global myController
global arrob_serie
State = myController.GetState();
global VibrationLevel
%global VibrationLevel
%VibrationLevel.LeftMotorSpeed = double(State.Gamepad.LeftTrigger)*255;
%myController.SetVibration(VibrationLevel);
%ButtonStates = ButtonStateParser(State.Gamepad.Buttons);

[keys,buttons] = update_buttons();
if keys == 1
    try
        if buttons.DPadRight == 1
            dof = get(handles.pop_selected_dof,'Value');
            dof = dof+1;
            if dof == 8
                dof=1;
            end

            set(handles.pop_selected_dof,'Value',dof);       
            read_values(handles)  %%
            
            while buttons.DPadRight == 1
                [keys,buttons] = update_buttons();
            end
        elseif buttons.DPadLeft == 1
            dof = get(handles.pop_selected_dof,'Value');
            dof = dof-1;
            if dof == 0
                dof=7;
            end

            set(handles.pop_selected_dof,'Value',dof);       
            read_values(handles)
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
            dof = num2str(get(handles.pop_selected_dof,'Value')-1);
            fprintf(arrob_serie,strcat("d",dof,",1"));
            set(handles.state,'String','ATTACHED');
        elseif buttons.DPadDown == 1
            dof = num2str(get(handles.pop_selected_dof,'Value')-1);
            fprintf(arrob_serie,strcat("d",dof,",0"));
            set(handles.state,'String','DETACHED');
        elseif buttons.A == 1
            dof = num2str(get(handles.pop_selected_dof,'Value')-1);
            min_degree=str2double(get(handles.min_degree_input,'String'));
            max_degree=str2double(get(handles.max_degree_input,'String'));
            LeftTrigger = round(map_function(double(State.Gamepad.LeftThumbY),-32768,32767,min_degree,max_degree));
            fprintf(arrob_serie,strcat("p",dof,",1,",num2str(LeftTrigger)));
        elseif buttons.X == 1
            dof = num2str(get(handles.pop_selected_dof,'Value')-1);
            min_signal=str2double(get(handles.min_signal_input,'String'));
            max_signal=str2double(get(handles.max_signal_input,'String'));
            if min_signal < max_signal
                min_signal = min_signal-20;
                max_signal = max_signal+20;
                position = round(map_function(double(State.Gamepad.LeftThumbY),-32768,32767,min_signal,max_signal));
            else
                min_signal = min_signal+20;
                max_signal = max_signal-20;
                position = round(map_function(double(State.Gamepad.LeftThumbY),-32768,32767,min_signal,max_signal));              
            end
            if(position < 0)               
                VibrationLevel.LeftMotorSpeed = 65000;
                VibrationLevel.RightMotorSpeed = 65000;
                myController.SetVibration(VibrationLevel);
                fprintf("Servo was not capable to set %d position\n",position);
                position=0;
            elseif position > 180
                VibrationLevel.LeftMotorSpeed = 65000;
                VibrationLevel.RightMotorSpeed = 65000;
                myController.SetVibration(VibrationLevel);
                fprintf("Servo was not capable to set %d position\n",position);
                position=180;
            else
                VibrationLevel.LeftMotorSpeed = 0;
                VibrationLevel.RightMotorSpeed = 0;
                myController.SetVibration(VibrationLevel);
            end
            
            fprintf(arrob_serie,strcat("p",dof,",0,",num2str(position)));  
        elseif buttons.LeftBumper == 1
            dof = num2str(get(handles.pop_selected_dof,'Value')-1);
            degree = get(handles.position_input,'String');
            set(handles.min_signal_input,'String',degree);
            fprintf(arrob_serie,strcat("s",dof,",2,",degree));
            fprintf(arrob_serie,strcat("r",dof,",",num2str(6)));  
        elseif buttons.RightBumper == 1
            dof = num2str(get(handles.pop_selected_dof,'Value')-1);
            degree = get(handles.position_input,'String');
            set(handles.max_signal_input,'String',degree);
            fprintf(arrob_serie,strcat("s",dof,",1,",degree));    
        elseif buttons.Start == 1
            dof = num2str(get(handles.pop_selected_dof,'Value')-1);
            fprintf(arrob_serie,strcat("t",dof,",10"));
            while buttons.Start == 1
                [keys,buttons] = update_buttons();
            end
        elseif buttons.LeftStick == 1
            dof = num2str(get(handles.pop_selected_dof,'Value')-1);
            degree = get(handles.map_position_input,'String');
            set(handles.home_degree_input,'String',degree);
            fprintf(arrob_serie,strcat("s",dof,",5,",degree)); 
            while buttons.LeftStick == 1
                [keys,buttons] = update_buttons();
            end
        elseif buttons.RightStick == 1
            dof = num2str(get(handles.pop_selected_dof,'Value')-1);
            fprintf(arrob_serie,strcat("h",dof,",10"));
            while buttons.RightStick == 1
                [keys,buttons] = update_buttons();
            end
        elseif buttons.B == 1
            fprintf(arrob_serie,"e0");
            read_values(handles)
            dof = num2str(get(handles.pop_selected_dof,'Value')-1);
            fprintf(arrob_serie,strcat("h",dof,",10")); 
             while buttons.B == 1
                [keys,buttons] = update_buttons();
             end
        elseif buttons.Y == 1
            fprintf(arrob_serie,"e1");
            read_values(handles)
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
% buttons = struct2array(ButtonStates);
% num = 0;
% for i = buttons
%     if i
%         num=num+1;
%     end        
% end


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
close(settings_guide)

function read_values(handles)
global arrob_serie
dof = num2str(get(handles.pop_selected_dof,'Value')-1);
for i = 0:8
    fprintf(arrob_serie,strcat("r",dof,",",num2str(i)));
    pause(.01);
end

function maped = map_function(x,in_min,in_max,out_min,out_max)
%long map(long x, long in_min, long in_max, long out_min, long out_max){
%  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
%}
maped = (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;


% --- Executes on button press in go_home_button.
function go_home_button_Callback(hObject, eventdata, handles)
% hObject    handle to go_home_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arrob_serie
dof = num2str(get(handles.pop_selected_dof,'Value')-1);
fprintf(arrob_serie,strcat("h",dof,",10"));
