#Command used to  produce a table that saves structured, hit results from searching the hsp70profile.hmm against proteoma_01
hmmsearch -o dump.txt --tblout hsp70_proteome_01.tbl results/exercise01/hsp70profile.hmm proteomes/proteome_01.fasta
