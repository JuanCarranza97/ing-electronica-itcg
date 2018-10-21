function varargout = xbox_one_test(varargin)
% XBOX_ONE_TEST MATLAB code for xbox_one_test.fig
%      XBOX_ONE_TEST, by itself, creates a new XBOX_ONE_TEST or raises the existing
%      singleton*.
%
%      H = XBOX_ONE_TEST returns the handle to a new XBOX_ONE_TEST or the handle to
%      the existing singleton*.
%
%      XBOX_ONE_TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in XBOX_ONE_TEST.M with the given input arguments.
%
%      XBOX_ONE_TEST('Property','Value',...) creates a new XBOX_ONE_TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before xbox_one_test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to xbox_one_test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help xbox_one_test

% Last Modified by GUIDE v2.5 20-Oct-2018 02:41:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @xbox_one_test_OpeningFcn, ...
                   'gui_OutputFcn',  @xbox_one_test_OutputFcn, ...
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


% --- Executes just before xbox_one_test is made visible.
function xbox_one_test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to xbox_one_test (see VARARGIN)

% Choose default command line output for xbox_one_test
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
img = imread('controller.jpg');
axes(handles.axes1);
imshow(img);
axis off;
controllerLibrary = NET.addAssembly([pwd '\SharpDX.XInput.dll']);
global myController
myController = SharpDX.XInput.Controller(SharpDX.XInput.UserIndex.One);
global VibrationLevel
VibrationLevel = SharpDX.XInput.Vibration;
global t
t = timer('Period',.05,'ExecutionMode','fixedRate');
t.TimerFcn = {@my_callback_fcn,handles};
start(t);
% UIWAIT makes xbox_one_test wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = xbox_one_test_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in close_button.
function close_button_Callback(hObject, eventdata, handles)
% hObject    handle to close_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VibrationLevel
global myController
VibrationLevel.LeftMotorSpeed = 0;
myController.SetVibration(VibrationLevel);
global t
stop(t);
close()

function my_callback_fcn(obj, event,handles)
global myController
State = myController.GetState();
global VibrationLevel
VibrationLevel.LeftMotorSpeed = double(State.Gamepad.LeftTrigger)*255;
myController.SetVibration(VibrationLevel);
ButtonStates = ButtonStateParser(State.Gamepad.Buttons);

%text=convertCharsToStrings(get(handles.edit1,'String'));
set(handles.edit1,'String',strcat("LeftThumbX: ",num2str(State.Gamepad.LeftThumbX)));
set(handles.text2,'String',strcat("LeftThumbY: ",num2str(State.Gamepad.LeftThumbY)));
set(handles.text3,'String',strcat("RightThumbX: ",num2str(State.Gamepad.RightThumbX)));
set(handles.text4,'String',strcat("RightThumbY: ",num2str(State.Gamepad.RightThumbY)));
set(handles.text5,'String',strcat("LeftTrigger: ",num2str(State.Gamepad.LeftTrigger)));
set(handles.text6,'String',strcat("RightTrigger: ",num2str(State.Gamepad.RightTrigger)));
set(handles.text7,'String',strcat("Y: ",num2str(ButtonStates.Y)));
set(handles.text8,'String',strcat("B: ",num2str(ButtonStates.B)));
set(handles.text9,'String',strcat("A: ",num2str(ButtonStates.A)));
set(handles.text10,'String',strcat("X: ",num2str(ButtonStates.X)));
set(handles.text11,'String',strcat("DPadUp: ",num2str(ButtonStates.DPadUp)));
set(handles.text12,'String',strcat("DadRight: ",num2str(ButtonStates.DPadRight)));
set(handles.text13,'String',strcat("DPadDown: ",num2str(ButtonStates.DPadDown)));
set(handles.text14,'String',strcat("DPadLeft: ",num2str(ButtonStates.DPadLeft)));
set(handles.text15,'String',strcat("Back: ",num2str(ButtonStates.Back)));
set(handles.text16,'String',strcat("Start: ",num2str(ButtonStates.Start)));
set(handles.text17,'String',strcat("LeftBumper: ",num2str(ButtonStates.LeftBumper)));
set(handles.text18,'String',strcat("RightBumper: ",num2str(ButtonStates.RightBumper)));
set(handles.text19,'String',strcat("LeftStick: ",num2str(ButtonStates.LeftStick)));
set(handles.text20,'String',strcat("RightStick: ",num2str(ButtonStates.RightStick)));


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
