function varargout = KSCDemoGUI_main(varargin)
% KSCDEMOGUI_MAIN MATLAB code for KSCDemoGUI_main.fig
%      KSCDEMOGUI_MAIN, by itself, creates a new KSCDEMOGUI_MAIN or raises the existing
%      singleton*.
%
%      H = KSCDEMOGUI_MAIN returns the handle to a new KSCDEMOGUI_MAIN or the handle to
%      the existing singleton*.
%
%      KSCDEMOGUI_MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KSCDEMOGUI_MAIN.M with the given input arguments.
%
%      KSCDEMOGUI_MAIN('Property','Value',...) creates a new KSCDEMOGUI_MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before KSCDemoGUI_main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to KSCDemoGUI_main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help KSCDemoGUI_main

% Last Modified by GUIDE v2.5 27-Aug-2015 16:09:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @KSCDemoGUI_main_OpeningFcn, ...
                   'gui_OutputFcn',  @KSCDemoGUI_main_OutputFcn, ...
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


% --- Executes just before KSCDemoGUI_main is made visible.
function KSCDemoGUI_main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to KSCDemoGUI_main (see VARARGIN)

% Choose default command line output for KSCDemoGUI_main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes KSCDemoGUI_main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = KSCDemoGUI_main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in main.
function main_Callback(hObject, eventdata, handles)
% hObject    handle to main (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_handles = KSCDemoGUI_button;
axes_handles = KSCDemoGUI_axes;
% to_base_workspace();
% setappdata(0, 'h_but', button_handles)
% setappdata(0, 'h_ax', axes_handles)
delete(get(hObject, 'parent')); % close KSCDemoGUI_main 