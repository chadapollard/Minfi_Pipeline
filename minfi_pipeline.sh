script_base=/data/sperm-qt/ # use '/' at end
additional_files_base="${script_base}additional_files/"
minfi_script="${script_base}src/array_preprocessing.R"
sperm_age_script="${script_base}src/calc_sperm_age.R"
# stability_script="${script_base}src/calculate_variability.py"
merge_script="${script_base}src/merge_data.py"
sperm_age_model="${additional_files_base}GLA_Model.rds"


# batch info
name=neogen
sample_sheet=Neogen_Sample_Sheet.csv # i always get errors in minfi unless explicitly name the sample_sheet
base_dir="/data/${name}/" # use '/' at end
#base_dir="/data/fazst/"
input_dir=$base_dir
output_dir=$base_dir
#sample_sheet=Inherent_Infinium_MethyEPIC_QC_Report_${name}.csv
sample_sheet_path=$base_dir$sample_sheet
mvals="${base_dir}${name}_m_values.csv"

###########
## MINFI ##
###########
echo ""
echo "**** RUNNING MINFI SCRIPT ****"
echo ""

Rscript $minfi_script --model $sperm_age_model --sperm_age_script $sperm_age_script --input_dir $input_dir --output_dir $output_dir --sample_sheet $sample_sheet --name $name --betas --mvals --analyze

# ######################
# ## STABILITY SCORES ##
# ######################
# echo ""
# echo "**** RUNNING STABILITY SCRIPT ****"
# echo ""

# python $stability_script --output_dir $output_dir --name $name --mvals $mvals --cutoffs $additional_files_base"all_promoters_no_tx_FAZST.csv" --overlap $additional_files_base"promoters_epic_overlap.tsv" 

# python $stability_script --output_dir $output_dir --name $name --mvals $mvals --cutoffs $additional_files_base"all_promotors_IUI.csv" --overlap $additional_files_base"promoters_epic_overlap.tsv"

# python $stability_script --output_dir $output_dir --name $name --mvals $mvals --cutoffs $additional_files_base"top_1000_no_tx_FAZST.csv" --overlap $additional_files_base"promoters_epic_overlap.tsv"

# python $stability_script --output_dir $output_dir --name $name --mvals $mvals --cutoffs $additional_files_base"top_1000_IUI.csv" --overlap $additional_files_base"promoters_epic_overlap.tsv"

# python $stability_script --output_dir $output_dir --name $name --mvals $mvals --cutoffs $additional_files_base"top_1230_no_tx_FAZST.csv" --overlap $additional_files_base"promoters_epic_overlap.tsv"

# python $stability_script --output_dir $output_dir --name $name --mvals $mvals --cutoffs $additional_files_base"top_1230_IUI.csv" --overlap $additional_files_base"promoters_epic_overlap.tsv"

# # this is the new stability file after fixing DLK1 values
# python $stability_script --output_dir $output_dir --name $name --mvals $mvals --cutoffs $additional_files_base"top_1233_IUI.csv" --overlap $additional_files_base"promoters_epic_overlap.tsv"

# ################
# ## MERGE DATA ##
# ################
# echo ""
# echo "**** MERGING DATA ****"
# echo ""
# python $merge_script --input_dir $input_dir --output_dir $output_dir --name $name --stability_suffix _stability_scores.csv --minfi_suffix _minfi_results.csv --sample_sheet $sample_sheet_path
