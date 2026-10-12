### Usage: bash findGenes.sh refSeqDir proteomeDir outputDir 

# Create the output directory
mkdir $3

# Create alignment for McrA gene 
cat $1/mcrAgene_* > $1/ref_mcrAgenes.fasta
bin/muscle -in $1/ref_mcrAgenes.fasta -out $3/ref_mcrAgenes_aligned.fasta

# Create alignment for HSP70 gene
cat $1/hsp70gene_* > $1/ref_hsp70genes.fasta
bin/muscle -in $1/ref_hsp70genes.fasta -out $3/ref_hsp70genes_aligned.fasta

# Build hmm profile of the McrA gene 
bin/hmmbuild $3/mcrA_profile.hmm $3/ref_mcrAgenes_aligned.fasta

# Build hmm profile of the HSP70 gene
bin/hmmbuild $3/hsp70_profile.hmm $3/ref_hsp70genes_aligned.fasta


## Next, use a for loop to search each bacterial proteome and summarize matches 

#create directory to store outputs
mkdir $3/searchesMcrA
mkdir $3/searchesHSP

#create csv output to store summary values
echo "proteome,McrA_match,HSP70_match" > $3/summaryOutput.csv

for file in $2/*.fasta
do
	# Create a variable called $name to help name different outputs
	name=`echo $file | cut -d "." -f 1 | cut -d "/" -f 2`
	# Search the proteome for the McrA gene
	bin/hmmsearch --tblout $3/searchesMcrA/${name}.search $3/mcrA_profile.hmm $file
	# Search the proteome for the other gene
	bin/hmmsearch --tblout $3/searchesHSP/${name}.search $3/hsp70_profile.hmm $file
	# Count the matches of the McrA gene 
	McrA_matches=`cat $3/searchesMcrA/${name}.search | grep -v "#" | wc -l`
	# Count the matches of the McrA gene 
	HSP_matches=`cat $3/searchesHSP/${name}.search | grep -v "#" | wc -l`
	# Echo the variables into the output.csv
	echo "$name,$McrA_matches,$HSP_matches" >> $3/summaryOutput.csv
done


