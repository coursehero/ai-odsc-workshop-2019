#!/bin/bash

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

  if [ "$XBIT" -eq 64 ]; then
    DL_LINK="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"

  else
    DL_LINK="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86.sh"

  fi

elif [ "$MACHINE" = "Cygwin" ]; then

  if [ "$XBIT" -eq 64 ]; then
    DL_LINK="https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe"

  else
    DL_LINK="https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86.exe"

  fi

else
	echo "Unsupported operating system: '$MACHINE'"
	exit
fi

if [ "$MACHINE" = "Cygwin" ]; then
  curl $DL_LINK > conda_install_script.exe
  chmod 777 conda_install_script.exe
  ./conda_install_script.exe
  rm conda_install_script.exe
else  
  curl $DL_LINK > conda_install_script.sh
  bash conda_install_script.sh -u
  rm conda_install_script.sh
  source ~/.bash_profile
fi

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



