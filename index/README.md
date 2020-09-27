# Convert chromosome names
## In case chromosome names are labeled as 'Chr01', 'Chr02', ..., Convert them to numbers only, and do the same for the annotation file

    sed -i 's/Chr0//g' genome.fa 
    sed -i 's/Chr//g' genome.fa

# Normalize the reference sequence

    mv genome.fa genome0.fa
    java -jar picard-tools-1.141/picard.jar NormalizeFasta I=genome0.fa O=genome.fa

# Convert the annotation file

    gffread -T Zea_mays.AGPv4.33.gff3 -o annotation.gtf

# Add Mt, Pt if they are not in above files
   
    iget /iplant/home/shared/maizecode/misc/indexFiles/MtPt.fa
    iget /iplant/home/shared/maizecode/misc/indexFiles/MtPt.gtf
    cat genome.fa MtPt.fa > genomenew.fa && mv genomenew.fa genome.fa
    cat annotation.gtf MtPt.gtf > annotationnew.gtf && mv annotationnew.gtf annotation.gtf
    
# Then start the index
## Make sure the genome file is named as 'genome.fa' and the annotation file is named as 'annotation.gtf'

    STAR --runMode genomeGenerate --genomeDir ./ --genomeFastaFiles genome.fa --sjdbGTFfile annotation.gtf --runThreadN 12

# Create RSEM index
Run the [RSEM_ref_prepare-1.3.0 app from SciApps](https://www.sciapps.org/login?app_id=RSEM_ref_prepare-1.3.0) using the genome.fa and annotation.gtf files.

Once this job is finished download the rsemIndex_genome.tgz file, unzip it using.

    tar -xvzf rsemIndex_genome.tgz

And put the unzipped files in the same folder as the output from STAR.

# Create an FAI index file
Run this command in the folder containing all the output files.

    samtools faidx genome.fa

# Upload to CyVerse
## Make sure that the local folder that contains all the output files is named according to this format: Zea_mays_GERMPLASM NAME
## genome.fa, annotation.gtf, and all index files should be under the local_directory folder without sub-folders.
    
    tar cvzf local_directory.tar.gz local_directory
    iput -P -K -f --retries 3 --lfrestart checkpoint_file local_directory.tar.gz /iplant/home/shared/maizecode/misc/indexFiles
