function varargout = GUI_photodetector(varargin)
% GUI_PHOTODETECTOR MATLAB code for GUI_photodetector.fig
%      GUI_PHOTODETECTOR, by itself, creates a new GUI_PHOTODETECTOR or raises the existing
%      singleton*.
%
%      H = GUI_PHOTODETECTOR returns the handle to a new GUI_PHOTODETECTOR or the handle to
%      the existing singleton*.
%
%      GUI_PHOTODETECTOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_PHOTODETECTOR.M with the given input arguments.
%
%      GUI_PHOTODETECTOR('Property','Value',...) creates a new GUI_PHOTODETECTOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_photodetector_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_photodetector_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_photodetector

% Last Modified by GUIDE v2.5 14-Oct-2016 15:35:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_photodetector_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_photodetector_OutputFcn, ...
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


% --- Executes just before GUI_photodetector is made visible.
function GUI_photodetector_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_photodetector (see VARARGIN)
global photodetector_BER;

text = get(handles.BER,'String');
text = strcat(text,{' '},num2str(photodetector_BER));
set(handles.BER,'String',text);
% Choose default command line output for GUI_photodetector
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% UIWAIT makes GUI_photodetector wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_photodetector_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
%% Back button
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq;
GUI;


% --- Executes on button press in pushbutton2.
%% Eye diagram
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq;
GUI_photodetector_eyediagram;

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
global photodetector_i;
global photodetector_sig;
global photodetector_SNR;



switch get(hObject,'Value')
    case 2  % Current
        axes(handles.axes4)
        plot(photodetector_i)
        xlabel('sample number (n)');
        ylabel('current (A)');
        title('Current (PIN fotodetector)');
    case 3  % Current deviation
        axes(handles.axes4)
        plot(photodetector_sig) 
        xlabel('sample number (n)');
        ylabel('deviation (A^2)');
        title('Current deviation (PIN fotodetector)');
    case 4  % SNR
        axes(handles.axes4)
        plot(10*log(photodetector_SNR));
        xlabel('sample number');
        ylabel('SNR(dB)');
end
% switch contents{get(hObject,'Value')}


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over popupmenu1.
function popupmenu1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
