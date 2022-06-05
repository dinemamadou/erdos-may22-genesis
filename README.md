# Erdos Institute | May 2022 Boot Camp | Team Genesis
Final Project Space for Team Genesis, Erdos Institute May2022 Bootcamp.

## Goal 
The goal of this project is to use spectral features **to classify human speech into emotion categories**, namely Happiness, Anger, Sadness, Fear, Disgust, Sadness and Neutral.


## Executive Summary
 
Correctly classifying human speech into categories of emotions, based solely on inherent characteristics of the audio (i.e. spectral features), has an ever-growing importance in many regards. From the more general goal of integrating human emotions into AI technology to helping the millions of autistic individuals perceive the subtleties that are being communicated to them or the multi-million dollar audio translation and speech-to-text market, the list of stakeholders in an accurate emotion classification goes on.

However, research shows that visually and audio-visually communicated emotions are more readily perceived and more accurately classified by human raters than audio-only ones. Following the recent strides made in Machine Learning techniques, we ask the questions: how do we leverage the power of Machine Learning to improve emotion classification of audios? To answer this question, we used the Crowd-sourced Emotional Multimodal Actor Dataset (CREMA-D). The dataset is collected from 2,443 human raters who were tasked with classifying a set of audios (in addition to visual-only and audio-visual) into six emotion categories, namely Happy, Anger, Sad, Fear, Disgust and Neutral. The audios were recordings of 12 sentences, each produced with 6 emotions by 91 actors from a wide age range and across different cultural backgrounds. 
 
The input to our classifiers are 6,076 actor-produced audio recordings (the data). Only 11 of the 12 sentences were used, as 1 of them included a variable that we ignored in the present project. We pre-processed the data by reducing the unwanted noise and removing the leading and trailing silences with audio-analysis packages. From here, we took two approaches. On the one hand, we extracted spectral features (i.e. mid-term features) from the audio and, on the other, we created spectrograms, which are images that represent an audio signal. These representations allowed us to approach the classification problem in two different ways: both as an audio classification problem, and an image classification one.
 
With these two types of representations, we built two machine learning pipelines, each using a different data representation. We used a Support Vector Machine (SVM) on the spectral features and a Convolutional Neural Network (CNN) on the spectrograms. After several parameter tunings on both techniques, the classification accuracy was 42% for the CNN and 45% for the SVM against 40.9% for human raters. The SVM model is found to be more promising to detect the Neutral and Anger emotion categories, while CNN worked best at detecting Sad and Anger. Crucially, when the classification is done over a subset of the six emotions, the accuracy of the SVM drastically increases, going as high as 90% when classifying Disgust vs Fear. The low accuracy observed when classifying all 6 emotions may be due to incorrect labeling because the target variable was the intended emotion and not the one actually produced by the actors. 
 
In summary, our classifiers performed at least as well as human raters did, and beyond. The next step in our project is to use much cleaner data, such as one that is not staged by actors like the CREMA-D (e.g: phone conversations) or maybe a subset of the CREMA-D data whose labels match the classification of the human raters. With such data, the classifiers may perform more accurately, to the delight of our many stakeholders.




## Problem Statement & Stakeholders

In this project, we considered the problem of classifying the emotional content of audio from human speech.

For instance, how can we train a computer to distinguish the emotions in the following clips? . A key point here is that the meaning of the sentence is emotionally neutral. The only way to interpret emotion is by the way the words are spoken. 




## Stakeholders
A solution to our problem would be applicable in many situations. 

For instance, children on the autism spectrum sometimes have difficulty processing the emotional content of other people’s speech. These children could use technology to process emotions in speech data, perhaps in the form of an app. 

As another example, conveying emotions in the language translation and speech-to-text industries can benefit from the implications of successful emotion classification.


# Workflow

	— add using python –
The entire project can be divided into several steps. We first preprocessed our data to clean it up. Then, we extracted two types of features. Next, using the audio and the image representations, we implemented two separate models. Finally, we compared the performance of our models  to each other and to human rater performance.

# Dataset

We used a dataset called CREMA-D (crowd-sourced emotional multimodal actor dataset).  

CREMA-D contains audio and video data, but we elected to focus only on audio data. 

The main audio dataset contains 6,076 audio files from 92 actors. Each actor read from a list of 11 sentences while trying to convey six emotions: Neutral, Anger, Happy, Sad, Fear, and Disgust.. The meanings of the sentences themselves are emotionally neutral.  

The audio files are equally split across emotional categories, so each emotion accounts for roughly 16% of the data. 

Apart from the audio files, CREMA-D contains crowd-sourced labels from an experiment in which humans were asked to categorize the actor’s intended emotions in the audio files. Each file was rated by at least 10 people. 



# Measuring success:

In this project, we consider a model to be successful if it performs at least as well as an average human rater. In the CREMA-D study, only 40% of the audio files were accurately recognized as the actors’ intended emotion categories by a majority of human raters.

So, a model will be considered successful if it correctly classifies the intended emotion in at least 40% of the samples in the test set. 

We felt justified in using overall accuracy because the data is evenly divided into emotions. In other words, a model can’t get a good accuracy score just by always guessing one particular emotion.

# Preprocessing the data: 

In order to clean up the dataset, we ran a noise reduction script on the raw audio files and removed the leading and trailing silences with specific audio-analysis packages. We operated on the shortened, clean version of the raw audio file.


### Feature Extraction: 

We extracted two types of features from the audio files: mid-term features (or mid features for short), and spectrograms.

Slide 6: Feature Extraction (Mid Features (PyAudioAnalysis):

Mid features are interpretable statistics in an audio signal, such as what frequencies are present and at what intensity. They are obtained by splitting the audio into frames, computing a set of interpretable statistics on each, and tabulating the average and standard deviation over all frames. The advantage of mid features is their interpretability and their relatively low computational cost, as each clip produces a vector with 136 entries. The main disadvantage is that by taking averages, we lose the temporal dimension. We used pyAudioAnalysis to compute these features. 


### Feature Extraction (Spectrogram (Librosa ):

A spectrogram of an audio file is a “heat map” image depicting which sound frequencies were most prevalent at different times in the clip. We used the Librosa package to produce spectrograms. This approach has several advantages. In the first place, every spectrogram has the same size of 219x269 pixels regardless of duration. The second is that we can use powerful image processing techniques such as neural networks. The disadvantage is that they are not as easily interpretable as the mid features, and neural nets are computationally expensive.

# Models

### Model 1: Classifying emotions using Mid Features and SVMs:
We used the mid features to train a support vector machine. We also tried to detect which mid features are most relevant in emotion classification. To that end, we trained another SVM using principal components without much success. Without PCA, the model accurately predicted the emotions of 45% of audio files in the test set. This is 4% better than the accuracy of the human raters in the original CREMA-D experiment, as their average accuracy for all emotions was 41%.

We also experimented using different subsets of emotion categories to mimic what happens if a human rater had fewer options to choose.  We observed that as the number of emotion categories decreased, the classifying accuracy improved, even as high as 90% when classifying two specific emotions.

### Model 2: Classifying emotions using Spectrograms and CNNs:

We trained a convolutional neural network on the spectrogram features. Because we only had about 4900 spectrograms in the training set, we were concerned about overfitting. To alleviate this, we experimented with several data augmentation techniques, such as adding a dropout layer, or adding a preprocessing step where we randomly shift the training data vertically and horizontally before feeding it to the neural net.

During training, our final model achieved around 50% validation accuracy. However, the model reached only 42% test accuracy. This is slightly worse than our SVM model, but still 1% better than the accuracy of the human raters in the CREMA-D experiment.

# Comparing models to human performance:

Here, we compare the recall of the human raters, the SVM, and the CNN in each of the six emotions. For example, the bars above “neutral” show what percentage of the neutral audio files were classified correctly. It seems that the SVM performed similarly to the human raters, but the CNN exhibited different behavior. The SVM performed highest for Anger and Neutral, similar to the human raters, but the CNN performed highest for the Anger and Sad emotion categories.

# Conclusions/Further directions

Overall, with machine learning techniques, we were able to replicate human-like performance. Of the two machine learning models, the recall of the SVM resembles the human rater recall more closely. We speculate that this is due to the difference between the kind of features used in training. Specifically, we believe this is because mid features better approximate how humans perceive speech.

In the future, we are interested in training the SVM model on a dataset in which the labels are determined only by human raters, not by the speaker’s intended emotion. We are also interested in extracting mid features on the level of individual words, rather than the whole sentence. This would enable us to account for nuances within word segments. Finally, another possible direction is to use more naturally occurring data that is not staged by actors, such as phone conversations.

# Acknowledgement of the authors of the dataset.

We are grateful to the **authors who developed the CREMA dataset**.
We are also grateful to our **Mentor Akul Dewan**, and the **Erdős Institute Team!**



 


