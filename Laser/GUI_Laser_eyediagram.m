function varargout = GUI_Laser_eyediagram(varargin)
% GUI_LASER_EYEDIAGRAM MATLAB code for GUI_Laser_eyediagram.fig
%      GUI_LASER_EYEDIAGRAM, by itself, creates a new GUI_LASER_EYEDIAGRAM or raises the existing
%      singleton*.
%
%      H = GUI_LASER_EYEDIAGRAM returns the handle to a new GUI_LASER_EYEDIAGRAM or the handle to
%      the existing singleton*.
%
%      GUI_LASER_EYEDIAGRAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_LASER_EYEDIAGRAM.M with the given input arguments.
%
%      GUI_LASER_EYEDIAGRAM('Property','Value',...) creates a new GUI_LASER_EYEDIAGRAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Laser_eyediagram_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Laser_eyediagram_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Laser_eyediagram

% Last Modified by GUIDE v2.5 10-Nov-2016 23:32:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Laser_eyediagram_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Laser_eyediagram_OutputFcn, ...
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


% --- Executes just before GUI_Laser_eyediagram is made visible.
function GUI_Laser_eyediagram_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Laser_eyediagram (see VARARGIN)

% Choose default command line output for GUI_Laser_eyediagram
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Laser_eyediagram wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Laser_eyediagram_OutputFcn(hObject, eventdata, handles) 
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
GUI_Laser;
