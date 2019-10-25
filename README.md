# Applied Natural Language Processing in EdTech

This repository contains all necessary materials to succesfuly complete this workshop. In this intermediate level workshop, you will learn to apply NLP to one piece of a real-world problem in education technology by building a model to predict the type of answer (e.g. entity, description, number, etc.) a question elicits. Specifically, you will learn to: 

- Perform preprocessing, normalization, and exploratory analysis on a question dataset,
- Identify salient linguistic features of natural language questions, and
- Experiment with different feature sets and models to predict the answer type.

The concepts will be taught using popular NLP and ML packages like **SpaCy**, **Scikit Learn**, and **Tensorflow**.


# Outcome


# Pre-requisites 
- Python 3.x
- We strongly recommend that you use a virtual environment to avoid dependency/version conflicts.

- If you use `conda`, you can use the following commands to create a new environment for this workshop:
```
#####################################################
# Create workshop-specific environment and install  #
# requirements with pip.                            #
#####################################################

ENV_NAME="course_hero_odsc"
conda create -n $ENV_NAME python=3.7 pip --yes
source activate $ENV_NAME

PIP="$CONDA_PREFIX/bin/pip"
"$PIP" install -r requirements.txt

#########################################
# Download SpaCy model and WordNet data #
#########################################
python -m spacy download en_core_web_md
python -c "import nltk;nltk.download('wordnet')"
```
- If not, run `pip install -r requirements.txt` followed by the following two python commands:

  - Download the SpaCy model: `python -m spacy download en_core_web_md`
  - Download WordNet data from NLTK: `python -c "import nltk;nltk.download('wordnet')"`

# Modules

This workshop is divided into several modules that must be completed in sequence. The first  module introduces the problem space, scope and where this can be applied in the real world. This module will also contain slides and other materials that will enable the attendee to get started with the workshop. This is followed by some eploratory analysis and feature engineering modules, a third module to train and evaluate machine learning models using scikit learn and the final module will expose you to more advanced deep learning models to perform multi class classification of questions. Here is a detailed breakdown of the modules - 

### Module 0 - Introduction

1. Introduction, Problem and Scope
2. Applications of this problem in real-world
3. Environment set-up


### Module 1 - [Exploratory (Text) Data Analysis](https://github.com/coursehero/ai-odsc-workshop-2019/blob/dev/Module%201-Exploratory%20Data%20Analysis.ipynb)

1. Preprocessing text using spaCy
2. Exploratory Data Analysis 
3. Visualizing text data 

### Module 2 - [Feature Extraction & Maximum Entropy Model](https://github.com/coursehero/ai-odsc-workshop-2019/blob/dev/Module%202-Feature%20Extraction%20and%20Classification.ipynb)

1. Feature Engineering on question data set
2. Training a machine learning model using Scikit Learn
3. Model evaluation


### Module 3 - [Deep Representation Models](https://github.com/coursehero/ai-odsc-workshop-2019/blob/dev/Module%203-Deep%20Learning%20Classification.ipynb)

1. Learning question representations
2. Model evaluation
