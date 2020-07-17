# Convert chromosome names
## In case chromosome names are labeled as 'Chr01', 'Chr02', ..., Convert them to numbers only, and do the same for the annotation file

    sed -i 's/Chr0//g' genome.fa 
    sed -i 's/Chr//g' genome.fa

# Normalize the reference sequence

    mv genome.fa genome0.fa
    java -jar picard-tools-1.141/picard.jar NormalizeFasta I=genome0.fa O=genome.fa

# Convert the annotation file

    gffread -T Zea_mays.AGPv4.33.gff3 -o annotation.gtf

# Then start the index
## Make sure the genome file is named as 'genome.fa' and the annotation file is named as 'annotation.gtf'

    STAR --runMode genomeGenerate --genomeDir ./ --genomeFastaFiles genome.fa --sjdbGTFfile annotation.gtf --runThreadN 12

# Upload to CyVerse
## local_directory is B73 or NC350 or Til11 or W22. genome.fa, annotation.gtf, and index files should be under /local_directory without sub-folders.

    iput -P -K -f --retries 3 --lfrestart checkpoint_file /local_directory /iplant/home/shared/maizecode/misc/indexFiles
