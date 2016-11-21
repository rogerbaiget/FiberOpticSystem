function varargout = GUI_Amplifier(varargin)
% GUI_AMPLIFIER MATLAB code for GUI_Amplifier.fig
%      GUI_AMPLIFIER, by itself, creates a new GUI_AMPLIFIER or raises the existing
%      singleton*.
%
%      H = GUI_AMPLIFIER returns the handle to a new GUI_AMPLIFIER or the handle to
%      the existing singleton*.
%
%      GUI_AMPLIFIER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_AMPLIFIER.M with the given input arguments.
%
%      GUI_AMPLIFIER('Property','Value',...) creates a new GUI_AMPLIFIER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Amplifier_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Amplifier_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Amplifier

% Last Modified by GUIDE v2.5 03-Nov-2016 16:36:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Amplifier_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Amplifier_OutputFcn, ...
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


% --- Executes just before GUI_Amplifier is made visible.
function GUI_Amplifier_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Amplifier (see VARARGIN)

% Choose default command line output for GUI_Amplifier
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Amplifier wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Amplifier_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Back.
function Back_Callback(hObject, eventdata, handles)
% hObject    handle to Back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq;
GUI;


% --- Executes on button press in Eye.
function Eye_Callback(hObject, eventdata, handles)
% hObject    handle to Eye (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq;
GUI_Amplifier_eyediagram;


% --- Executes on selection change in menu.
function menu_Callback(hObject, eventdata, handles)
% hObject    handle to menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global photodetector_mean;
global photodetector_variance;
global photodetector_SNR;


switch get(hObject,'Value')
    case 2  % mean
        axes(handles.axes4)
        plot(0:0.01:2*pi,photodetector_mean)
        title('Mean');
    case 3  %variance
        axes(handles.axes4)
        plot(0:0.01:2*pi,photodetector_variance) 
        title('Variance');
    case 4  % SNR
        axes(handles.axes4)
        plot(0:0.01:2*pi,photodetector_SNR)
        title('SNR');
end
% Hints: contents = cellstr(get(hObject,'String')) returns menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from menu


% --- Executes during object creation, after setting all properties.
function menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq;
GUI_Amplifier_TF;
