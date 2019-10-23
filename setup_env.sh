#!/bin/bash

#
# Setup script to create environment for Course Hero ODSC workshop.
# Steps:
#         1. Check OS details
#         2. Download the appropriate Miniconda installer
#         3. Install Miniconda
#         4. Create a new conda environment 'course_hero_odsc'
#         5. pip install requirements
#         6. Download required model/corpus
#


set -e

##################################
# Download and Install Miniconda #
##################################

#
# OS check
#
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     MACHINE=Linux;;
    Darwin*)    MACHINE=Mac;;
    CYGWIN*)    MACHINE=Cygwin;;
    MINGW*)     MACHINE=MinGw;;
    *)          MACHINE="UNKNOWN:${unameOut}"
esac


#############################
# Get the correct installer #
#############################

UNAME="$(uname -m)"
XBIT="$(echo $UNAME | awk -F'_' '{print $2}')"
if [ "$MACHINE" = "Mac" ]; then
  DL_LINK="https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh"
elif [ "$MACHINE" = "Linux" ]; then
  if [ "$XBIT" = "64"]; then
    DL_LINK="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
  else
    DL_LINK="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86.sh"
  fi
else
	echo "Unsupported operating system: '$MACHINE'"
fi

curl $DL_LINK > conda_install_script.sh
bash conda_install_script.sh
rm conda_install_script.sh


#####################################################
# Create workshop-specific environment and install  #
# requirements with pip.                            #
#####################################################

ENV_NAME="course_hero_odsc"
conda create -n $ENV_NAME python=3.7 pip
source activate $ENV_NAME

PIP="$CONDA_PREFIX/bin/pip"
"$PIP" install -r requirements.txt

#########################################
# Download SpaCy model and WordNet data #
#########################################

python -m spacy download en_core_web_md
python -c "import nltk;nltk.download('wordnet')"

echo "Successfully created your environment!"
