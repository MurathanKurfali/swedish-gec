#!/bin/bash

# Check if the required arguments are provided
if [ $# -ne 3 ]; then
  echo "Usage: $0 <model_path> <input_path> <output_path>"
  exit 1
fi

model_path=$1
input_path=$2
output_path=$3

# Check if the output folder exists, and create it if necessary
if [ ! -d "${output_path}" ]; then
  echo "Creating output folder: ${output_path}"
  mkdir -p "${output_path}"
  echo "Output folder created!"
fi

# Extract the filename from the input path
filename="${input_path##*/}"

# Encode the input file using SentencePiece
echo "Encoding input file..."
spm_encode --model=vocab/all_data.spm.model --output_format=piece < "${input_path}" > "${output_path}/${filename}.spm"
echo "Encoding done!"

# Run the grammatical error correction model
echo "Running the grammatical error correction model: ${model_path}"
if command -v nvidia-smi &> /dev/null; then
  echo "GPU detected. Running with GPU support."
  onmt_translate --model "${model_path}" --src "${output_path}/${filename}.spm" --gpu --verbose --batch_size 100 --output "${output_path}/${filename}.corrected.spm"
else
  echo "No GPU detected. Running on CPU."
  onmt_translate --model "${model_path}" --src "${output_path}/${filename}.spm" --verbose --batch_size 100 --output "${output_path}/${filename}.corrected.spm"
fi
echo "Grammatical error correction done!"

# Decode the corrected output using SentencePiece
echo "Decoding corrected output..."
spm_decode --model=vocab/all_data.spm.model --input_format=piece < "${output_path}/${filename}.corrected.spm" > "${output_path}/${filename}_corrected"
echo "Decoding done!"

# Remove the intermediate encoded files
echo "Removing intermediate files..."
rm "${output_path}"/*.spm
echo "Intermediate files removed!"

echo "Process completed successfully."
