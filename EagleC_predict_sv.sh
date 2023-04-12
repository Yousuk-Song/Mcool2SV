#!/usr/bin/bash

#micromamba activate EagleC

mcool=$1
arr=(${mcool//.mcool/ })
prefix=${arr[0]}

for i in {1..16}
do
nohup predictSV --hic-5k ${mcool}::/resolutions/5000 \
        --hic-10k ${mcool}::/resolutions/10000 \
        --hic-50k ${mcool}::/resolutions/50000 \
        -O ${prefix} -g hg19 --balance-type ICE --output-format full \
        --prob-cutoff-5k 0.8 --prob-cutoff-10k 0.8 --prob-cutoff-50k 0.99999 &
sleep 40s
done

predictSV --hic-5k ${mcool}::/resolutions/5000 \
        --hic-10k ${mcool}::/resolutions/10000 \
        --hic-50k ${mcool}::/resolutions/50000 \
        -O ${prefix} -g hg19 --balance-type ICE --output-format full \
        --prob-cutoff-5k 0.8 --prob-cutoff-10k 0.8 --prob-cutoff-50k 0.99999 &
wait

merge-redundant-SVs --full-sv-files ${prefix}.CNN_SVs.5K.txt ${prefix}.CNN_SVs.10K.txt ${prefix}.CNN_SVs.50K.txt -O ${prefix}.CNN_SVs_com
