function varargout = GUI_Laser_TF(varargin)
% GUI_LASER_TF MATLAB code for GUI_Laser_TF.fig
%      GUI_LASER_TF, by itself, creates a new GUI_LASER_TF or raises the existing
%      singleton*.
%
%      H = GUI_LASER_TF returns the handle to a new GUI_LASER_TF or the handle to
%      the existing singleton*.
%
%      GUI_LASER_TF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_LASER_TF.M with the given input arguments.
%
%      GUI_LASER_TF('Property','Value',...) creates a new GUI_LASER_TF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Laser_TF_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Laser_TF_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Laser_TF

% Last Modified by GUIDE v2.5 04-Nov-2016 13:47:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Laser_TF_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Laser_TF_OutputFcn, ...
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


% --- Executes just before GUI_Laser_TF is made visible.
function GUI_Laser_TF_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Laser_TF (see VARARGIN)
global laser_Eout;
global general_Rs;
global general_L;

axes(handles.axes1)
f = general_Rs*(0:(general_L/2))/general_L;
y = fft(laser_Eout);
P2 = abs(y/general_L);
P1 = P2(1:general_L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
plot(f,P1);
title('Fourier Transform');
ylabel('|FT(E_{out}(t))|');
xlabel('Hz')
% Choose default command line output for GUI_Laser_TF
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Laser_TF wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Laser_TF_OutputFcn(hObject, eventdata, handles) 
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
GUI_Laser;
