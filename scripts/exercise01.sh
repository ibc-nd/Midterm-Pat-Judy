#Creates a multiple sequences alignment for all hsp70 proteins by indicating insertions and deletions via "-" notation. "-" are inserted into protein sequences 
#so all rows are equal length.
muscle -align combined_hsp70.fasta -output hsp70_aligned.afa
