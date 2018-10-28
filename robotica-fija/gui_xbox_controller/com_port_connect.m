function varargout = com_port_connect(varargin)
% COM_PORT_CONNECT MATLAB code for com_port_connect.fig
%      COM_PORT_CONNECT, by itself, creates a new COM_PORT_CONNECT or raises the existing
%      singleton*.
%
%      H = COM_PORT_CONNECT returns the handle to a new COM_PORT_CONNECT or the handle to
%      the existing singleton*.
%
%      COM_PORT_CONNECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COM_PORT_CONNECT.M with the given input arguments.
%
%      COM_PORT_CONNECT('Property','Value',...) creates a new COM_PORT_CONNECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before com_port_connect_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to com_port_connect_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help com_port_connect

% Last Modified by GUIDE v2.5 06-Oct-2018 10:55:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @com_port_connect_OpeningFcn, ...
                   'gui_OutputFcn',  @com_port_connect_OutputFcn, ...
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


% --- Executes just before com_port_connect is made visible.
function com_port_connect_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to com_port_connect (see VARARGIN)

% Choose default command line output for com_port_connect
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(handles.figure1, 'Name', 'Select COM PORT');
set(handles.pop_com_port,'String',seriallist);
% UIWAIT makes com_port_connect wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = com_port_connect_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in pop_com_port.
function pop_com_port_Callback(hObject, eventdata, handles)
% hObject    handle to pop_com_port (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_com_port contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_com_port


% --- Executes during object creation, after setting all properties.
function pop_com_port_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_com_port (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_connect.
function button_connect_Callback(hObject, eventdata, handles)
% hObject    handle to button_connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = get(handles.pop_com_port,'String');
com_port = get(handles.pop_com_port,'Value');
com_port = char(data(com_port));
fprintf("%s Port selected ...\n",com_port);
setappdata(0,'com_port',com_port);
close()
run main_guide.m