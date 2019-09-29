# ANFIS-classification
Classification of HRCT images of the lungs based using Adaptive Neuro Fuzzy Inference System (ANFIS) classifier : This was done as a part of my 2nd year's summer internship under the guidance of Professor Sudipta Mikhopadhyay at IIT Kharagpur.
All codes were written in MATLAB.

There are 1456 images and 20 features have been extracted from each image via Discrete Wavelet transform to classify them into 13 classes by the ANFIS network. 
Here we have followed four fold cross validation while training the network, i.e. three-fourth of the data is used for training and one-fourth for validation.

FeatureVectors1456.mat : It consists of tables containing the 20 features of each image along with their actual labels. (The labels have been numbered as 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130). 
Each image has been given a unique index/ sample number from 1-1456.

targetOutput1456.mat : It consists of a table containing the labels of the images in probablity format. 
For example if ith image belongs to class n then the probablity of this belonging to class n is  and the rest of the 12 classes is 0.

TrainTest1456_1.mat/ TrainTest1456_2.mat/ TrainTest_3.mat/ TrainTest1456_3.mat : These contain structured data for training and validation of the network in each of the folds. 

TrainResults.mat : It contains predicted classes, expected/ actual classes, error in prediction and other parameters obtained after training and prediction.

main1.m/ main2.m/ main3.m/ main4.m : These are the main programs for training the network and also for testing after training.

DiscretePlots.m/ AllInOfPlot4368.m : These programs are used for plotting and analysis of the results. 

The .fig files are used to analyze the results

The results show that the precision of the ANFIS classifier to be very high as compared to other generally used classifiers like ANN.
