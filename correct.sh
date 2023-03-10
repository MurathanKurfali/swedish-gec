#!/bin/bash

model_path=$1
input_file=$2
output_path=$3

spm_vocab_path="vocab/swe-gec.spm.model" ## change this if you move the spm vocabulary folder

if [ "$#" -eq 3 ]; then
	output_path=$3
elif [ "$#" -eq 2 ]; then
	output_path="${input_file}.corr"
else
    echo "Illegal number of parameters"
    echo "Sample usage: "
    exit
fi

tmp_folder="_tmp_files"
filename="${input_file##*/}"
mkdir $tmp_folder

num_gpu=$(python - <<EOF
import torch
print(torch.cuda.device_count()-1)
EOF
)

if [[ $num_gpu < 0 ]]; then
  echo "No GPU detected. The model will run on CPU"
else
    echo "GPU detected."
fi


spm_encode --model=${spm_vocab_path} --output_format=piece < ${input_file} > ${tmp_folder}/"${filename}.spm"
echo "encoding done!"

echo "running the model: ${model_path}"
onmt_translate --model ${model_path} --src ${tmp_folder}/"${filename}.spm" --gpu ${num_gpu} --verbose --batch_size 100  --output ${tmp_folder}/"${filename}.predicted.spm"
echo "Correction done"

spm_decode --model=${spm_vocab_path} --input_format=piece < ${tmp_folder}/"${filename}.predicted.spm" > ${output_path}
echo "Decoding done"
rm -rf ${tmp_folder}


