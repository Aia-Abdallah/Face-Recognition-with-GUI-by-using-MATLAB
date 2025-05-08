%%
clc
clear all
close all
warning off;
%%
% This object is used to capture video frames 
% from your computer's webcam.cao=webcam;
cao=webcam;
%creates a cascade object detector 
c=50;%counter
temp=0;
%infinite loop stoped while exprestion expired
while true
    e=cao.snapshot; % captures a single frame from the webcam using the snapshot method of the webcam object cao. 
                    % The captured frame is stored in the variable e.
    bboxes =step(faceDetector,e); %to detect face only without the body
    if(sum(sum(bboxes))~=0)
    if(temp>=c)
        break;
    else
    es=imcrop(e,bboxes(1,:));
    es=imresize(es,[227 227]);
    filename=strcat(num2str(temp),'.bmp');
    imwrite(es,filename);
    temp=temp+1;
    imshow(es);
    drawnow;
    end
    else
        imshow(e);
        drawnow;
    end
end