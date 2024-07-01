#after BLAST get the taxonomy from GenBank with the following code

mamba activate bioinformatics #activate environment we want to work in
mamba list #shows packages in environment
cd ~/Desktop/AW/data/genbank-medu-tax #set current directory
ls #list directory contents

cat HSCS_ID.txt | epost -db nuccore | esummary -db nuccore | xtract -pattern DocumentSummary -element Caption,TaxId > accid_taxid.txt #creates file with taxonomy ID 

awk '{print $2}' accid_taxid.txt > taxid.txt #creates separate file with just taxonomy ID

awk -F '\t' '{ print $1 }' taxid.txt | sort | uniq > unique_taxid.txt #pulls out only the unique taxonomy IDs

touch blastn_hits_taxonomy.txt #makes an empty txt file

while IFS= read -r id; do #splits the line whenever a new taxID is read
    # Capture the output of the first command
    output1=$(efetch -db taxonomy -id "$id" -format native -mode xml | xtract -pattern Taxon -element ScientificName)

    # Capture the output of the second command
    output2=$(efetch -db taxonomy -id "$id" -format xml | xtract -pattern Taxon -block "*/Taxon" -if Rank -equals "kingdom" -or Rank -equals "phylum" -or Rank -equals "class" -or Rank -equals "order" -or Rank -equals "family" -or Rank -equals "genus" -tab "\t" -element Rank,ScientificName)

    # Append the second output to the first output with a tab in between, and save it to a file
    echo -e "$id\t$output2\tspecies\t$output1" >> blastn_hits_taxonomy.txt
done < unique_taxid.txt


#old script -- didn't return species level assignments
touch blastn_hits_taxonomy.txt 

cat ./unique_taxid.txt | while read line

do

  echo $line | efetch -db taxonomy -format native -mode xml | xtract -pattern Taxon -block  "*/Taxon" -if Rank -equals "kingdom" -or  Rank -equals "phylum" -or Rank -equals "class" -or Rank -equals "order" -or Rank -equals "family" -or Rank -equals "genus" -or Rank -equals "species" -tab "\t" -element Rank,ScientificName | awk -v var="$line" '{print var"\t" $0; }' >> blastn_hits_taxonomy.txt

done







