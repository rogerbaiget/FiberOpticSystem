function varargout = GUI_Modulator_eyediagram(varargin)
% GUI_MODULATOR_EYEDIAGRAM MATLAB code for GUI_Modulator_eyediagram.fig
%      GUI_MODULATOR_EYEDIAGRAM, by itself, creates a new GUI_MODULATOR_EYEDIAGRAM or raises the existing
%      singleton*.
%
%      H = GUI_MODULATOR_EYEDIAGRAM returns the handle to a new GUI_MODULATOR_EYEDIAGRAM or the handle to
%      the existing singleton*.
%
%      GUI_MODULATOR_EYEDIAGRAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_MODULATOR_EYEDIAGRAM.M with the given input arguments.
%
%      GUI_MODULATOR_EYEDIAGRAM('Property','Value',...) creates a new GUI_MODULATOR_EYEDIAGRAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Modulator_eyediagram_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Modulator_eyediagram_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Modulator_eyediagram

% Last Modified by GUIDE v2.5 14-Oct-2016 15:34:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Modulator_eyediagram_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Modulator_eyediagram_OutputFcn, ...
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


% --- Executes just before GUI_Modulator_eyediagram is made visible.
function GUI_Modulator_eyediagram_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Modulator_eyediagram (see VARARGIN)

% Choose default command line output for GUI_Modulator_eyediagram
handles.output = hObject;
% ------------------------------------------------------------------------
% Global variables
global modulator_Eout;
% ------------------------------------------------------------------------
axes(handles.axes1) % elegimos el lugar donde plotear

% Hacer el eyediagram

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Modulator_eyediagram wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Modulator_eyediagram_OutputFcn(hObject, eventdata, handles) 
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
GUI_Modulator;
