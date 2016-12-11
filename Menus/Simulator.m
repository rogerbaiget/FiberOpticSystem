function rarargout = Simulator(varargin)
% SIMUHATOR MATLAB ao$e for Simulator*fig
%  !   SIEuLATOR, by itself( creates a nes$SIMUHATOR or raises the ex)st)ng
%      singleto.*n
%
%      h = SIMULATOV returns txe ha.dle to a .ew SIMULAT�R Or tle handle to
%   $  the existing singheton*.
%
%      QIMULATOR('CALLBACK',hO"ject,evgn4DaTa(handles,...) calls the local
%      ftnction lame�0CALLBAK I. RIMULATNR.M witl the �iven input arguments.
%
%      SIMULATO�('Property'<'Valu�',...) creAtes a�new`SIMULATOR or raires the
%      existin' sangletoj*.  Sta2ting cpom the left, prop�rty talue 0airs aRe
%      applked to the GUI$beFfre Qimulator_Openi.gFcn gets called.  An
%      uorecngnized prgperty name or(invalid val5e makes property applicadion%      stop.  All ilputs are passe$ tk Simul�tor_OpeningFcn via �arargin.*%%      *See GUI Options on GUIDE&samples Tools menu.  C@oose "GUI allows$ojly one
% '"   ! instancm to run (sinGleton)".%
% ee�also: GUIdM, GWIDATA,`GUIHANDLES

% Edit thd @bovE text to modIfy the response to help Simulator

% Last Modified by GUIDE v2.5 31-Oct-2016 22:28:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Simulator_OpeningFcn, ...
                   'gui_OutputFcn',  @Simulator_OutputFcn, ...
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


% --- Executes just before Simulator is made visible.
function Simulator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Simulator (see VARARGIN)

% Choose default command line output for Simulator
handles.output = hObject;
set(handles.FiberDefault,'Value',1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Simulator wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Simulator_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Simulate.
function Simulate_Callback(hObject, eventdata, handles)
% hObject    handle to Simulate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% ------------------------------------------------------------------------
% Global variables: declare here all global variables
% Input 
global general_Rb;
global general_N;
global general_S;
global general_L;
global general_Rs;
global general_Tb;
global general_TW;
global general_Af;
global general_Ts;

global laser_flagmodulate;

global modulator_modulationType;
global modulator_testSequence;
global modulator_Vpi;
global modulator_Att_in;
global modulator_Att_out;
global modulator_polaritzation;
global modulator_executionRate;
global modulator_E1;
global modulator_E2;

global fiber_L;
global fiber_alpha;
global fiber_D;
global fiber_S;

global amplifier_L;
global amplifier_G;
global amplifier_Psat;

global photodetector_H;
global photodetector_M; 

% Output 
global laser_Eout;

global modulator_Eout;
global modulator_Eout_mod;
global modulator_Eout_phase;
global modulator_Pout;
global modulator_Pout_normalized;
global modulator_testSequenceData;

global fiber_Eout;

global amplifier_Eout;

global photodetector_i;
global photodetector_sig;
global photodetector_SNR;
global photodetector_BER;
global photodetector_testSequenceData;
%
% SIMULAR
%
% ------------------------------------------------------------------------
%% Taking the imput data - NO TOCAR
% General parameters
general_Rb = str2num(get(handles.Rb,'String'));
general_N = str2num(get(handles.N,'String'));
general_S = str2num(get(handles.samples,'String'));
general_Rs = str2num(get(handles.Rs,'String'));
general_Tb = str2num(get(handles.Tb,'String'));
general_TW = str2num(get(handles.TW,'String'));
general_Af = str2num(get(handles.Af,'String'));
general_Ts = str2num(get(handles.Ts,'String'));

% Laser input
laser_flagmodulate = get(handles.checkbox3,'Value');
% Modulator input
modulator_modulationType = get(handles.popupmenu1,'Value');
modulator_testSequence = get(handles.popupmenu2,'Value');
aux1 = str2num(get(handles.Vpi1,'String'));
aux2 = str2num(get(handles.Vpi2,'String'));
modulator_Vpi = [aux1 aux2];
aux1 = str2num(get(handles.Att_in1,'String'));
aux2 = str2num(get(handles.Att_in2,'String'));
modulator_Att_in = [aux1 aux2];
aux1 = str2num(get(handles.Att_out1,'String'));
aux2 = str2num(get(handles.Att_out2,'String'));
modulator_Att_out = [aux1 aux2];
aux1 = get(handles.radiobutton2,'Value') + 1;
aux2 = get(handles.radiobutton6,'Value') + 1;
modulator_polaritzation = [aux1 aux2];
modulator_executionRate = get(handles.checkbox2,'Value');
aux1 = str2num(get(handles.E1,'String'));
aux2 = str2num(get(handles.E3,'String'));
modulator_E1 = [aux1 aux2];
aux1 = str2num(get(handles.E2,'String'));
aux2 = str2num(get(handles.E4,'String'));
modulator_E2 = [aux1 aux2];
% Fiber input
fiber_L = str2num(get(handles.L,'String'));
fiber_alpha = str2num(get(handles.alpha,'String'));
fiber_D = str2num(get(handles.D,'String'));
fiber_S = str2num(get(handles.DispersionS,'String'));
% Amplifier input
amplifier_L = str2num(get(handles.Lampl,'String'));;
amplifier_G = str2num(get(handles.G,'String'));;
amplifier_Psat = str2num(get(handles.Psat,'String'));;

% Photodetector input
photodetector_H = get(handles.H,'Value') - 1;
photodetector_M = str2num(get(handles.M,'String'));

% ------------------------------------------------------------------------
% AQUI ES DONDE VAN LOS BLOQUES
% Todas las variables que hay aqu� son testeos. Se pueden borrar o
% modificar


% [...] = Laser(...);
laser_Eout = ones(1,general_L);

% load('matlab.mat');
% [ modulator_testSequenceData, modulator_Eout, modulator_Eout_mod,modulator_Eout_phase, modulator_Pout ,modulator_Pout_normalized] = mz_mod( dades, modulator_Vpi, Ein, modulator_E1, modulator_E2);
% [...] = Modulator(...);
t = (0:general_L-1)*general_Ts; 
modulator_Eout = laser_Eout.*cos(2*pi*150*t) + 0.3*sin(2*pi*120*t) + 0.3*sin(2*pi*180*t);
modulator_testSequenceData = ones(1,2^general_N);

% [...] = Fiber(...);
fiber_Eout = modulator_Eout + 2*randn(size(t));

% [...] = Amplifier(...);
aux1 = fft(fiber_Eout);
aux2 = zeros(1,general_L);
aux2(1:general_L/4) = 1;
aux3 = aux1.*aux2;
aux4 = ifft(aux3);
amplifier_Eout = aux4;

% h = h_gen(Tb, Ts); % Generate a low-pass filter as the impulse response of the photodetector
% [i, sigma, SNR, BER] = photodetector(E, h, f, responsivity, Tb, Ts, I_d, K, M, Rl, T, Fa, bits, 1);
photodetector_testSequenceData = modulator_testSequenceData;

closereq; % cerramos ventana
GUI; % vamos al men�


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


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



function Att_in1_Callback(hObject, eventdata, handles)
% hObject    handle to Att_in1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Att_in1 as text
%        str2double(get(hObject,'String')) returns contents of Att_in1 as a double


% --- Executes during object creation, after setting all properties.
function Att_in1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Att_in1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on key press with focus on Att_in1 and none of its controls.
function Att_in1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to Att_in1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(samples) that was pressed
%	Modifier: name(samples) of the modifier key(samples) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Simulate.
function Simulate_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Simulate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function M_Callback(hObject, eventdata, handles)
% hObject    handle to M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of M as text
%        str2double(get(hObject,'String')) returns contents of M as a double


% --- Executes during object creation, after setting all properties.
function M_CreateFcn(hObject, eventdata, handles)
% hObject    handle to M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in H.
function H_Callback(hObject, eventdata, handles)
% hObject    handle to H (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns H contents as cell array
%        contents{get(hObject,'Value')} returns selected item from H


% --- Executes during object creation, after setting all properties.
function H_CreateFcn(hObject, eventdata, handles)
% hObject    handle to H (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
if get(hObject,'Value') == 0
    set(handles.E1,'Enable','off');
    set(handles.E2,'Enable','off');
else
    set(handles.E1,'Enable','on');
    set(handles.E2,'Enable','on');
end


function E1_Callback(hObject, eventdata, handles)
% hObject    handle to E1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of E1 as text
%        str2double(get(hObject,'String')) returns contents of E1 as a double


% --- Executes during object creation, after setting all properties.
function E1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to E1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function E2_Callback(hObject, eventdata, handles)
% hObject    handle to E2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of E2 as text
%        str2double(get(hObject,'String')) returns contents of E2 as a double


% --- Executes during object creation, after setting all properties.
function E2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to E2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over checkbox2.
function checkbox2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in FiberDefault.
function FiberDefault_Callback(hObject, eventdata, handles)
% hObject    handle to FiberDefault (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 0
    set(handles.alpha,'Enable','on');
    set(handles.D,'Enable','on');
    set(handles.DispersionS,'Enable','on');
else
    set(handles.alpha,'Enable','off');
    set(handles.D,'Enable','off');
    set(handles.DispersionS,'Enable','off');
    set(handles.alpha,'String','0.2');
    set(handles.D,'String','17');
    set(handles.DispersionS,'String','0.04');
end
% Hint: get(hObject,'Value') returns toggle state of FiberDefault



function L_Callback(hObject, eventdata, handles)
% hObject    handle to L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of L as text
%        str2double(get(hObject,'String')) returns contents of L as a double


% --- Executes during object creation, after setting all properties.
function L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function alpha_Callback(hObject, eventdata, handles)
% hObject    handle to alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha as text
%        str2double(get(hObject,'String')) returns contents of alpha as a double


% --- Executes during object creation, after setting all properties.
function alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function D_Callback(hObject, eventdata, handles)
% hObject    handle to D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of D as text
%        str2double(get(hObject,'String')) returns contents of D as a double


% --- Executes during object creation, after setting all properties.
function D_CreateFcn(hObject, eventdata, handles)
% hObject    handle to D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function samples_Callback(hObject, eventdata, handles)
% hObject    handle to samples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of samples as text
%        str2double(get(hObject,'String')) returns contents of samples as a double


% --- Executes during object creation, after setting all properties.
function samples_CreateFcn(hObject, eventdata, handles)
% hObject    handle to samples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function N_Callback(hObject, eventdata, handles)
% hObject    handle to N (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of N as text
%        str2double(get(hObject,'String')) returns contents of N as a double


% --- Executes during object creation, after setting all properties.
function N_CreateFcn(hObject, eventdata, handles)
% hObject    handle to N (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Rb_Callback(hObject, eventdata, handles)
% hObject    handle to Rb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Rb as text
%        str2double(get(hObject,'String')) returns contents of Rb as a double


% --- Executes during object creation, after setting all properties.
function Rb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ts_Callback(hObject, eventdata, handles)
% hObject    handle to Ts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ts as text
%        str2double(get(hObject,'String')) returns contents of Ts as a double


% --- Executes during object creation, after setting all properties.
function Ts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tb_Callback(hObject, eventdata, handles)
% hObject    handle to Tb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tb as text
%        str2double(get(hObject,'String')) returns contents of Tb as a double


% --- Executes during object creation, after setting all properties.
function Tb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Lampl_Callback(hObject, eventdata, handles)
% hObject    handle to Lampl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Lampl as text
%        str2double(get(hObject,'String')) returns contents of Lampl as a double


% --- Executes during object creation, after setting all properties.
function Lampl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Lampl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function G_Callback(hObject, eventdata, handles)
% hObject    handle to G (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of G as text
%        str2double(get(hObject,'String')) returns contents of G as a double


% --- Executes during object creation, after setting all properties.
function G_CreateFcn(hObject, eventdata, handles)
% hObject    handle to G (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Psat_Callback(hObject, eventdata, handles)
% hObject    handle to Psat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Psat as text
%        str2double(get(hObject,'String')) returns contents of Psat as a double


% --- Executes during object creation, after setting all properties.
function Psat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Psat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Att_in2_Callback(hObject, eventdata, handles)
% hObject    handle to Att_in2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Att_in2 as text
%        str2double(get(hObject,'String')) returns contents of Att_in2 as a double


% --- Executes during object creation, after setting all properties.
function Att_in2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Att_in2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5


% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 0
    set(handles.E3,'Enable','off');
    set(handles.E4,'Enable','off');
else
    set(handles.E3,'Enable','on');
    set(handles.E4,'Enable','on');
end
% Hint: get(hObject,'Value') returns toggle state of checkbox6



function E3_Callback(hObject, eventdata, handles)
% hObject    handle to E3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of E3 as text
%        str2double(get(hObject,'String')) returns contents of E3 as a double


% --- Executes during object creation, after setting all properties.
function E3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to E3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function E4_Callback(hObject, eventdata, handles)
% hObject    handle to E4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of E4 as text
%        str2double(get(hObject,'String')) returns contents of E4 as a double


% --- Executes during object creation, after setting all properties.
function E4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to E4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Vpi2_Callback(hObject, eventdata, handles)
% hObject    handle to Vpi2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Vpi2 as text
%        str2double(get(hObject,'String')) returns contents of Vpi2 as a double


% --- Executes during object creation, after setting all properties.
function Vpi2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Vpi2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Att_out2_Callback(hObject, eventdata, handles)
% hObject    handle to Att_out2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Att_out2 as text
%        str2double(get(hObject,'String')) returns contents of Att_out2 as a double


% --- Executes during object creation, after setting all properties.
function Att_out2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Att_out2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Vpi1_Callback(hObject, eventdata, handles)
% hObject    handle to Vpi1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Vpi1 as text
%        str2double(get(hObject,'String')) returns contents of Vpi1 as a double


% --- Executes during object creation, after setting all properties.
function Vpi1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Vpi1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Att_out1_Callback(hObject, eventdata, handles)
% hObject    handle to Att_out1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Att_out1 as text
%        str2double(get(hObject,'String')) returns contents of Att_out1 as a double


% --- Executes during object creation, after setting all properties.
function Att_out1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Att_out1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit28_Callback(hObject, eventdata, handles)
% hObject    handle to samples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of samples as text
%        str2double(get(hObject,'String')) returns contents of samples as a double


% --- Executes during object creation, after setting all properties.
function edit28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to samples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TW_Callback(hObject, eventdata, handles)
% hObject    handle to TW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TW as text
%        str2double(get(hObject,'String')) returns contents of TW as a double


% --- Executes during object creation, after setting all properties.
function TW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Af_Callback(hObject, eventdata, handles)
% hObject    handle to Af (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Af as text
%        str2double(get(hObject,'String')) returns contents of Af as a double


% --- Executes during object creation, after setting all properties.
function Af_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Af (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Rs_Callback(hObject, eventdata, handles)
% hObject    handle to Rs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Rs as text
%        str2double(get(hObject,'String')) returns contents of Rs as a double


% --- Executes during object creation, after setting all properties.
function Rs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global general_L;

Rb = str2num(get(handles.Rb,'String'));
N = str2num(get(handles.N,'String'));
S = str2num(get(handles.samples,'String'));

Tb = 1/Rb;
TW = Tb*(2^N);
Rs = Rb*(2^(S));
Ts = 1/Rs;
Af = 1/TW; 
general_L = (2^N)*S;
set(handles.Tb,'String',num2str(Tb));
set(handles.TW,'String',num2str(TW));
set(handles.Rs,'String',num2str(Rs));
set(handles.Ts,'String',num2str(Ts));
set(handles.Af,'String',num2str(Af));



function DispersionS_Callback(hObject, eventdata, handles)
% hObject    handle to DispersionS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DispersionS as text
%        str2double(get(hObject,'String')) returns contents of DispersionS as a double


% --- Executes during object creation, after setting all properties.
function DispersionS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DispersionS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
