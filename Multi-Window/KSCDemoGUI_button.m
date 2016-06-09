function varargout = KSCDemoGUI_button(varargin)
% KSCDEMOGUI_BUTTON MATLAB code for KSCDemoGUI_button.fig
%      KSCDEMOGUI_BUTTON, by itself, creates a new KSCDEMOGUI_BUTTON or raises the existing
%      singleton*.
%
%      H = KSCDEMOGUI_BUTTON returns the handle to a new KSCDEMOGUI_BUTTON or the handle to
%      the existing singleton*.
%
%      KSCDEMOGUI_BUTTON('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KSCDEMOGUI_BUTTON.M with the given input arguments.
%
%      KSCDEMOGUI_BUTTON('Property','Value',...) creates a new KSCDEMOGUI_BUTTON or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before KSCDemoGUI_button_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to KSCDemoGUI_button_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help KSCDemoGUI_button

% Last Modified by GUIDE v2.5 28-Aug-2015 17:11:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @KSCDemoGUI_button_OpeningFcn, ...
                   'gui_OutputFcn',  @KSCDemoGUI_button_OutputFcn, ...
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


% --- Executes just before KSCDemoGUI_button is made visible.
function KSCDemoGUI_button_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to KSCDemoGUI_button (see VARARGIN)

% Choose default command line output for KSCDemoGUI_button
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes KSCDemoGUI_button wait for user response (see UIRESUME)
% uiwait(handles.figure1);
setappdata(0, 'h_b', handles)

% --- Outputs from this function are returned to the command line.
function varargout = KSCDemoGUI_button_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in startButton.
function startButton_Callback(hObject, eventdata, handles)
% hObject    handle to startButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h_a = getappdata(0, 'h_a');
h_b = getappdata(0, 'h_b');

%%% 
% This would be used instead of catstruct if we were to change the handle
% references in here, the other GUIs and the Backend file:
% 
%   h = struct('h_a', h_a, 'h_b', h_b);
% 
h = catstruct(h_a, h_b);

set(h.busy, 'String', 'Ready for data acquisition..');

set(h.startButton, 'String', 'Stop');
set(h.busy, 'String', 'Ready for data acquisition..');
h.led.BackgroundColor = [0.2 1 0.2];
while (get(h.startButton,'value'))
    try
        KSCDemoBackend2(h);
    catch E
        disp(getReport(E));
        return
    end
end
set(h.startButton, 'String', 'Start');
set(h.busy, 'String', '');
h.led.BackgroundColor = [1 0.2 0.2];


% --- Executes on button press in led.
function led_Callback(hObject, eventdata, handles)
% hObject    handle to led (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
% rmappdata(0, 'h_a'); % clean up app data
% rmappdata(0, 'h_b');
delete(KSCDemoGUI_axes);
delete(hObject);


% --- Executes on button press in playButton.
function playButton_Callback(hObject, eventdata, handles)
% hObject    handle to playButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tts('Raw signal');
pause(.5);
sound(audioread('rawsignal.wav'),51200);
pause(2);
tts('After resonance compensation');
pause(.7);
sound(audioread('compensated.wav'),51200);
