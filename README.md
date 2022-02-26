# Opioid2MME (*Temporary Repository*)

## Standardizing Opioid Prescriptions to Morphine Milligram Equivalents from Electronic Health Records

#### Note that this is a temporary repository. Permanent repository is available at [https://code.stanford.edu/boussardlab/mme](https://code.stanford.edu/boussardlab/mme)
##### (*Once all issues are solved in the permanent repository, this temporary repository will be removed*)

<br />

### A) Tables needed
##### Documentation of code to convert opioid prescriptions to morphine milligram equivalents (MME)
Three important tables are needed to compute MME from opioid prescriptions. We will detail this in the following lines:

1.	**Medication:** this table contains all the prescriptions from the EHR system It’s usually named “stride_medication”. Note that this table contains all type of medications including opioid prescriptions. 

2.	**Medication Definition**: this table contains the list of medications used in the EHR system (old and current medications). It’s usually named “stride_medication_def”.

3.	**Morphine Equivalent**: this table will be CREATED by the user. It will be called “ome_stride_medication_morph_eq_fnl”. It’s not needed to edit its table name and columns’ names. This will contain opioid medications and their associated values of conversion in order to compute the final MME.

For more details of tables' columns, please read the file named [TableInformation.pdf](TableInformation.pdf) 


![Image of Parameters File](img_parameters_file.png)
