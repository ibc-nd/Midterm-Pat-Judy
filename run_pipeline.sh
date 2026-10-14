#Creates a multiple sequences alignment for all hsp70 proteins by indicating insertions and d>
#so all rows are equal length.
muscle -align combined_hsp70.fasta -output hsp70_aligned.afa

#HMMprofile using hmmbuild from  alignment in 1a
hmmbuild hsp70profile.hmm hsp70_aligned.afa
