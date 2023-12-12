# Chromosome poistions to Gene data for GrCh38.p14 version 
## Files provided:
- Gene-list.txt

> Gene list txt file created from the GFF file format of GrCh38.p14 version

- ChrPos2Gene.R

> 2 input files reuired to create the output file.
> Gene-list.txt file and a input file with chr and Pos as columns.
> Sample input file is given for testing and output file also provided.

- input.txt
> model input.txt file for format confirmation.

## Usage

```sh
Rscript ChrPos2Gene.R
```
## Package and Note

- dplyr package alone required
- Change input file and output file name if needed
