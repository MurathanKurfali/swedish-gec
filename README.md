# MT-based Grammatical Error Correction for Swedish

This repository contains resources for a machine learning model for grammatical error correction of Swedish text. The model is based on machine translation techniques, and is trained on a dataset of automatically generated error-corrected sentence pairs.

## Requirements

All required dependencies are listed in the requirements.txt file. To install them, run the following command:

```
pip install -r requirements.txt
```

## Model
The model is implemented using the [OpenNMT-py](https://github.com/OpenNMT/OpenNMT-py) library, based on the transformer-base model. You can find the pre-trained model and its configuration file here:
https://drive.google.com/drive/folders/1VEtTYgtrW9WRJw0Owp8aQl_nADcwvgyr

## Usage

You can use the model to correct grammatical errors in Swedish text by running the following command:

```
./correct.sh [path-to-trained-model] [path-to-input] [path-to-output](optional)
```
This script automatically detects if a GPU is available and uses it for processing, otherwise it uses the CPU.
