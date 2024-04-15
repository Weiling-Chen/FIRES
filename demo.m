clear;
clc;

addpath('./recognizability')
addpath('./component')

FSR_im = imread('FSR-2.png');
LR_im = imread('LR.png');

left_eye = imread('./component/FSR-2/left_eye.png');
right_eye = imread('./component/FSR-2/right_eye.png');

th = 120;
weight = 0.2;
q = FIRES(FSR_im, LR_im, left_eye, right_eye, th, weight);
