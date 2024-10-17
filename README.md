# Perl-Scripts

Most of these will probably be used for working with phone numbers.  Uniques will take a list of phone numbers and output the number of unique phone numbers.  No duplicates.  The Duplicate script does the opposite, it will output a list of all duplicate numbers.

## duplicates.pl

This script will run through a column of numbers and output a list of duplicates found.  Right now input file must be a csv and not have a header.  This was made to be used with phone numbers, but could be used for any number or string.

## uniques.pl

Input file must be a csv and have no header.  This script will run through a column of numbers and output only the unique values.  This was made to be used with phone numbers, but could be used for any number or string.

## phoneNumberExtractor.pl

Input file must be a csv.  After running the script it will ask you for the name of the input file (including the file extension).  The input file must be in the same directory as the script.  If the input file has a header use flag --header when executing the script.