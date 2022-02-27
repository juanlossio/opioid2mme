# Opioid2MME (*Temporary Repository*)

## Standardizing Opioid Prescriptions to Morphine Milligram Equivalents from Electronic Health Records

#### Note that this is a temporary repository. Permanent repository is available at 
<a href="https://code.stanford.edu/boussardlab/mme" target="_blank">https://code.stanford.edu/boussardlab/mme</a>

[https://code.stanford.edu/boussardlab/mme](https://code.stanford.edu/boussardlab/mme)
##### (*Once all issues are solved in the permanent repository, this temporary repository will be removed*)

<br />

A) Tables needed
---------------

##### Documentation of code to convert opioid prescriptions to morphine milligram equivalents (MME)
Three important tables are needed to compute MME from opioid prescriptions. We will detail this in the following lines:

1.	**Medication:** this table contains all the prescriptions from the EHR system It’s usually named “stride_medication”. Note that this table contains all type of medications including opioid prescriptions. 

2.	**Medication Definition**: this table contains the list of medications used in the EHR system (old and current medications). It’s usually named “stride_medication_def”.

3.	**Morphine Equivalent**: this table will be CREATED by the user. It will be called “ome_stride_medication_morph_eq_fnl”. It’s not needed to edit its table name and columns’ names. This will contain opioid medications and their associated values of conversion in order to compute the final MME.

For more details of tables' columns, please read the file named [TableInformation.pdf](TableInformation.pdf) 

<br />

<br />

[comment]: <> (### B Execution) 
B) Execution
---------------
There are two ways to execute the code to convert opioid prescription to MMEs as described below:

<br />

**B.1)**	**Default:** if your database presents the same tables' and columns' names, it is not needed to edit the code. You only need to execute by order the SQL files found in the directory "SQL-Default".
  - 1-get_strength.sql
  - 2-get_frequency.sql
  - 3-get_dosage.sql
  - 4-get_mme_factor.sql
  - 5-get_rx_length.sql
  - 6-compute_mme_per_day.sql
  - 7-compute_mme_total.sql
  - 8-morphine-equiv-table.sql
  - 9-conversion-to-MME.sql
  - 10-Additional-NDC_Table.sql

<br />

**B.2)**	**Edit names**: to change information from your medication and medicaton definition tables, follow the next steps: 

1. Open and edit the json parameters file named **parameters.json**. Next figure shows tables and their columns with default values. You can change the default values as appear in your database. 

<img src="img_parameters_file.png" alt="Image of Parameters File" style="width:70%;"/>

2. You then can run a python file named **create_sql_new_parameters.py**. For this, open terminal, go to the opioid2mme directory and write the following: 

```console
[user]@[pc] opioid2mme:~$ python create_sql_new_parameters.py
```
3. Finally, a new **9-conversion-to-MME_customized.sql** is created. This SQL file contains all the input instructions and variables. 

