%% KSCDemoGUI - 2

function varargout = KSCDemoGUI(varargin)
% KSCDEMOGUI MATLAB code for KSCDemoGUI.fig
%      KSCDEMOGUI, by itself, creates a new KSCDEMOGUI or raises the existing
%      singleton*.
%
%      H = KSCDEMOGUI returns the handle to a new KSCDEMOGUI or the handle to
%      the existing singleton*.
%
%      KSCDEMOGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KSCDEMOGUI.M with the given input arguments.
%
%      KSCDEMOGUI('Property','Value',...) creates a new KSCDEMOGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before KSCDemoGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to KSCDemoGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help KSCDemoGUI

% Last Modified by GUIDE v2.5 07-Aug-2015 15:28:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @KSCDemoGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @KSCDemoGUI_OutputFcn, ...
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
end
% End initialization code - DO NOT EDIT

% --- Executes just before KSCDemoGUI is made visible.
function KSCDemoGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to KSCDemoGUI (see VARARGIN)

% Choose default command line output for KSCDemoGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible so window
% can get raised using KSCDemoGUI.
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
%     axes(handles.time);
%     handles.time.Color = 'k';
%     handles.time.GridColor = 'w';
%     handles.time.XGrid = 'on'; handles.time.YGrid = 'on'; 
end

% UIWAIT makes KSCDemoGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = KSCDemoGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

% --- Executes on button press in startButton.
function startButton_Callback(hObject, eventdata, handles)
% hObject    handle to startButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.startButton, 'String', 'Stop');
set(handles.busy, 'String', 'Ready for data acquisition..');
handles.led.BackgroundColor = [0.2 1 0.2];
while (get(handles.startButton,'value'))
    KSCDemoBackend2(handles);
end
set(handles.startButton, 'String', 'Start');
set(handles.busy, 'String', '');
handles.led.BackgroundColor = [1 0.2 0.2];
end


% 
% % --- Executes during object creation, after setting all properties.
function res_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to res (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% plot(rand(3))
% darkenAxes(hObject);
% % Hint: place code in OpeningFcn to populate res
end
% 
% 
% % --- Executes during object creation, after setting all properties.
function time_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to time (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: place code in OpeningFcn to populate time
% plot(rand(2))
% darkenAxes(hObject);
end
% 
% % --- Executes during object creation, after setting all properties.
function harm_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to harm (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% plot(rand(5))
% darkenAxes(hObject);
% 
% % Hint: place code in OpeningFcn to populate res
end
% 
% % --- Executes during object creation, after setting all properties.
function fft_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to fft (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% plot(rand(4))
% darkenAxes(hObject);
% % Hint: place code in OpeningFcn to populate res
end


%%% Function to make the plot axes dark
function darkenAxes(axes)
% gives the axes object "axes" a dark theme, unlike the default light 
%
% Axes Properties to be Modified:
% Box, color of axes, background color, grid color, grid visibility
% minor grid color, minor grid visibility, title color

axes.Box = 'on';
axes.XColor = 'w'; axes.YColor = 'w';
axes.Color = 'k';
axes.GridColor = 'w';
axes.XGrid = 'on'; axes.YGrid = 'on';
axes.MinorGridColor = 'w';
axes.XMinorGrid = 'on'; axes.YMinorGrid = 'on';
axes.Title.Color = 'w';

end
