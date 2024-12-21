#SQL Database Examination

We have been tasked by a real estate agency to design a database to manage all its real estate transactions and related data. An initial draft of the relational schema has already been created and is as follows:

![project___png](https://github.com/user-attachments/assets/5b1d09ac-dcc2-411c-bb6a-a8f2736fb016)



NB : vente = sale; bien = property; valeur = value
The company has provided us with real estate sales data, geographic data, and a template for a data dictionary. 
You are required to complete the following tasks:

#Database Design:

1. Extend the Initial Schema Add information about regions and population based on the files “region_2022.csv” and “donnees_communes.xlsx.”
2. Design a Data Dictionary Create a data dictionary suited to the schema, using the provided template (“Template_dictionnary.xlsx”).

#Database Implementation :

1. Prepare Data Files Create files (CSV or Excel) containing the data for each table in the database, using the initial provided files. Pay close attention to the format of primary keys in the tables (numeric or text; handle leading zeros in numeric keys by converting them to integers in Excel if necessary). Additionally, create identifiers for data that lack natural primary keys [e.g., sales (vente) and properties (bien) tables].
2. Load Data into PostgreSQL Import these files into a database created on PostgreSQL by first designing the schema in the database management system.


#SQL Queries :

Write SQL queries on the created database to address the following requests:
1. Total number of apartments sold in the first half of 2020 (look at Type_local column).
2. Number of apartment sales by region for the first half of 2020.
3. Proportion of apartment sales by the number of rooms.
4. List of the 10 departments with the highest price per square meter (use Surface_carrez for dimension of properties).
5. Average price per square meter of houses in Île-de-France.
6. List of the 10 most expensive apartments, including their region and number of square meters.
7. Ranking of regions by average price per square meter for apartments with more than 4 rooms.
8. List of municipalities (“commune”) with at least 50 sales in the first quarter.

Submission Instructions
The entire work should be consolidated into a zipped folder and submitted in the designated space on Classrooms.
Notes
● Once the schema has been designed, you may proceed to write SQL queries for the tasks even if the data could not be fully loaded.
Credits: OpenClassrooms

