ref_fasta="$1"
proteome_fasta="$2"

For x in combined_hsp70.fasta
do
#Creates a multiple sequences alignment for all hsp70 proteins by indicating insertions and d>
#so all rows are equal length.
muscle -align $x -output $x_aligned.afa

#HMMprofile using hmmbuild from  alignment in 1a
hmmbuild $x_hmmprofile.hmm $x_aligned.afa

done

for proteome in proteome_*.fasta ; do
#Command used to  produce a table that saves structured, hit results from searching the hsp70profile.hmm against proteoma_01
hmmsearch -o dump.txt --tblout hsp70_proteome_01.tbl results/exercise01/hsp70profile.hmm proteomes/proteome_01.fasta

#Command used to identify the number of significant hits from hsp70_proteome_01.tbl
grep -v "^#" results/exercise02/hsp70_proteome_01.tbl | awk '$5 < 0.001' | wc -l
#Four signficant hits were found. E-value represents the expected number of false positives you would expect to see by chance in a database search. A low E-value indicates that a hit is real. We apply a thresh>
 



