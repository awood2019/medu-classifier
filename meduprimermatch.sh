#determining if coral primers match medusozoan sequences

mamba activate bioinformatics #activate environment
cd ~/Desktop/AW/data/primer-matches #set current directory
ls #list directory contents

#identifies only the medusozoan sequences containing F and R primer with 2 or fewer mismatches
cutadapt -g CGTGAAACCGYTRRAAGGG...CGTCTTGAAACACGGACCAA -e 2 -O 10 --action=retain --trimmed-only -o retained_medu.fasta 28S-Hyd-Scy-Cub-Staur.fasta > retained_medu.txt
mv retained_medu.fasta ~/Desktop/AW/results/primer-matches
mv retained_medu.txt ~/Desktop/AW/results/primer-matches

#identifies and trims only the medusozoan sequences containing F and R primer with 2 or fewer mismatches
cutadapt -g CGTGAAACCGYTRRAAGGG...CGTCTTGAAACACGGACCAA -e 2 -O 10 --trimmed-only -o trimmed_medu.fasta 28S-Hyd-Scy-Cub-Staur.fasta > trimmed_medu.txt
mv trimmed_medu.fasta ~/Desktop/AW/results/primer-matches
mv trimmed_medu.txt ~/Desktop/AW/results/primer-matches