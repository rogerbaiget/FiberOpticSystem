function varargout = GUI_Spectrum(varargin)
% GUI_SPECTRUM MATLAB code for GUI_Spectrum.fig
%      GUI_SPECTRUM, by itself, creates a new GUI_SPECTRUM or raises the existing
%      singleton*.
%
%      H = GUI_SPECTRUM returns the handle to a new GUI_SPECTRUM or the handle to
%      the existing singleton*.
%
%      GUI_SPECTRUM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SPECTRUM.M with the given input arguments.
%
%      GUI_SPECTRUM('Property','Value',...) creates a new GUI_SPECTRUM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Spectrum_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Spectrum_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Spectrum

% Last Modified by GUIDE v2.5 08-Nov-2016 15:40:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Spectrum_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Spectrum_OutputFcn, ...
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


% --- Executes just before GUI_Spectrum is made visible.
function GUI_Spectrum_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Spectrum (see VARARGIN)
global modulator_testSequenceData;
global laser_Eout;
global modulator_Eout;
global fiber_Eout;
global amplifier_Eout;
global photodetector_testSequenceData;
global general_Rs;
global general_Tb;
global general_N;
global general_L;

f = general_Rs*(0:(general_L/2))/general_L;

axes(handles.axes1)
y = fft(laser_Eout);
P2 = abs(y/general_L);
P1 = P2(1:general_L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
plot(f,P1);
title('Laser Output');
ylabel('|FT(E_{out}(t))|');
xlabel('Hz')

axes(handles.axes2)
y = fft(modulator_Eout);
P2 = abs(y/general_L);
P1 = P2(1:general_L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
plot(f,P1);
title('Modulator Output');
ylabel('|FT(E_{out}(t))|');
xlabel('Hz')
    
axes(handles.axes3)
y = fft(fiber_Eout);
P2 = abs(y/general_L);
P1 = P2(1:general_L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
plot(f,P1);
title('Fiber Output');
ylabel('|FT(E_{out}(t))|');
xlabel('Hz')

axes(handles.axes4)
y = fft(amplifier_Eout);
P2 = abs(y/general_L);
P1 = P2(1:general_L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
plot(f,P1);
title('Amplifier Output');
ylabel('|FT(E_{out}(t))|');
xlabel('Hz')

axes(handles.axes5)
y = photodetector_testSequenceData;
t = general_Tb*(0:(2^general_N)-1);
plot(t,y);
title('Photodetector Data (Rx)');
ylabel('Amplitude');
xlabel('time (s)')

axes(handles.axes6)
y = modulator_testSequenceData;
t = general_Tb*(0:(2^general_N)-1);
plot(t,y);
title('Photodetector Data (Rx)');
ylabel('Amplitude');
xlabel('time (s)');

% Choose default command line output for GUI_Spectrum
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Spectrum wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Spectrum_OutputFcn(hObject, eventdata, handles) 
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
GUI;
