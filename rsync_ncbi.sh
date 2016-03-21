#!/bin/bash

# run as sudo
# takes one argument for you want organism name
# must match folder name at ftp.ncbi.nlm.nih.gov::genomes/genbank/bacteria
# e.g. Escherichia_coli
# pass "\*" without quotes to sync with entire bacteria database

organism="$1"
location="bacteria/"$organism"/latest_assembly_versions/"
mirror="./"$organism""
localcopies="$mirror"_local
files=".fna.gz"

mkdir -p "$mirror"
mkdir -p "$localcopies"

rsync -iPrLtmn -f="+ -f="- **unplaced_scaffolds**" *"$files"" -f="+ */" -f="- *" -f="- */unplaced_scaffolds/*" --log-file=log.txt ftp.ncbi.nlm.nih.gov::genomes/genbank/"$location" "$mirror"

sudo find "$mirror" -type f -exec cp -t "$localcopies" -- {} +

# sudo python /home/truthling/MGGen/NCBI_tools/rename.py

# --exclude-from=FILE     read exclude patterns from FILE
# --include-from=FILE     read include patterns from FILE
# -c, --checksum              skip based on checksum, not mod-time & size
# -i, --itemize-changes       output a change-summary for all updates
# -P, --partial, --progress   show progress and put partially downloaded files in a folder
# -r, --recursive             recurse into directories
# -L, --copy-links            transform symlink into referent file/dir
# -t, --times                 preserve modification times
# -m, --prune-empty-dirs      prune empty directory chains from file-list
# -n, --dry-run               perform a trial run with no changes made
