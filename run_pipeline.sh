#Outer Loop

For x in combined_hsp70.fasta
do
#Creates a multiple sequences alignment for all hsp70 proteins by indicating insertions and d>
#so all rows are equal length.
muscle -align $x -output $x_aligned.afa

#HMMprofile using hmmbuild from  alignment in 1a
hmmbuild $x_hmmprofile.hmm $x_aligned.afa

done

