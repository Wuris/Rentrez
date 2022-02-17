# Project Info
# **GitHub user name**: Wuris
# **Date**: 2022/2/16
# **GitHub Link**: https://github.com/Wuris/Rentrez.git

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

# Would you say this gene is highly conserved or evolving rapidly? Why? Explain this in a comment.
# I would say this gene is highly conserved. 
# First, the E-value for all the 100 result we found is 0, and all Query Cover value is 100%.
# Which we know that E-value  is a number that describes how many times you would expect a match by chance in a database of that size. The lower the E value is, the more significant the match.
# And the query cover is a number that describes how much of the query sequence is covered by the target sequence. If the target sequence in the database spans the whole query sequence, then the query cover is 100%. 
# Second, as for the result under tab "Graphic Summary", we have all results shows in red, which means the Alignment Scores are all equal to or greater than 200.
# Where the alignment score is computed by assigning a value to each aligned pair of letters and then summing these values over the length of the alignment.
# Thus, I think the Spike glucoprotein is highly conserved.