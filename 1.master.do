*** DO-FILE:       Master ***************************************************
*** PROJECT NAME:  Rice Long-term *******************************************
*** DATE: 		   29.09.2021 ***********************************************
*** AUTHOR: 	   JZ *******************************************************

* NOTE: The purpose of this do-file is to set global folder paths and to run all project related do-files. Sytem settings and folder paths can be adjusted in section 1.1. Each new project related do-file needs to be included as a new part in section 1.2 and below. 


*****************************************************************************
*** SECTION 1.1 - SETTINGS **************************************************
				
** SYSTEM SETTINGS **
clear
version 16.1
macro drop _all
set maxvar 32767 // Setting the maximum amount of variables of STATA SE
set scrollbufsize 2000000 // increase the amount of result in the output window to 2 million bytes

** CREATING GLOBAL FOR PRESENT WORKING DIRECTORY **
*To use this file, put a "1" behind your name and a "0" behind all other names:
global julian       1
global juliane      0 


*Please adjust the path in red (quotes) to your working directory
if $julian{
global home "//tsclient/C/Users/Julian/Dropbox/Rice Long-term" // <- Dropbox Path
// "//ug-uyst-ba-cifs.student.uni-goettingen.de/home/users/julian.grotzfeld/Desktop/Thesis" // <- Home path for github		

}

if $juliane {
global 	home			"/Users/`c(username)'/Dropbox/Research/DFG_FOR576/3. Research/Rice Long-term/2. STATA/do/_Julian neu"	
}

		
** CREATING GLOBALS FOR FOLDER NAMES **
*In all following file paths only use "/" and never "\", as the latter will lead to error for mac users

global 	rawdata			"$home/0_Original_data" //store original data here
global 	ado 			"$home/2_STATA/ado" //user-written ado's and self-written programs
global 	data 			"$home/2_STATA/data" //whenever you save data, do it here
global 	do 				"$home/2_STATA/do/_Julian neu" //all do-files go here, numbered in logical order
global 	graph 			"$home/2_STATA/graph" //all graphs go here
global 	output			"$home/2_STATA/output" //result tables, log files, etc.

sysdir set PERSONAL 	"$ado"

global cleandata_w1 "$rawdata/wave_1_2007_TH_Stata"
global cleandata_w2 "$rawdata/wave_2_2008_TH_Stata"
global cleandata_w3 "$rawdata/wave_3_2010_TH_Stata"
global cleandata_w5 "$rawdata/wave_5_2013_TH_Stata"
global cleandata_w6 "$rawdata/wave_6_2016_TH_Stata"
global cleandata_w7 "$rawdata/wave_7_2017_TH_Stata"
global cleandata_w8 "$rawdata/wave_8_2019_dataset_V2"

global merge_w1 "$data/merge_w1"
global merge_w2 "$data/merge_w2"
global merge_w3 "$data/merge_w3"
global merge_w5 "$data/merge_w5"
global merge_w6 "$data/merge_w6"
global merge_w7 "$data/merge_w7"
global merge_w8 "$data/merge_w8"


*****************************************************************************
*** SECTION 1.2. - CHOOSE SECTIONS TO RUN ***********************************
						
global part_2			1					
global part_3			1
global part_4			1 // Part 4 was added and runs the 2.3.0.preparation.do-file which adds the second order terms for waves 1 and 2.
global part_5			0 // Part 5 was added and runs the 2.3.0.1.preparation.do-file which adds the second order terms for waves 3 and 5 and saves them as dataset_v2.1. (There are several preparation.do-files needed to build the second order terms of all waves, because STATA can't handle as many variables simultaneously.)
global part_6			0 // Part 6 was added and runs the 2.3.0.2.preparation.do-file which adds the second order terms for waves 6 and 7 and saves them as dataset_v2.2.
global part_7			1 // Part 7 was added and runs the 2.3.0.3.preparation.do-file which adds the second order terms for wave 8 and saves them as datase_v2.3.
*...


*****************************************************************************
* SECTION 2 - XYZ ***********************************************************

if $part_2{
do "$do/2.1.merge_prep.do"
}

*****************************************************************************
* SECTION 3 - XYZ ***********************************************************

if $part_3{
do "$do/2.2.merging.do"
}

*****************************************************************************
* SECTION 4 - XYZ ***********************************************************

if $part_4{
do "$do/2.3.0.preparation.do"
}

*****************************************************************************
* SECTION 5 - XYZ ***********************************************************

if $part_5{
do "$do/2.3.0.1.preparation.do"
}

*****************************************************************************
* SECTION 6 - XYZ ***********************************************************

if $part_6{
do "$do/2.3.0.2.preparation.do"
}

*****************************************************************************
* SECTION 7 - XYZ ***********************************************************

if $part_7{
do "$do/2.3.0.3.preparation.do"
}

***...
