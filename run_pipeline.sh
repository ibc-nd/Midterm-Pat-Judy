#Outer loop

for x in combined_hsp70.fasta combined_mcrA.fasta
do

#Assigning variables for easier reading
y="${x}_aligned.afa"
z="{x}_profile.hmm"

#Creates a multiple sequences alignment for all hsp70 proteins by indicating insertions and d>
#so all rows are equal length.
muscle -align $x -output $y

#HMMprofile using hmmbuild from  alignment in 1a
hmmbuild $z $y

done

