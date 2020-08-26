# Pot-Hole Detector with Flutter

[![Codemagic build status](https://api.codemagic.io/apps/5f44eba2a048040017aabcf5/5f44eba2a048040017aabcf4/status_badge.svg)](https://codemagic.io/apps/5f44eba2a048040017aabcf5/5f44eba2a048040017aabcf4/latest_build)
[![GitHub issues](https://img.shields.io/github/issues/parthpanchal123/ML_with_Flutter?style=flat-square)](https://github.com/parthpanchal123/ML_with_Flutter/issues)
[![GitHub forks](https://img.shields.io/github/forks/parthpanchal123/ML_with_Flutter?style=flat-square)](https://github.com/parthpanchal123/ML_with_Flutter/network)
[![GitHub stars](https://img.shields.io/github/stars/parthpanchal123/ML_with_Flutter?style=flat-square)](https://github.com/parthpanchal123/ML_with_Flutter/stargazers)
![](https://img.shields.io/badge/Made%20with-Flutter-blue)
<br>  
![App template](https://github.com/parthpanchal123/ML_with_Flutter/blob/master/Screenshots/ml_app_promo.png)

A simple cross platform application that utilizes tflite library which makes easy using tflite models right within the flutter app . It tries to predict whether a picture has pot-holes in it or not , as of now . Plan further to integrate real-time detection from video feed as well .  
I just used approximately 1000 images to train the model , thus sometimes it might behave weird .  
My main goal was to show a demo of how eask integrating ml models are in the app. 

 ## Resources used
 * [Pothole dataset](https://www.kaggle.com/atulyakumar98/pothole-detection-dataset) , which contains training images .
 * [Teachable](https://teachablemachine.withgoogle.com/) for training the model (I'm not good doing that myself :P).
 * [Tflite Package](https://pub.dev/packages/tflite) for using the TFlite model within the app itself.
 * [Image Picker](https://pub.dev/packages/image_picker) for picking image wither from the gallery or camera .


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
