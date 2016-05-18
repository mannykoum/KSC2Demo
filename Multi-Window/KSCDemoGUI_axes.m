function varargout = KSCDemoGUI_axes(varargin)
% KSCDEMOGUI_AXES MATLAB code for KSCDemoGUI_axes.fig
%      KSCDEMOGUI_AXES, by itself, creates a new KSCDEMOGUI_AXES or raises the existing
%      singleton*.
%
%      H = KSCDEMOGUI_AXES returns the handle to a new KSCDEMOGUI_AXES or the handle to
%      the existing singleton*.
%
%      KSCDEMOGUI_AXES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KSCDEMOGUI_AXES.M with the given input arguments.
%
%      KSCDEMOGUI_AXES('Property','Value',...) creates a new KSCDEMOGUI_AXES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before KSCDemoGUI_axes_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to KSCDemoGUI_axes_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help KSCDemoGUI_axes

% Last Modified by GUIDE v2.5 27-Aug-2015 17:34:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @KSCDemoGUI_axes_OpeningFcn, ...
                   'gui_OutputFcn',  @KSCDemoGUI_axes_OutputFcn, ...
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


% --- Executes just before KSCDemoGUI_axes is made visible.
function KSCDemoGUI_axes_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to KSCDemoGUI_axes (see VARARGIN)

% Choose default command line output for KSCDemoGUI_axes
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes KSCDemoGUI_axes wait for user response (see UIRESUME)
% uiwait(handles.figure1);
if strcmp(get(hObject,'Visible'),'off')
    KSC_Control2(700, '', '', '', '') % Initial KSC-2 setup
    
    plot(handles.time, rand(2))
    darkenAxes(handles.time);
    plot(handles.fft, rand(4))
    darkenAxes(handles.fft);
    plot(handles.res, rand(3))
    darkenAxes(handles.res);
    plot(handles.harm, rand(5))
    darkenAxes(handles.harm);
end
setappdata(0, 'h_a', handles)

% --- Outputs from this function are returned to the command line.
function varargout = KSCDemoGUI_axes_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
rmappdata(0, 'h_a'); % clean up app data
rmappdata(0, 'h_b');
delete(KSCDemoGUI_button);
delete(hObject);
