# Face-Recognition-with-GUI-by-using-MATLAB
Face Recognition with GUI by using MATLAB
# Face Recognition GUI Project

This MATLAB project implements a face recognition system using a simple GUI with three main buttons:
- **Start**: Opens the webcam and continuously displays the video stream.
- **Recognize**: Captures the current frame and classifies it using a pretrained model (`trainedNet.mat`), identifying if the person is a "BABY" or "GIRL".
- **End**: Stops the webcam and clears the interface.

## 📁 Project Structure

| File                                | Description |
|-------------------------------------|-------------|
| `GUI_Face_Recognition.fig`          | The GUI layout created using MATLAB GUIDE. |
| `GUI_Face_Recognition.m`            | The main logic controlling GUI interaction and webcam. |
| `Learning_modle_4face_detection.m`  | Script to train the model using AlexNet. |
| `Testing_modle_4face_detection.m`   | Script to test the trained model on new data. |
| `faceRecognitionGUI.m`              | Possibly an alternative GUI implementation. |
| `final_project_ISA.m`               | The final integration or control script. |
| `trainedNet.mat`                    | The trained deep learning model (not uploaded for size). |
| `README.md`                         | This file. Describes the project setup and usage. |

## ⚙️ Requirements

- MATLAB (R2021b or later recommended)
- Deep Learning Toolbox
- Pretrained AlexNet (`alexnet`) — Download using:
  ```matlab
  net = alexnet;
