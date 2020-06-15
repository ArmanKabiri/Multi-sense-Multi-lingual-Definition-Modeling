#! /bin/bash

julia = /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/Embeddings--IG--/AdaGram-juliaV4/julia-0.4.7/bin/julia
models_dir = /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/Embeddings--IG--/AdaGram-juliaV4/trained-models/Multi-Lingual/
log_dir=""

$julia extract_AdaGram_embeddings.jl $models_dir/AdaGram-DE-Transformed-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.model $models_dir/AdaGram-DE-Transformed-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt >$log_dir/log-DE.txt &
$julia extract_AdaGram_embeddings.jl $models_dir/AdaGram-EL-Transformed-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch2.model $models_dir/AdaGram-EL-Transformed-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch2.txt >$log_dir/log-EL.txt &
wait
$julia extract_AdaGram_embeddings.jl $models_dir/AdaGram-ES-Transformed-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.model $models_dir/AdaGram-ES-Transformed-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt >$log_dir/log-ES.txt &
$julia extract_AdaGram_embeddings.jl $models_dir/AdaGram-FR-Transformed-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.model $models_dir/AdaGram-FR-Transformed-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt >$log_dir/log-FR.txt &
wait
$julia extract_AdaGram_embeddings.jl $models_dir/AdaGram-IT-Transformed-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.model $models_dir/AdaGram-IT-Transformed-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt >$log_dir/log-IT.txt &
$julia extract_AdaGram_embeddings.jl $models_dir/AdaGram-JA-Transformed-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.model $models_dir/AdaGram-JA-Transformed-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt >$log_dir/log-JA.txt &
wait
$julia extract_AdaGram_embeddings.jl $models_dir/AdaGram-NL-Transformed-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.model $models_dir/AdaGram-NL-Transformed-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt >$log_dir/log-NL.txt &
$julia extract_AdaGram_embeddings.jl $models_dir/AdaGram-RU-Transformed-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.model $models_dir/AdaGram-RU-Transformed-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt >$log_dir/log-RU.txt &

echo "Waiting for the workers"

wait

echo "DONE all workers."
