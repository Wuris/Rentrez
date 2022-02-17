# Project Info
# **GitHub user name**: Wuris
# **Date**: 2022/2/16
# **GitHub Link**: https://github.com/Wuris/Rentrez.git

ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1") # List three IDs that we want
library(rentrez)  # Load the Package
Bburg <- entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta") #Download the data from database called "nuccore", with the id we want (input into the vector called ncbi_ids), in format of fasta.

Sequences <- strsplit(Bburg, split = "\n\n", fixed = T)

print(Sequences)

Sequences <- unlist(Sequences)

header <- gsub("(^>.*sequence)\\n[ATCG].*", "\\1", Sequences)
seq <- gsub("^>.*sequence\\n([ATCG].*)", "\\1", Sequences)
Sequences <- data.frame(Name = header, Sequence = seq)

Sequences$Sequence <- gsub("\n", "", Sequences$Sequence)
write.csv(Sequences, "./Sequences.csv", row.names = F)
