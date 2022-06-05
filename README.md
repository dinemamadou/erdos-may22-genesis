# Erdos Institute | May 2022 Boot Camp | Team Genesis
Final Project Space for Team Genesis, Erdos Institute May2022 Bootcamp 

By: Mario Gomez Flores, Tajudeen Mamadou, Mohammad Nooranidoost, Elif Poyraz, Rose Weisshaar


## Goal 
The goal of this project is to use spectral features **to classify human speech into emotion categories**, namely Happiness, Anger, Sadness, Fear, Disgust, Sadness and Neutral.


## Problem Statement & Stakeholders

In this project, we considered the problem of classifying the emotional content of audio from human speech.

For instance, how can we train a computer to distinguish the emotions in the following clips? . A key point here is that the meaning of the sentence is emotionally neutral. The only way to interpret emotion is by the way the words are spoken. 



## Stakeholders
A solution to our problem would be applicable in many situations. 

For instance, children on the autism spectrum sometimes have difficulty processing the emotional content of other people’s speech. These children could use technology to process emotions in speech data, perhaps in the form of an app. 

As another example, conveying emotions in the language translation and speech-to-text industries can benefit from the implications of successful emotion classification.


# Workflow

The entire project can be divided into several steps. We first preprocessed our data to clean it up. Then, we extracted two types of features. Next, using the audio and the image representations, we implemented two separate models. Finally, we compared the performance of our models  to each other and to human rater performance.

![Screen Shot 2022-06-04 at 10 59 44 PM](https://user-images.githubusercontent.com/35503370/172033116-a96f66c7-2e38-4c1c-9911-21472e3a78a4.png)


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

![Screen Shot 2022-06-04 at 11 02 13 PM](https://user-images.githubusercontent.com/35503370/172033161-617784fa-78d1-45fd-b9b3-56027a90829a.png)

### Feature Extraction (Spectrogram (Librosa ):

A spectrogram of an audio file is a “heat map” image depicting which sound frequencies were most prevalent at different times in the clip. We used the Librosa package to produce spectrograms. This approach has several advantages. In the first place, every spectrogram has the same size of 219x269 pixels regardless of duration. The second is that we can use powerful image processing techniques such as neural networks. The disadvantage is that they are not as easily interpretable as the mid features, and neural nets are computationally expensive.

# Models

### Model 1: Classifying emotions using Mid Features and SVMs:
We used the mid features to train a support vector machine. We also tried to detect which mid features are most relevant in emotion classification. To that end, we trained another SVM using principal components without much success. Without PCA, the model accurately predicted the emotions of 45% of audio files in the test set. This is 4% better than the accuracy of the human raters in the original CREMA-D experiment, as their average accuracy for all emotions was 41%.

We also experimented using different subsets of emotion categories to mimic what happens if a human rater had fewer options to choose.  We observed that as the number of emotion categories decreased, the classifying accuracy improved, even as high as 90% when classifying two specific emotions.

![class](https://user-images.githubusercontent.com/35503370/172033039-cab3207f-50ba-4ea2-a161-727ab54a371c.png)


### Model 2: Classifying emotions using Spectrograms and CNNs:

We trained a convolutional neural network on the spectrogram features. Because we only had about 4900 spectrograms in the training set, we were concerned about overfitting. To alleviate this, we experimented with several data augmentation techniques, such as adding a dropout layer, or adding a preprocessing step where we randomly shift the training data vertically and horizontally before feeding it to the neural net.

![architecture](https://user-images.githubusercontent.com/35503370/172032962-89766465-0a64-4aa8-8ad6-33ca4a851b69.png)


During training, our final model achieved around 50% validation accuracy. However, the model reached only 42% test accuracy. This is slightly worse than our SVM model, but still 1% better than the accuracy of the human raters in the CREMA-D experiment.

![accuracy](https://user-images.githubusercontent.com/35503370/172033004-09546299-d59e-4a6b-a99f-40e48c5a6470.png)



# Comparing models to human performance:

Here, we compare the recall of the human raters, the SVM, and the CNN in each of the six emotions. For example, the bars above “neutral” show what percentage of the neutral audio files were classified correctly. It seems that the SVM performed similarly to the human raters, but the CNN exhibited different behavior. The SVM performed highest for Anger and Neutral, similar to the human raters, but the CNN performed highest for the Anger and Sad emotion categories.

![model summary](https://user-images.githubusercontent.com/35503370/172032791-133ff77c-cb05-42aa-bee4-49f75d1f657b.png)


# Conclusions/Further directions

Overall, with machine learning techniques, we were able to replicate human-like performance. Of the two machine learning models, the recall of the SVM resembles the human rater recall more closely. We speculate that this is due to the difference between the kind of features used in training. Specifically, we believe this is because mid features better approximate how humans perceive speech.

In the future, we are interested in training the SVM model on a dataset in which the labels are determined only by human raters, not by the speaker’s intended emotion. We are also interested in extracting mid features on the level of individual words, rather than the whole sentence. This would enable us to account for nuances within word segments. Finally, another possible direction is to use more naturally occurring data that is not staged by actors, such as phone conversations.

# Acknowledgement of the authors of the dataset.

We are grateful to the **authors who developed the CREMA dataset**.
We are also grateful to our **Mentor Akul Dewan**, and the **Erdős Institute Team!**



# Team Members' Personal Links
https://www.linkedin.com/in/elfnrpyrz/

https://www.linkedin.com/in/mario-gomez-flores

http://nooranidoost.com/

www.linkedin.com/in/tajudeen-mamadou 

https://math.wfu.edu/people-faculty



