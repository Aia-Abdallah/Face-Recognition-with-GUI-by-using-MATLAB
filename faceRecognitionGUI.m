function faceRecognitionGUI()
    % Create the main UI window
    fig = uifigure('Name', 'Face Recognition', 'Position', [100 100 500 400]);

    % Axes to show live camera feed
    ax = uiaxes(fig, 'Position', [50 120 227 227]);
    title(ax, 'Live Camera');

    % Label to show the recognition result
    resultLabel = uilabel(fig, ...
        'Position', [300 250 150 30], ...
        'Text', 'Result: ', ...
        'FontSize', 16, ...
        'FontWeight', 'bold');

    % Button to start the camera
    camButton = uibutton(fig, ...
        'Text', 'Start Camera', ...
        'Position', [300 180 150 30], ...
        'ButtonPushedFcn', @(btn,event) startCamera(ax));

    % Button to recognize face
    recogButton = uibutton(fig, ...
        'Text', 'Recognize Face', ...
        'Position', [300 130 150 30], ...
        'ButtonPushedFcn', @(btn,event) recognizeFace(ax, resultLabel));
end

function startCamera(ax)
    % Start the webcam and show live feed
    cam = webcam;
    for i = 1:20
        img = snapshot(cam);
        image(ax, img);
        ax.XTick = [];
        ax.YTick = [];
        drawnow;
    end
end

function recognizeFace(ax, label)
    % Capture an image from webcam
    cam = webcam;
    img = snapshot(cam);
    
    % Load the trained neural network model
    model = load('trainedNet.mat'); % Make sure 'trainedNet.mat' contains variable 'net'
    net = model.net;
    
    % Resize the image to match AlexNet input size
    imgResized = imresize(img, [227 227]);

    % Classify the image using the trained model
    prediction = classify(net, imgResized);

    % Display the result in the GUI
    label.Text = ['Result: ', char(prediction)];
end
