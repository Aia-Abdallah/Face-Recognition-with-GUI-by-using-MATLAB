function varargout = GUI_Face_Recognition(varargin)
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @GUI_Face_Recognition_OpeningFcn, ...
                       'gui_OutputFcn',  @GUI_Face_Recognition_OutputFcn, ...
                       'gui_LayoutFcn',  [], ...
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

function GUI_Face_Recognition_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output = hObject;
    guidata(hObject, handles);
end

function varargout = GUI_Face_Recognition_OutputFcn(hObject, eventdata, handles)
    varargout{1} = handles.output;
end

% --- Start Camera
function pushbutton1_Callback(hObject, eventdata, handles)
    handles.cam = webcam();
    handles.isRunning = true;
    guidata(hObject, handles);

    while true
        handles = guidata(hObject);  % Refresh inside loop
        if ~handles.isRunning
            break;
        end

        img = snapshot(handles.cam);
        imshow(img, 'Parent', handles.axes1);
        drawnow;

        handles.lastFrame = img;
        guidata(hObject, handles);
    end
end

% --- Recognize Face
function pushbutton2_Callback(hObject, eventdata, handles)
    if ~isfield(handles, 'lastFrame')
        set(handles.text2, 'String', 'No image captured');
        return;
    end

    img = handles.lastFrame;

    try
        data = load('trainedNet.mat');  % Ensure it contains variable 'net'
        net = data.net;
    catch
        set(handles.text2, 'String', 'Model file not found.');
        return;
    end

    imgResized = imresize(img, [227 227]);
    prediction = classify(net, imgResized);

    set(handles.text2, 'String', ['Result: ', char(prediction)]);
end

% --- Stop Camera
function pushbutton3_Callback(hObject, eventdata, handles)
    handles.isRunning = false;
    pause(0.5);

    if isfield(handles, 'cam')
        clear handles.cam;
    end

    cla(handles.axes1);
    set(handles.text2, 'String', 'Camera stopped');
    guidata(hObject, handles);
end
