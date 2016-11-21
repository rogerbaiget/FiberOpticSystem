function varargout = GUI_Modulator(varargin)
% GUI_MODULATOR MATLAB code for GUI_Modulator.fig
%      GUI_MODULATOR, by itself, creates a new GUI_MODULATOR or raises the existing
%      singleton*.
%
%      H = GUI_MODULATOR returns the handle to a new GUI_MODULATOR or the handle to
%      the existing singleton*.
%
%      GUI_MODULATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_MODULATOR.M with the given input arguments.
%
%      GUI_MODULATOR('Property','Value',...) creates a new GUI_MODULATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Modulator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Modulator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Modulator

% Last Modified by GUIDE v2.5 03-Nov-2016 16:17:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Modulator_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Modulator_OutputFcn, ...
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


% --- Executes just before GUI_Modulator is made visible.
function GUI_Modulator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Modulator (see VARARGIN)

% Choose default command line output for GUI_Modulator
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Modulator wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Modulator_OutputFcn(hObject, eventdata, handles) 
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
GUI_Modulator_eyediagram;


% --- Executes on selection change in Options.
function Options_Callback(hObject, eventdata, handles)
% hObject    handle to Options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% ------------------------------------------------------------------------
% Declarar aqui las variables globales
global modulator_Eout;
global modulator_Eout_mod;
global modulator_Eout_phase;
global modulator_Pout;
global modulator_Pout_normalized;
global modulator_testSequenceData;
% ------------------------------------------------------------------------

axes(handles.axes1) % elegimos el lugar donde plotear

switch get(hObject,'Value')
    case 2  % Test Sequence
        plot(modulator_testSequenceData)
        title('Test Sequence Data');
        ylabel('Amplitude ( )')
        xlabel('Time (s)')
    case 3  % Eout mod
        plot(modulator_Eout_mod) 
        title('|E_{out}|');
        ylabel('Amplitude ( )')
        xlabel('Time (s)')
    case 4  % Eout phase
        plot(modulator_Eout_phase.*(180/pi))
        title('\angle E_{out}');
        ylabel('angle')
        xlabel('Time (s)')
    case 5  % Pout
        plot(modulator_Pout)
        title('P_{out}'); 
        ylabel('W')
        xlabel('Time (s)')
    case 6  % Pout normalized
        plot(modulator_Pout_normalized)
        title('Normalized P_{out}');
        ylabel('Amplitude ( )')
        xlabel('Time (s)')
        ylim([0 1]);
end
% Hints: contents = cellstr(get(hObject,'String')) returns Options contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Options


% --- Executes during object creation, after setting all properties.
function Options_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Options (see GCBO)
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
GUI_Modulator_TF;
