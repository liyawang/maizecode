# Convert chromosome names
## In case chromosome names are labeled as 'Chr01', 'Chr02', ..., Convert them to numbers only, and do the same for the annotation file

    sed -i 's/Chr0//g' genome.fa 
    sed -i 's/Chr//g' genome.fa

# Normalize the reference sequence

    mv genome.fa genome0.fa
    java -jar picard-tools-1.141/picard.jar NormalizeFasta I=genome0.fa O=genome.fa

# Convert the annotation file

    gffread -T Zea_mays.AGPv4.33.gff3 -o Zea_mays.AGPv4.33.gtf

# Then start the index

    STAR --runMode genomeGenerate --genomeDir ./ --genomeFastaFiles Zea_mays.AGPv4.dna.toplevel.fa --sjdbGTFfile Zea_mays.AGPv4.33.gtf --runThreadN 12
