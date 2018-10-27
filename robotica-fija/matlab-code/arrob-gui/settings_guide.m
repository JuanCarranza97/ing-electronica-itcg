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

% Last Modified by GUIDE v2.5 17-Oct-2018 23:17:18

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
arrob_serie.BytesAvailableFcn = {@arrob_serial_complete,handles};
dof = num2str(get(handles.pop_selected_dof,'Value')-1);
for i = 0:5
    fprintf(arrob_serie,strcat("r",dof,",",num2str(i)));
    pause(.01);
end
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
global arrob_serie
dof = num2str(get(handles.pop_selected_dof,'Value')-1);
for i = 0:7
    fprintf(arrob_serie,strcat("r",dof,",",num2str(i)));
    pause(.01);
end

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
dof = num2str(get(handles.pop_selected_dof,'Value')-1);
for i = 0:7
    fprintf(arrob_serie,strcat("r",dof,",",num2str(i)));
    pause(.01);
end

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
close()

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

% --- Executes on button press in detach_button.
function detach_button_Callback(hObject, eventdata, handles)
% hObject    handle to detach_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arrob_serie
dof = num2str(get(handles.pop_selected_dof,'Value')-1);
fprintf(arrob_serie,strcat("d",dof,",0"));


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
        otherwise
            fprintf("No spected\n");
    end  
else
        fprintf("No coincide\n %s\n",input);
       
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
