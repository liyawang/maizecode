
# cd /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/DJ/062819_data/homer_v4_star
cd /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/DJ/062819_data/homer_v4_star_0.85

#the default fdr is 0.001

findPeaks RA1_GFP-IP_rep1_tagDir -style factor -gsize 2.2e9 -fdr 0.05 -i RA1_Input_rep1_tagDir -o ../homer_peaks_star_0.85/RA1_rep1_peaks.txt
findPeaks CT_RA1_GFP-IP_rep1_tagDir -style factor -gsize 2.2e9 -fdr 0.05 -i CT_RA1_Input_rep1_tagDir -o ../homer_peaks_star_0.85/CT_RA1_rep1_peaks.txt
findPeaks WUS1_RFP-IP_rep1_tagDir -style factor -gsize 2.2e9 -fdr 0.05 -i WUS1_Input_rep1_tagDir -o ../homer_peaks_star_0.85/WUS1_rep1_peaks.txt
findPeaks CT_WUS1_RFP-IP_rep1_tagDir -style factor -gsize 2.2e9 -fdr 0.05 -i CT_WUS1_Input_rep1_tagDir -o ../homer_peaks_star_0.85/CT_WUS1_rep1_peaks.txt
findPeaks ZFHD_RFP-IP_rep1_tagDir -style factor -gsize 2.2e9 -fdr 0.05 -i ZFHD_Input_rep1_tagDir -o ../homer_peaks_star_0.85/ZFHD_rep1_peaks.txt
findPeaks CT_ZFHD_RFP-IP_rep1_tagDir -style factor -gsize 2.2e9 -fdr 0.05 -i CT_ZFHD_Input_rep1_tagDir -o ../homer_peaks_star_0.85/CT_ZFHD_rep1_peaks.txt



findPeaks RA1_GFP-IP_rep2_tagDir -style factor -gsize 2.2e9 -fdr 0.05 -i RA1_Input_rep2_tagDir -o ../homer_peaks_star_0.85/RA1_rep2_peaks.txt
findPeaks CT_RA1_GFP-IP_rep2_tagDir -style factor -gsize 2.2e9 -fdr 0.05 -i CT_RA1_Input_rep2_tagDir -o ../homer_peaks_star_0.85/CT_RA1_rep2_peaks.txt
findPeaks WUS1_RFP-IP_rep2_tagDir -style factor -gsize 2.2e9 -fdr 0.05 -i WUS1_Input_rep2_tagDir -o ../homer_peaks_star_0.85/WUS1_rep2_peaks.txt
findPeaks CT_WUS1_RFP-IP_rep2_tagDir -style factor -gsize 2.2e9 -fdr 0.05 -i CT_WUS1_Input_rep2_tagDir -o ../homer_peaks_star_0.85/CT_WUS1_rep2_peaks.txt
findPeaks ZFHD_RFP-IP_rep2_tagDir -style factor -gsize 2.2e9 -fdr 0.05 -i ZFHD_Input_rep2_tagDir -o ../homer_peaks_star_0.85/ZFHD_rep2_peaks.txt
findPeaks CT_ZFHD_RFP-IP_rep2_tagDir -style factor -gsize 2.2e9 -fdr 0.05 -i CT_ZFHD_Input_rep2_tagDir -o ../homer_peaks_star_0.85/CT_ZFHD_rep2_peaks.txt


findPeaks RA1_GFP-IP_rep1_tagDir -style factor -size 274 -gsize 2.2e9 -fdr 0.05 -LP 0.001 -i RA1_Input_rep1_tagDir -o ../homer_peaks_star_0.85/RA1_rep1_peaks_sm_LP.txt
findPeaks RA1_GFP-IP_rep1_tagDir -style factor -size 274 -gsize 2.2e9 -fdr 0.05 -i RA1_Input_rep1_tagDir -o ../homer_peaks_star_0.85/RA1_rep1_peaks_sm.txt
findPeaks CT_RA1_GFP-IP_rep1_tagDir -style factor -size 204 -gsize 2.2e9 -fdr 0.05 -i CT_RA1_Input_rep1_tagDir -o ../homer_peaks_star_0.85/CT_RA1_rep1_peaks_sm.txt

findPeaks RA1_GFP-IP_rep2_tagDir -style factor -size 216 -gsize 2.2e9 -fdr 0.05 -i RA1_Input_rep2_tagDir -o ../homer_peaks_star_0.85/RA1_rep2_peaks_sm.txt
findPeaks CT_RA1_GFP-IP_rep2_tagDir -style factor -size 201 -gsize 2.2e9 -fdr 0.05 -i CT_RA1_Input_rep2_tagDir -o ../homer_peaks_star_0.85/CT_RA1_rep2_peaks_sm.txt


