#Arguments
ref_fasta="$1"
proteome_fasta="$2"

#Create csv file and write the header rows
echo "proteome,num_hits" > ${ref_fasta}_pipeline_results.csv

#Outer loop
for x in ref_sequences/$ref_fasta

do
#Assigning variables for easier reading, and preventing the filename from including the directory 
file=$(basename "$x")
y="results/exercise03/${file}_aligned.afa"
z="results/exercise03/${file}_profile.hmm"

#Creates a multiple sequences alignment for all hsp70 proteins by indicating insertions and d>
#so all rows are equal length.
muscle -align $x -output $y

#HMMprofile using hmmbuild from  alignment in 1a
hmmbuild $z $y

#Inner loop
for proteome in "$proteome_fasta"/proteome_*.fasta ; do
proteomefile=$(basename "$proteome")

#Command used to  produce a table that saves structured, hit results from searching the hsp70profile.hmm against proteoma_01
hmmsearch -o results/exercise03/dump.txt --tblout results/exercise03/${proteomefile}.tbl $z $proteome

#Command used to identify the number of significant hits from hsp70_proteome_01.tbl
num_hits=$(grep -v "^#" results/exercise03/${proteomefile}.tbl | awk '$5 < 0.001' | wc -l)

#Append the results to the pipeline_results.csv file
echo "${proteomefile},${num_hits}" >> pipeline_results.csv

done

done




