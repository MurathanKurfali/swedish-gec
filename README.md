# MT-based Grammatical Error Correction for Swedish

This repository contains the code and resources for a distantly supervised Grammatical Error Detection/Correction system for Swedish. The system utilizes a neural network-based model trained on a large corpus of Swedish text.

## Prerequisites

- Python 3.7 or higher
- SentencePiece
- OpenNMT==2.3.0

## Usage

1. Clone the repository:
git clone https://github.com/your-username/grammatical-error-detection-swedish.git

2. Download the model:
Download the model from ["Google Drive"](https://drive.google.com/drive/folders/1VEtTYgtrW9WRJw0Owp8aQl_nADcwvgyr?usp=share_link).

3. Run the script to process your input:

bash correct.sh <model_path> <input_file> <output_directory>

- `<model_path>`: Path to the pre-trained model file.
- `<input_file>`: Path to the input file to be processed.
- `<output_directory>`: Path to the directory where the output files will be saved.

The input file should follow the "one sentence per line" format.


## Bibtex Citation
If you use this system or find it helpful, please consider citing the accompanying paper:
```
@inproceedings{kurfali2023distantly,
  title={A distantly supervised Grammatical Error Detection/Correction system for Swedish},
  author={Kurfal{\i}, Murathan and {\"O}stling, Robert},
  booktitle={Swedish Language Technology Conference and NLP4CALL},
  pages={35--39},
  year={2023}
}
```

