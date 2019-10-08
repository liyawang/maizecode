#!/bin/bash
# specify BASH shell
#$ -S /bin/bash
#$ -N MaizeTF_homerPeaks_v4_10chr_q40.DJnew
# run job in the current working directory where qsub is executed from
#$ -cwd
# specify that the job requires 16GB of memory
#$ -l m_mem_free=8G
#$ -pe threads 8
# help scheduling if you know how long job will run (here: 2 hours, 30 min, zero secs)
#$ -e /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/DJ/062819_data/err
#$ -o /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/DJ/062819_data/out

cd /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/DJ/062819_data/homer_v4_q40_r2_markDup_10chr




# move forward with peaks generated with this run
findPeaks RA1_GFP-IP_rep1_tagDir -style factor -gsize 2.2e9  -i RA1_Input_rep1_tagDir -F 6 -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/RA1_rep1_peaks_q40_F6L2LP.txt
findPeaks CT_RA1_GFP-IP_rep1_tagDir -style factor -gsize 2.2e9 -i CT_RA1_Input_rep1_tagDir -F 6 -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/CT_RA1_rep1_peaks_q40_F6L2LP.txt
findPeaks WUS1_RFP-IP_rep1_tagDir -style factor -gsize 2.2e9 -i WUS1_Input_rep1_tagDir -F 6 -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/WUS1_rep1_q40_F6L2LP.txt
findPeaks CT_WUS1_RFP-IP_rep1_tagDir -style factor -gsize 2.2e9 -i CT_WUS1_Input_rep1_tagDir -F 6 -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/CT_WUS1_rep1_q40_F6L2LP.txt
findPeaks ZFHD_RFP-IP_rep1_tagDir -style factor -gsize 2.2e9 -i ZFHD_Input_rep1_tagDir -F 6 -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/ZFHD_rep1_q40_F6L2LP.txt
findPeaks CT_ZFHD_RFP-IP_rep1_tagDir -style factor -gsize 2.2e9 -i CT_ZFHD_Input_rep1_tagDir -F 6 -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/CT_ZFHD_rep1_q40_F6L2LP.txt

findPeaks RA1_GFP-IP_rep2_tagDir -style factor -gsize 2.2e9  -i RA1_Input_rep2_tagDir -F 6 -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/RA1_rep2_peaks_q40_F6L2LP.txt
findPeaks CT_RA1_GFP-IP_rep2_tagDir -style factor -gsize 2.2e9 -i CT_RA1_Input_rep2_tagDir -F 6 -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/CT_RA1_rep2_peaks_q40_F6L2LP.txt
findPeaks WUS1_RFP-IP_rep2_tagDir -style factor -gsize 2.2e9 -i WUS1_Input_rep2_tagDir -F 6 -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/WUS1_rep2_q40_F6L2LP.txt
findPeaks CT_WUS1_RFP-IP_rep2_tagDir -style factor -gsize 2.2e9 -i CT_WUS1_Input_rep2_tagDir -F 6 -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/CT_WUS1_rep2_q40_F6L2LP.txt
findPeaks ZFHD_RFP-IP_rep2_tagDir -style factor -gsize 2.2e9 -i ZFHD_Input_rep2_tagDir -F 6 -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/ZFHD_rep2_q40_F6L2LP.txt
findPeaks CT_ZFHD_RFP-IP_rep2_tagDir -style factor -gsize 2.2e9 -i CT_ZFHD_Input_rep2_tagDir -F 6 -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/CT_ZFHD_rep2_q40_F6L2LP.txt

# findPeaks RA1_GFP-IP_rep1_tagDir -style factor -gsize 2.2e9  -i RA1_Input_rep1_tagDir -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/RA1_rep1_peaks_q40_F4L2LP.txt
# findPeaks CT_RA1_GFP-IP_rep1_tagDir -style factor -gsize 2.2e9 -i CT_RA1_Input_rep1_tagDir -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/CT_RA1_rep1_peaks_q40_F4L2LP.txt
# findPeaks WUS1_RFP-IP_rep1_tagDir -style factor -gsize 2.2e9 -i WUS1_Input_rep1_tagDir -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/WUS1_rep1_q40_F4L2LP.txt
# findPeaks CT_WUS1_RFP-IP_rep1_tagDir -style factor -gsize 2.2e9 -i CT_WUS1_Input_rep1_tagDir -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/CT_WUS1_rep1_q40_F4L2LP.txt
# findPeaks ZFHD_RFP-IP_rep1_tagDir -style factor -gsize 2.2e9 -i ZFHD_Input_rep1_tagDir -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/ZFHD_rep1_q40_F4L2LP.txt
# findPeaks CT_ZFHD_RFP-IP_rep1_tagDir -style factor -gsize 2.2e9 -i CT_ZFHD_Input_rep1_tagDir -F 6 -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/CT_ZFHD_rep1_q40_F4L2LP.txt
# 
# findPeaks RA1_GFP-IP_rep2_tagDir -style factor -gsize 2.2e9  -i RA1_Input_rep2_tagDir -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/RA1_rep2_peaks_q40_F4L2LP.txt
# findPeaks CT_RA1_GFP-IP_rep2_tagDir -style factor -gsize 2.2e9 -i CT_RA1_Input_rep2_tagDir -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/CT_RA1_rep2_peaks_q40_F4L2LP.txt
# findPeaks WUS1_RFP-IP_rep2_tagDir -style factor -gsize 2.2e9 -i WUS1_Input_rep2_tagDir -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/WUS1_rep2_q40_F4L2LP.txt
# findPeaks CT_WUS1_RFP-IP_rep2_tagDir -style factor -gsize 2.2e9 -i CT_WUS1_Input_rep2_tagDir -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/CT_WUS1_rep2_q40_F4L2LP.txt
# findPeaks ZFHD_RFP-IP_rep2_tagDir -style factor -gsize 2.2e9 -i ZFHD_Input_rep2_tagDir -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/ZFHD_rep2_q40_F4L2LP.txt
# findPeaks CT_ZFHD_RFP-IP_rep2_tagDir -style factor -gsize 2.2e9 -i CT_ZFHD_Input_rep2_tagDir -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/CT_ZFHD_rep2_q40_F4L2LP.txt
# 

# findPeaks RA1_GFP-IP_rep1_tagDir -style factor -gsize 2.2e9  -i RA1_Input_rep1_tagDir -o ../homer_peaks_v4_q40_r2_markDup_10chr/RA1_rep1_peaks_q40.txt
# findPeaks CT_RA1_GFP-IP_rep1_tagDir -style factor -gsize 2.2e9 -i CT_RA1_Input_rep1_tagDir -o ../homer_peaks_v4_q40_r2_markDup_10chr/CT_RA1_rep1_peaks_q40.txt
# findPeaks WUS1_RFP-IP_rep1_tagDir -style factor -gsize 2.2e9 -i WUS1_Input_rep1_tagDir -o ../homer_peaks_v4_q40_r2_markDup_10chr/WUS1_rep1_q40.txt
# findPeaks CT_WUS1_RFP-IP_rep1_tagDir -style factor -gsize 2.2e9 -i CT_WUS1_Input_rep1_tagDir -o ../homer_peaks_v4_q40_r2_markDup_10chr/CT_WUS1_rep1_q40.txt
# findPeaks ZFHD_RFP-IP_rep1_tagDir -style factor -gsize 2.2e9 -i ZFHD_Input_rep1_tagDir -o ../homer_peaks_v4_q40_r2_markDup_10chr/ZFHD_rep1_q40.txt
# findPeaks CT_ZFHD_RFP-IP_rep1_tagDir -style factor -gsize 2.2e9 -i CT_ZFHD_Input_rep1_tagDir -o ../homer_peaks_v4_q40_r2_markDup_10chr/CT_ZFHD_rep1_q40.txt
# 
# findPeaks RA1_GFP-IP_rep2_tagDir -style factor -gsize 2.2e9  -i RA1_Input_rep2_tagDir -o ../homer_peaks_v4_q40_r2_markDup_10chr/RA1_rep2_peaks_q40.txt
# findPeaks CT_RA1_GFP-IP_rep2_tagDir -style factor -gsize 2.2e9 -i CT_RA1_Input_rep2_tagDir -o ../homer_peaks_v4_q40_r2_markDup_10chr/CT_RA1_rep2_peaks_q40.txt
# findPeaks WUS1_RFP-IP_rep2_tagDir -style factor -gsize 2.2e9 -i WUS1_Input_rep2_tagDir -o ../homer_peaks_v4_q40_r2_markDup_10chr/WUS1_rep2_q40.txt
# findPeaks CT_WUS1_RFP-IP_rep2_tagDir -style factor -gsize 2.2e9 -i CT_WUS1_Input_rep2_tagDir -o ../homer_peaks_v4_q40_r2_markDup_10chr/CT_WUS1_rep2_q40.txt
# findPeaks ZFHD_RFP-IP_rep2_tagDir -style factor -gsize 2.2e9 -i ZFHD_Input_rep2_tagDir -o ../homer_peaks_v4_q40_r2_markDup_10chr/ZFHD_rep2_q40.txt
# findPeaks CT_ZFHD_RFP-IP_rep2_tagDir -style factor -gsize 2.2e9 -i CT_ZFHD_Input_rep2_tagDir -o ../homer_peaks_v4_q40_r2_markDup_10chr/CT_ZFHD_rep2_q40.txt
# 
# 
# findPeaks RA1_GFP-IP_rep1_tagDir -style factor -gsize 2.2e9  -i RA1_Input_rep1_tagDir -F 8 -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/RA1_rep1_peaks_q40_F8L2LP.txt
# findPeaks CT_RA1_GFP-IP_rep1_tagDir -style factor -gsize 2.2e9 -i CT_RA1_Input_rep1_tagDir -F 8 -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/CT_RA1_rep1_peaks_q40_F8L2LP.txt
# findPeaks WUS1_RFP-IP_rep1_tagDir -style factor -gsize 2.2e9 -i WUS1_Input_rep1_tagDir -F 8 -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/WUS1_rep1_q40_F8L2LP.txt
# findPeaks CT_WUS1_RFP-IP_rep1_tagDir -style factor -gsize 2.2e9 -i CT_WUS1_Input_rep1_tagDir -F 8 -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/CT_WUS1_rep1_q40_F8L2LP.txt
# findPeaks ZFHD_RFP-IP_rep1_tagDir -style factor -gsize 2.2e9 -i ZFHD_Input_rep1_tagDir -F 8 -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/ZFHD_rep1_q40_F8L2LP.txt
# findPeaks CT_ZFHD_RFP-IP_rep1_tagDir -style factor -gsize 2.2e9 -i CT_ZFHD_Input_rep1_tagDir -F 8 -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/CT_ZFHD_rep1_q40_F8L2LP.txt
# 
# findPeaks RA1_GFP-IP_rep2_tagDir -style factor -gsize 2.2e9  -i RA1_Input_rep2_tagDir -F 8 -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/RA1_rep2_peaks_q40_F8L2LP.txt
# findPeaks CT_RA1_GFP-IP_rep2_tagDir -style factor -gsize 2.2e9 -i CT_RA1_Input_rep2_tagDir -F 8 -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/CT_RA1_rep2_peaks_q40_F8L2LP.txt
# findPeaks WUS1_RFP-IP_rep2_tagDir -style factor -gsize 2.2e9 -i WUS1_Input_rep2_tagDir -F 8 -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/WUS1_rep2_q40_F8L2LP.txt
# findPeaks CT_WUS1_RFP-IP_rep2_tagDir -style factor -gsize 2.2e9 -i CT_WUS1_Input_rep2_tagDir -F 8 -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/CT_WUS1_rep2_q40_F8L2LP.txt
# findPeaks ZFHD_RFP-IP_rep2_tagDir -style factor -gsize 2.2e9 -i ZFHD_Input_rep2_tagDir -F 8 -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/ZFHD_rep2_q40_F8L2LP.txt
# findPeaks CT_ZFHD_RFP-IP_rep2_tagDir -style factor -gsize 2.2e9 -i CT_ZFHD_Input_rep2_tagDir -F 8 -L 2 -LP 0.001 -o ../homer_peaks_v4_q40_r2_markDup_10chr/CT_ZFHD_rep2_q40_F8L2LP.txt
# 
# 