function varargout = GUI_Fiber_TF(varargin)
% GUI_FIBER_TF MATLAB code for GUI_Fiber_TF.fig
%      GUI_FIBER_TF, by itself, creates a new GUI_FIBER_TF or raises the existing
%      singleton*.
%
%      H = GUI_FIBER_TF returns the handle to a new GUI_FIBER_TF or the handle to
%      the existing singleton*.
%
%      GUI_FIBER_TF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_FIBER_TF.M with the given input arguments.
%
%      GUI_FIBER_TF('Property','Value',...) creates a new GUI_FIBER_TF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Fiber_TF_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Fiber_TF_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Fiber_TF

% Last Modified by GUIDE v2.5 04-Nov-2016 13:47:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Fiber_TF_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Fiber_TF_OutputFcn, ...
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


% --- Executes just before GUI_Fiber_TF is made visible.
function GUI_Fiber_TF_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Fiber_TF (see VARARGIN)
global fiber_Eout;
global general_Rs;
global general_L;

axes(handles.axes1)
%f = general_Rs*(0:(general_L/2))/general_L;
w = 2*pi*general_Rs*(-(general_L/2):((general_L/2)-1))/general_L;
y = fft(fiber_Eout);
y = fftshift(y);
plot(w,y);
title('Fourier Transform');
ylabel('|FT(E_{out}(t))|');
xlabel('Hz')
% Choose default command line output for GUI_Fiber_TF
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Fiber_TF wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Fiber_TF_OutputFcn(hObject, eventdata, handles) 
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
closereq;
GUI_Fiber;
