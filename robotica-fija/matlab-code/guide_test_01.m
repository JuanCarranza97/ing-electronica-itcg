function varargout = guide_test_01(varargin)
% GUIDE_TEST_01 MATLAB code for guide_test_01.fig
%      GUIDE_TEST_01, by itself, creates a new GUIDE_TEST_01 or raises the existing
%      singleton*.
%
%      H = GUIDE_TEST_01 returns the handle to a new GUIDE_TEST_01 or the handle to
%      the existing singleton*.
%
%      GUIDE_TEST_01('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIDE_TEST_01.M with the given input arguments.
%
%      GUIDE_TEST_01('Property','Value',...) creates a new GUIDE_TEST_01 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guide_test_01_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guide_test_01_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guide_test_01

% Last Modified by GUIDE v2.5 30-Sep-2018 02:52:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guide_test_01_OpeningFcn, ...
                   'gui_OutputFcn',  @guide_test_01_OutputFcn, ...
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

% --- Executes just before guide_test_01 is made visible.
function guide_test_01_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guide_test_01 (see VARARGIN)
fprintf("Initializing ARROB ...\n");
global arrob_serie
arrob_serie = serial('COM14','BaudRate',115200);
arrob_serie.BytesAvailableFcnMode = 'terminator';
arrob_serie.BytesAvailableFcn = @arrob_serial_complete;
fopen(arrob_serie);     
fprintf("Done B)\n");
% Choose default command line output for guide_test_01
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes guide_test_01 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
function arrob_serial_complete(obj,event)
fprintf("Interrupcion ..\n");

% --- Outputs from this function are returned to the command line.
function varargout = guide_test_01_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arrob_serie
fprintf(arrob_serie,"a1");


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arrob_serie
fprintf(arrob_serie,"a0");


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arrob_serie
fclose(arrob_serie);
delete(arrob_serie);
fprintf("Serial close\n")
close()
