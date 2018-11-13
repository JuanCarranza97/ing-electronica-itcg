function varargout = main_guide(varargin)
% MAIN_GUIDE MATLAB code for main_guide.fig
%      MAIN_GUIDE, by itself, creates a new MAIN_GUIDE or raises the existing
%      singleton*.
%
%      H = MAIN_GUIDE returns the handle to a new MAIN_GUIDE or the handle to
%      the existing singleton*.
%
%      MAIN_GUIDE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_GUIDE.M with the given input arguments.
%
%      MAIN_GUIDE('Property','Value',...) creates a new MAIN_GUIDE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_guide_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_guide_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main_guide

% Last Modified by GUIDE v2.5 11-Nov-2018 20:12:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_guide_OpeningFcn, ...
                   'gui_OutputFcn',  @main_guide_OutputFcn, ...
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


% --- Executes just before main_guide is made visible.
function main_guide_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main_guide (see VARARGIN)

% Choose default command line output for main_guide
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
run clear_serial_port.m
global arrob_serie
com_port = getappdata(0,'com_port');
arrob_serie = serial(com_port,'BaudRate',115200);
arrob_serie.BytesAvailableFcnMode = 'terminator';
arrob_serie.BytesAvailableFcn = @arrob_serial_complete;
fprintf("Initializing ARROB ...\n");
f = waitbar(.5,strcat({'Connecting to '},{com_port},{' ...'}));
fopen(arrob_serie);   
waitbar(1,f,'Done B) ');
setappdata(0,'arrob_serie',arrob_serie);
pause(1.5);
close(f);
fprintf("Done B)\n");
% UIWAIT makes main_guide wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function arrob_serial_complete(obj,event)
fprintf("Interrupcion ..\n");

% --- Outputs from this function are returned to the command line.
function varargout = main_guide_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in settings_butotn.
function settings_butotn_Callback(hObject, eventdata, handles)
% hObject    handle to settings_butotn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run settings_guide.m


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run forward_kinematics.m


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run inverse_kinematic_gui.m
