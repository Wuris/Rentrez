ncbi_ids <- c("NC_045512.2") # List the ID that we want
library(rentrez)  # Load the Package
Sprotein <- entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta") #Download the data from database called "nuccore", with the id we want in format of fasta.

# Create the data frame
Sequence2 <- strsplit(Sprotein, split = "\n\n", fixed = T)
Sequence2 <- unlist(Sequence2)
header <- gsub("(^>.*genome)\\n[ATCG].*", "\\1", Sequence2)
seq <- gsub("^>.*genome\\n([ATCG].*)", "\\1", Sequence2)
Sequence2nd <- data.frame(Name = header, Sequence = seq)
Sequence2nd$Sequence <- gsub("\n", "", Sequence2nd$Sequence)

# Use regular expressions in R to isolate the S protein from the genome you downloaded

# First, separate the sequence of Spike Protein by adding space before it.
SproSeq <- gsub("ATGTTTGTTTTTCTTGTTTTA", " ATGTTTGTTTTTCTTGTTTTA", Sequence2nd$Sequence)
# Remove the base pair before the sequence of Spike protein 
Spro1 <- sub("\\w*", " ", SproSeq)
# Remove the base pair after the sequence of Spike protein
Spro2 <- gsub("(.*)(GTCAAATTACATTACACATAA).*", "\\1 \\2", Spro1)
# Remove all the space
Sprotein <- gsub("\\s", "", Spro2)

# Show the sequence we found
paste("The sequence of Spike glucoprotein is :", Sprotein)
