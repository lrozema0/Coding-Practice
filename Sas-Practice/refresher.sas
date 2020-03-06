/* Creating a new library for practe */
libname practice "/folders/myfolders/saspractice";

/* Importing the iris data set from a .csv and saving it in the practice library*/
proc import 
datafile = "/folders/myfolders/saspractice/Iris.csv"
out=practice.iris
dbms=csv;
run;

/*Copying the data set into the work library */
proc copy in=practice out=work;
select iris;
run;

/*Looking at the contents of the iris data set */
proc contents data=iris;
run;

/*Summary statistics of the numeric variables in iris */
proc means data = iris
min
median
max
mean
std
var
maxdec = 2;
run;

/*Printing the data separated by species and summed at the end*/
proc print data=practice.iris;
by descending Species;
sumby Species;
run;

/*Sorting the data by Sepal Length*/
proc sort data=practice.iris;
by SepalLengthCm;
run;

/*Same as above but in descending order*/
proc sort data=practice.iris;
by descending SepalLengthCm;
run;

/*Selecting a specific data point and creating new table*/
proc sql;
create table iris1 as select * from practice.iris where Species="Iris-virgin";
quit; 

/*Moving new data set into the practice library*/
proc datasets;
   copy in=work out=practice memtype=data move;
   select iris1;
run;

/*Looking at the number of observations for each species*/
proc freq data = practice.iris;
table Species;
run;

/*Selecting specific observations of a data-set using proc sql */
proc sql;
select * from practice.iris where Id = 47;
quit;

/*Selecting specific observation using sas conditionals */
data;
set practice.iris;
if _n_ = 47 then output;
run;

proc print data=practice.iris;
run;


/***********Now practicing doing some regression models with avocado data************/
proc contents data = practice.avocado;
run;

proc print data=practice.avocado (obs = 50);
run;

/*Checking distribution of the avocado prices */
proc univariate data = practice.avocado;
var AveragePrice;
qqplot AveragePrice;
run;

/*Running simple linear model, use ods graphics to show plots */
ods graphics on;
proc reg data=practice.avocado;
model AveragePrice = Total_bags;
run;
ods graphics off;


