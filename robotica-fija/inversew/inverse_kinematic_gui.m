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

% Last Modified by GUIDE v2.5 11-Nov-2018 15:09:40

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
x = str2double(get(handles.value_x,'String'));
y = str2double(get(handles.value_y,'String'));
z = str2double(get(handles.value_z,'String'));

tcp_theta=get(handles.tcp_angle,'Value');

set(handles.text5,'String',strcat("TCP angle=",num2str(tcp_theta)));
inverse_kinematic_arrob([x,y,z],tcp_theta);


% --- Executes on button press in subtract_x.
function subtract_x_Callback(hObject, eventdata, handles)
% hObject    handle to subtract_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = str2double(get(handles.value_x,'String'));
x = x-1;
set(handles.value_x,'String',x);
update_robot(handles);

% --- Executes on button press in add_x.
function add_x_Callback(hObject, eventdata, handles)
% hObject    handle to add_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = str2double(get(handles.value_x,'String'));
x = x+1;
set(handles.value_x,'String',x);
update_robot(handles);

% --- Executes on button press in subtract_y.
function subtract_y_Callback(hObject, eventdata, handles)
% hObject    handle to subtract_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
y= str2double(get(handles.value_y,'String'));
y = y-1;
set(handles.value_y,'String',y);
update_robot(handles);

% --- Executes on button press in add_y.
function add_y_Callback(hObject, eventdata, handles)
% hObject    handle to add_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
y= str2double(get(handles.value_y,'String'));
y = y+1;
set(handles.value_y,'String',y);
update_robot(handles);

% --- Executes on button press in subtract_z.
function subtract_z_Callback(hObject, eventdata, handles)
% hObject    handle to subtract_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
z= str2double(get(handles.value_z,'String'));
z = z-1;
set(handles.value_z,'String',z);
update_robot(handles);

% --- Executes on button press in add_z.
function add_z_Callback(hObject, eventdata, handles)
% hObject    handle to add_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
z= str2double(get(handles.value_z,'String'));
z = z+1;
set(handles.value_z,'String',z);
update_robot(handles);
