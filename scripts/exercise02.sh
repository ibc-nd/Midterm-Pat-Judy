#Command used to  produce a table that saves structured, hit results from searching the hsp70profile.hmm against proteoma_01
hmmsearch -o dump.txt --tblout hsp70_proteome_01.tbl results/exercise01/hsp70profile.hmm proteomes/proteome_01.fasta

#Command used to identify the number of significant hits from hsp70_proteome_01.tbl
grep -v "^#" results/exercise02/hsp70_proteome_01.tbl | awk '$5 < 0.001' | wc -l
#Four signficant hits were found. E-value represents the expected number of false positives you would expect to see by chance in a database search. A low E-value indicates that a hit is real. We apply a threshold (<0.001) to establish a baseline for statistical significance.
 

