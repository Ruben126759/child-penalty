/*******************************************************************************
	
Extracts the PSID family and individual data
________________________________________________________________________________

Filename:   Self-Employed_PSID_01.do
Author: 	Ruben van den Akker (r.c.b.vdnakker@tilburguniversity.edu)
Date: 		Spring 2023

This file:
(1)		Extracts relevant PSID variables from the yearly family	(interview) files. 
		Years extracted: 1968-2019.
(2)		Appends the yearly files and creates a long cross-year family file. 
		It labels variable names.
(3) 	Extracts the PSID variables from the individual file. It collects the 
		dates of family formation/dissolution events per individual. It merges 
		with the family files to create a long panel data.

*******************************************************************************/

*	Initial statements:
clear all
set maxvar 6000
set more off
cap log close

/*******************************************************************************
Extract CPI Data 1968-2019
*******************************************************************************/
cd "C:\Users\u773254\OneDrive - Tilburg University\PhD\PSID"
import excel "All_Items_CPI.xlsx", sheet("BLS Data Series") cellrange(A12:N122) firstrow clear
keep Year Annual
gen wave = Year+1	/* PSID data are retrospective */
drop Year
rename Annual annualCPI 
label variable annual "Annual All Urban CPI" 

*	Design wave 2021 (year 2020) as base rate:
gen base = annualCPI if wave==2021
sort base
replace base = base[1] if missing(base)
sort wave
replace annualCPI = annualCPI/base
drop base

*	Drop non-PSID wave years:
#delimit;
drop if wave<1968 | wave>2021 | wave==1998 | wave==2000 | wave==2002 | 
		wave==2004 | wave==2006 | wave==2008 | wave==2010 | wave==2012 | wave==2014 | wave==2016 | wave==2018 | wave==2020 ;
#delimit cr

save CPI.dta, replace

/*******************************************************************************
Append yearly family files to generate repeated cross-section
*******************************************************************************/


/*******************************************************************************
Family (Interview) File - Wave 1968
*******************************************************************************/

use f1968.dta, clear

#delimit;
keep 	V3 		V93 	V115 	V398 	V120 	V117 	V119 	V181 
		V118 	V196 	V198 	V47		V53 	V74 	V75 	V81 	
		V239	V313	V246	V197	V197_A	V197_B	V243	V243_A 
		V243_B; 	
#delimit cr

ren V3 			id				
ren V93 		state		
ren V115  		numfu
ren V398 		kids		
ren V120  		ageK		
gen newH		= .		
gen	newW 		= .		
gen newF		= .		
ren V117  		ageH		
ren V119 		sexH		
ren V181 		raceH				
ren V239 		maritalH
gen educH		= .
ren V313		educH2					
ren V118  		ageW		
gen raceW		= .				
gen educW		= .	
ren V246		educW2
ren V196 		emplH
gen selfH1 		= .	
gen selfH2 		= .	
gen selfH3 		= .	
gen selfH4 		= .	
ren V198 		selfH			
ren V47 		hoursH		
gen	experH		= .
gen	experFTH	= .
gen emplW		= .
gen selfW1 		= .	
gen selfW2 		= .	
gen selfW3 		= .	
gen selfW4 		= .	
gen selfW		= .	
ren V53 		hoursW
gen	experW		= .
gen	experFTW	= .
gen	farmerH		= .			
gen business	= .	
gen blincH 		= .
ren V74 		lH
gen blincW		= .							
ren V75 		lW			
ren V81 		incF
ren V197		occH_alt
ren V197_A		occH1
gen occH2		= .
gen occH3		= .
gen occH4		= .
gen indH_alt	= .
ren V197_B		indH1
gen indH2		= .
gen indH3		= .
gen indH4		= .
ren V243		occW_alt
ren V243_A		occW1
gen occW2		= .
gen occW3		= .
gen occW4		= .
gen indW_alt	= .
ren V243_B		indW1
gen indW2		= .
gen indW3		= .
gen indW4		= .						

gen wave 		= 1968

* cd $EXPORTSdir
compress
save FAM1968.dta, replace 


/*******************************************************************************
Family (Interview) File - Wave 1969
*******************************************************************************/	

*cd $DATAdir
use f1969.dta, clear

#delimit;
keep 	V442 	V537 	V549 	V550 	V1013 	V791 	V542 	V1008 
		V1010 	V801 	V1011	V639 	V641 	V465 	V475 	V696 
		V514 	V516	V529 	V607	V794	V640	V640_A	V640_B
		V609	V609_A	V609_B; 	
#delimit cr

ren V442 		id				
ren V537 		state		
ren V549  		numfu		
ren V550 		kids		
ren V1013  		ageK		
ren V791  		newH		
gen	newW 		= .		
ren V542  		newF		
ren V1008  		ageH		
ren V1010 		sexH		
ren V801 		raceH				
ren V607 		maritalH
gen educH		= .	
ren V794		educH2				
ren V1011  		ageW		
gen raceW		= .				
gen educW		= .	
gen educW2		= .
ren V639 		emplH
gen selfH1 		= .	
gen selfH2 		= .	
gen selfH3 		= .	
gen selfH4 		= .		
ren V641 		selfH			
ren V465 		hoursH		
gen	experH		= .
gen	experFTH	= .
gen emplW		= .
gen selfW1 		= .	
gen selfW2 		= .	
gen selfW3 		= .	
gen selfW4 		= .	
gen selfW		= .	
ren V475 		hoursW
gen	experW		= .
gen	experFTW	= .		
gen	farmerH		= .			
ren V696 		business
gen blincH		= .			
ren V514 		lH
gen blincW		= .							
ren V516 		lW					
ren V529 		incF
ren V640		occH_alt
ren V640_A		occH1
gen occH2		= .
gen occH3		= .
gen occH4		= .
gen indH_alt	= .
ren V640_B		indH1
gen indH2		= .
gen indH3		= .
gen indH4		= .
ren V609		occW_alt
ren V609_A		occW1
gen occW2		= .
gen occW3		= .
gen occW4		= .
gen indW_alt	= .
ren V609_B		indW1
gen indW2		= .
gen indW3		= .
gen indW4		= .					

gen wave 		= 1969

* cd $EXPORTSdir
compress
save FAM1969.dta, replace
 

/*******************************************************************************
Family (Interview) File - Wave 1970
*******************************************************************************/

*cd $DATAdir
use f1970.dta, clear

#delimit;
keep 	V1102 V1103 V1238 V1242 V1243 V1461 V1109 V1239 V1240 V1490 V1365 V1241 
		V1278 V1280 V1138 V1148 V1382 V1190 V1196 V1198 V1514 V1485	V1279 V1279_A
		V1279_B V1367 V1367_A V1367_B;	
#delimit cr

ren V1102 		id				
ren V1103 		state		
ren V1238  		numfu		
ren V1242 		kids		
ren V1243  		ageK		
ren V1461  		newH		
gen	newW 		= .		
ren V1109  		newF		
ren V1239  		ageH		
ren V1240 		sexH		
ren V1490 		raceH				
ren V1365 		maritalH
gen educH		= .
ren V1485		educH2					
ren V1241  		ageW		
gen raceW		= .				
gen educW		= .	
gen educW2		= .
ren V1278 		emplH
gen selfH1 		= .	
gen selfH2 		= .	
gen selfH3 		= .	
gen selfH4 		= .	
ren V1280 		selfH			
ren V1138 		hoursH
gen	experH		= .
gen	experFTH	= .		
gen emplW		= .
gen selfW1 		= .	
gen selfW2 		= .	
gen selfW3 		= .	
gen selfW4 		= .
gen selfW		= .	
ren V1148 		hoursW
gen	experW		= .
gen	experFTW	= .	
gen	farmerH		= .			
ren V1382 		business
ren V1190		blincH			
ren V1196 		lH
gen blincW 		= .							
ren V1198 		lW				
ren V1514 		incF	
ren V1279		occH_alt
ren V1279_A		occH1
gen occH2		= .
gen occH3		= .
gen occH4		= .
gen indH_alt	= .
ren V1279_B		indH1
gen indH2		= .
gen indH3		= .
gen indH4		= .
ren V1367		occW_alt
ren V1367_A		occW1
gen occW2		= .
gen occW3		= .
gen occW4		= .
gen indW_alt	= .
ren V1367_B		indW1
gen indW2		= .
gen indW3		= .
gen indW4		= .	

gen wave 		= 1970

* cd $EXPORTSdir
compress
save FAM1970.dta, replace 


/*******************************************************************************
Family (Interview) File - Wave 1971
*******************************************************************************/

*cd $DATAdir
use f1971.dta, clear

#delimit;
keep 	V1802 V1803 V1941 V1945 V1946 V2165 V1809 V1942 V1943 V2202 V2072 V1944 
		V1983 V1986 V1839 V1849 V2094 V1891 V1897 V1899 V2226 V2197 V1984 V1984_A 
		V1985 V1985_A V2074 V2074_A V2075 V2075_A; 	
#delimit cr

ren V1802  		id				
ren V1803  		state		
ren V1941  		numfu		
ren V1945  		kids		
ren V1946  		ageK		
ren V2165  		newH		
gen	newW 		= .		
ren V1809  		newF		
ren V1942  		ageH		
ren V1943  		sexH		
ren V2202  		raceH				
ren V2072 		maritalH
gen educH		= .	
ren V2197		educH2					
ren V1944  		ageW		
gen raceW		= .				
gen educW		= .	
gen educW2		= .
ren V1983  		emplH
gen selfH1 		= .	
gen selfH2 		= .	
gen selfH3 		= .	
gen selfH4 		= .	
ren V1986  		selfH			
ren V1839  		hoursH
gen	experH		= .
gen	experFTH	= .		
gen emplW		= .
gen selfW1 		= .	
gen selfW2 		= .	
gen selfW3 		= .	
gen selfW4 		= .
gen selfW		= .	
ren V1849  		hoursW
gen	experW		= .
gen	experFTW	= .		
gen	farmerH		= .			
ren V2094  		business
ren V1891		blincH			
ren V1897  		lH
gen blincW 		= .					
ren V1899  		lW			
ren V2226  		incF
ren V1984		occH_alt
ren V1984_A		occH1
gen occH2		= .
gen occH3		= .
gen occH4		= .
ren V1985		indH_alt
ren V1985_A		indH1
gen indH2		= .
gen indH3		= .
gen indH4		= .
ren V2074		occW_alt
ren V2074_A		occW1
gen occW2		= .
gen occW3		= .
gen occW4		= .
ren V2075 		indW_alt
ren V2075_A		indW1
gen indW2		= .
gen indW3		= .
gen indW4		= .		

gen wave 		= 1971

* cd $EXPORTSdir
compress
save FAM1971.dta, replace 


/*******************************************************************************
Family (Interview) File - Wave 1972
*******************************************************************************/

*cd $DATAdir
use f1972.dta, clear

#delimit;
keep 	V2402 V2403 V2541 V2545 V2546 V2791 V2410 V2542 V2543 V2828 V2670 V2544 
		V2581 V2584 V2439 V2449 V2695 V2492 V2498 V2500 V2852 V2823 V2687 V2582
		V2582_A V2583 V2583_A V2672 V2672_A V2673 V2673_A; 	
#delimit cr

ren V2402  		id				
ren V2403  		state		
ren V2541  		numfu		
ren V2545  		kids		
ren V2546  		ageK		
ren V2791  		newH		
gen	newW 		= .		
ren V2410  		newF		
ren V2542  		ageH		
ren V2543  		sexH		
ren V2828  		raceH				
ren V2670 		maritalH
gen educH		= .		
ren V2823		educH2			
ren V2544  		ageW		
gen raceW		= .				
gen educW		= .	
ren V2687		educW2
ren V2581  		emplH
gen selfH1 		= .	
gen selfH2 		= .	
gen selfH3 		= .	
gen selfH4 		= .	
ren V2584  		selfH			
ren V2439  		hoursH
gen	experH		= .
gen	experFTH	= .		
gen emplW		= .
gen selfW1 		= .	
gen selfW2 		= .	
gen selfW3 		= .	
gen selfW4 		= .
gen selfW		= .	
ren V2449  		hoursW
gen	experW		= .
gen	experFTW	= .	
gen	farmerH		= .			
ren V2695  		business
ren V2492		blincH			
ren V2498  		lH
gen blincW 		= .				
ren V2500  		lW				
ren V2852  		incF
ren V2582		occH_alt
ren V2582_A		occH1
gen occH2		= .
gen occH3		= .
gen occH4		= .
ren V2583		indH_alt
ren V2583_A		indH1
gen indH2		= .
gen indH3		= .
gen indH4		= .
ren V2672		occW_alt
ren V2672_A		occW1
gen occW2		= .
gen occW3		= .
gen occW4		= .
ren V2673		indW_alt
ren V2673_A		indW1
gen indW2		= .
gen indW3		= .
gen indW4		= .					

gen wave 		= 1972

* cd $EXPORTSdir
compress
save FAM1972.dta, replace 


/*******************************************************************************
Family (Interview) File - Wave 1973
*******************************************************************************/	

*cd $DATAdir
use f1973.dta, clear

#delimit;
keep 	V3002 V3003 V3094 V3098 V3099 V3217 V3215 V3010 V3095 V3096 V3300 V3181 
		V3097 V3114 V3117 V3027 V3035 V3207 V3045 V3051 V3053 V3256 V3241 V3216
		V3115 V3115_A V3116 V3116_A V3183 V3183_A V3184 V3184_A; 	
#delimit cr

ren V3002  		id				
ren V3003  		state		
ren V3094  		numfu		
ren V3098  		kids		
ren V3099  		ageK		
ren V3217  		newH		
ren	V3215 		newW 				
ren V3010  		newF		
ren V3095  		ageH		
ren V3096  		sexH		
ren V3300  		raceH				
ren V3181 		maritalH
gen educH		= .	
ren V3241		educH2				
ren V3097  		ageW		
gen raceW		= .				
gen educW		= .	
ren V3216		educW2
ren V3114  		emplH
gen selfH1 		= .	
gen selfH2 		= .	
gen selfH3 		= .	
gen selfH4 		= .	
ren V3117  		selfH			
ren V3027  		hoursH
gen	experH		= .
gen	experFTH	= .		
gen emplW		= .
gen selfW1 		= .	
gen selfW2 		= .	
gen selfW3 		= .	
gen selfW4 		= .
gen selfW		= .	
ren V3035  		hoursW
gen	experW		= .
gen	experFTW	= .	
gen	farmerH		= .			
ren V3207  		business
ren V3045		blincH			
ren V3051  		lH
gen blincW 		= .				
ren V3053  		lW			
ren V3256  		incF
ren V3115		occH_alt
ren V3115_A		occH1
gen occH2		= .
gen occH3		= .
gen occH4		= .
ren V3116		indH_alt
ren V3116_A		indH1
gen indH2		= .
gen indH3		= .
gen indH4		= .
ren V3183		occW_alt
ren V3183_A		occW1
gen occW2		= .
gen occW3		= .
gen occW4		= .
ren V3184		indW_alt
ren V3184_A		indW1
gen indW2		= .
gen indW3		= .
gen indW4		= .		

gen wave 		= 1973

* cd $EXPORTSdir
compress
save FAM1973.dta, replace 


/*******************************************************************************
Family (Interview) File - Wave 1974
*******************************************************************************/

*cd $DATAdir
use f1974.dta, clear

#delimit;
keep 	V3402 V3403 V3507 V3511 V3512 V3639 V3637 V3410 V3508 V3509 V3720 V3598 
		V3510 V3528 V3532 V3423 V3620 V3621 V3431 V3610 V3611 V3626 V3457 V3463 
		V3465 V3676 V3638 V3663 V3530 V3530_A V3531 V3531_A V3601 V3601_A 
		V3602 V3602_A V3529; 	
#delimit cr

ren V3402  		id				
ren V3403  		state		
ren V3507  		numfu		
ren V3511  		kids		
ren V3512  		ageK		
ren V3639  		newH		
ren	V3637  		newW	
ren V3410  		newF		
ren V3508  		ageH		
ren V3509  		sexH		
ren V3720  		raceH				
ren V3598 		maritalH
gen educH		= .
ren V3663		educH2					
ren V3510  		ageW		
gen raceW		= .				
gen educW		= .	
ren V3638		educW2
ren V3528  		emplH
gen selfH1 		= .	
gen selfH2 		= .	
gen selfH3 		= .	
gen selfH4 		= .	
ren V3532  		selfH			
ren V3423  		hoursH
ren	V3620 		experH
ren	V3621 		experFTH		
gen emplW		= .
gen selfW1 		= .	
gen selfW2 		= .	
gen selfW3 		= .	
gen selfW4 		= .
gen selfW		= .	
ren V3431  		hoursW
ren	V3610 		experW
ren	V3611 		experFTW		
gen	farmerH		= .			
ren V3626  		business
ren V3457		blincH			
ren V3463  		lH
gen blincW 		= .
ren V3465  		lW		
ren V3676  		incF
ren V3530		occH_alt
ren V3530_A		occH1
ren V3529		occH2
gen occH3		= .
gen occH4		= .
ren V3531		indH_alt
ren V3531_A		indH1
gen indH2		= .
gen indH3		= .
gen indH4		= .
ren V3601		occW_alt
ren V3601_A		occW1
gen occW2		= .
gen occW3		= .
gen occW4		= .
ren V3602		indW_alt
ren V3602_A		indW1
gen indW2		= .
gen indW3		= .
gen indW4		= .			

gen wave 		= 1974

* cd $EXPORTSdir
compress
save FAM1974.dta, replace


/*******************************************************************************
Family (Interview) File - Wave 1975
*******************************************************************************/	

*cd $DATAdir
use f1975.dta, clear

#delimit;
keep 	V3802 V3803 V3920 V3924 V3925 V4114 V4107 V3810 V3921 V3922 V4204 V4053 
		V4093 V3923 V4102 V3967 V3970 V3823 V4141 V4142 V3831 V4110 V4111 V4066 
		V3857 V3863 V3865 V4154 V4198 V4199 V3968 V3968_A V3969 V3969_A V4055 
		V4055_A V4056 V4056_A; 	
#delimit cr

ren V3802  		id				
ren V3803  		state		
ren V3920  		numfu		
ren V3924  		kids		
ren V3925  		ageK		
ren V4114  		newH		
ren	V4107  		newW	
ren V3810  		newF		
ren V3921  		ageH		
ren V3922  		sexH		
ren V4204  		raceH				
ren V4053 		maritalH
ren V4093 		educH	
ren V4198		educH2						
ren V3923  		ageW		
gen raceW		= .				
ren V4102 		educW	
ren V4199		educW2
ren V3967  		emplH
gen selfH1 		= .	
gen selfH2 		= .	
gen selfH3 		= .	
gen selfH4 		= .	
ren V3970  		selfH			
ren V3823  		hoursH
ren	V4141  		experH
ren	V4142  		experFTH		
gen emplW		= .
gen selfW1 		= .	
gen selfW2 		= .	
gen selfW3 		= .	
gen selfW4 		= .
gen selfW		= .	
ren V3831  		hoursW
ren	V4110  		experW
ren	V4111  		experFTW		
gen	farmerH		= .			
ren V4066  		business
ren V3857		blincH			
ren V3863  		lH
gen blincW 		= .
ren V3865  		lW				
ren V4154  		incF
ren V3968		occH_alt
ren V3968_A		occH1
gen occH2		= .
gen occH3		= .
gen occH4		= .
ren V3969		indH_alt
ren V3969_A		indH1
gen indH2		= .
gen indH3		= .
gen indH4		= .
ren V4055		occW_alt
ren V4055_A		occW1
gen occW2		= .
gen occW3		= .
gen occW4		= .
ren V4056		indW_alt
ren V4056_A		indW1
gen indW2		= .
gen indW3		= .
gen indW4		= .			

gen wave 		= 1975

* cd $EXPORTSdir
compress
save FAM1975.dta, replace 


/*******************************************************************************
Family (Interview) File - Wave 1976
*******************************************************************************/	

*cd $DATAdir
use f1976.dta, clear

#delimit;
keep 	V4302 V4303 V4435 V4439 V4440 V4658 V4694 V4310 V4436 V4437 V5096 V4603 
		V4684 V4438 V4695 V4458 V4461 V4332 V4630 V4631 V4841 V4844 V4344 V4989 
		V4990 V4612 V4372 V5031 V4379 V5029 V5074 V5075 V4459 V4459_A V4460 
		V4460_A V4605 V4605_A V4606 V4606_A; 
#delimit cr

ren V4302  		id				
ren V4303  		state		
ren V4435  		numfu		
ren V4439  		kids		
ren V4440  		ageK		
ren V4658  		newH		
ren	V4694  		newW	
ren V4310  		newF		
ren V4436  		ageH		
ren V4437  		sexH		
ren V5096  		raceH				
ren V4603 		maritalH
ren V4684  		educH	
ren V5074		educH2				
ren V4438   	ageW		
gen raceW		= .				
ren V4695  		educW
ren V5075		educW2
ren V4458  		emplH
gen selfH1 		= .	
gen selfH2 		= .	
gen selfH3 		= .	
gen selfH4 		= .	
ren V4461  		selfH			
ren V4332  		hoursH
ren	V4630  		experH
ren	V4631  		experFTH		
ren V4841 		emplW
gen selfW1 		= .	
gen selfW2 		= .	
gen selfW3 		= .	
gen selfW4 		= .
ren V4844 		selfW
ren V4344  		hoursW
ren	V4989  		experW
ren	V4990  		experFTW		
gen	farmerH		= .			
ren V4612  		business
ren V4372		blincH			
ren V5031  		lH
gen blincW 		= .
ren V4379  		lW			
ren V5029  		incF
ren V4459		occH_alt
ren V4459_A		occH1
gen occH2		= .
gen occH3		= .
gen occH4		= .
ren V4460		indH_alt
ren V4460_A		indH1
gen indH2		= .
gen indH3		= .
gen indH4		= .
ren V4605		occW_alt
ren V4605_A		occW1
gen occW2		= .
gen occW3		= .
gen occW4		= .
ren V4606		indW_alt
ren V4606_A		indW1
gen indW2		= .
gen indW3		= .
gen indW4		= .			

gen wave 		= 1976

* cd $EXPORTSdir
compress
save FAM1976.dta, replace 


/*******************************************************************************
Family (Interview) File - Wave 1977
*******************************************************************************/	

*cd $DATAdir
use f1977.dta, clear

#delimit;
keep 	V5202 V5203 V5349 V5353 V5354 V5578 V5566 V5210 V5350 V5351 V5662 V5650 
		V5608 V5352 V5567 V5373 V5376 V5232 V5604 V5605 V5244 V5574 V5575 V5541 
		V5282 V5627 V5289 V5626 V5647 V5648 V5374 V5374_A V5375 V5375_A V5507 
		V5507_A V5508 V5508_A; 	
#delimit cr

ren V5202  		id				
ren V5203  		state		
ren V5349  		numfu		
ren V5353  		kids		
ren V5354  		ageK		
ren V5578  		newH		
ren	V5566  		newW	
ren V5210  		newF		
ren V5350  		ageH		
ren V5351  		sexH		
ren V5662  		raceH				
ren V5650 		maritalH
ren V5608  		educH	
ren V5647		educH2				
ren V5352   	ageW		
gen raceW		= .				
ren V5567  		educW
ren V5648		educW2
ren V5373  		emplH
gen selfH1 		= .	
gen selfH2 		= .	
gen selfH3 		= .	
gen selfH4 		= .	
ren V5376  		selfH			
ren V5232  		hoursH
ren	V5604  		experH
ren	V5605  		experFTH		
gen emplW		= .
gen selfW1 		= .	
gen selfW2 		= .	
gen selfW3 		= .	
gen selfW4 		= .
gen selfW		= .	
ren V5244  		hoursW
ren	V5574  		experW
ren	V5575  		experFTW	
gen	farmerH		= .			
ren V5541  		business
ren V5282		blincH			
ren V5627  		lH
gen blincW 		= .
ren V5289 		lW					
ren V5626  		incF
ren V5374		occH_alt
ren V5374_A		occH1
gen occH2		= .
gen occH3		= .
gen occH4		= .
ren V5375		indH_alt
ren V5375_A		indH1
gen indH2		= .
gen indH3		= .
gen indH4		= .
ren V5507		occW_alt
ren V5507_A		occW1
gen occW2		= .
gen occW3		= .
gen occW4		= .
ren V5508		indW_alt
ren V5508_A		indW1
gen indW2		= .
gen indW3		= .
gen indW4		= .				

gen wave 		= 1977

* cd $EXPORTSdir
compress
save FAM1977.dta, replace 


/*******************************************************************************
Family (Interview) File - Wave 1978
*******************************************************************************/

*cd $DATAdir
use f1978.dta, clear

#delimit;
keep 	V5702 V5703 V5849 V5853 V5854 V6127 V6115 V5710 V5850 V5851 V6209 V6197 
		V6157 V5852 V6116 V5872 V5875 V5731 V6153 V6154 V5743 V6123 V6124 V6076 
		V5781 V6174 V5788 V6173 V6194 V6195 V5873 V5873_A V5874 V5874_A V6039 
		V6039_A V6040 V6040_A; 	
#delimit cr

ren V5702  		id				
ren V5703  		state		
ren V5849  		numfu		
ren V5853  		kids		
ren V5854  		ageK		
ren V6127  		newH		
ren	V6115  		newW		
ren V5710  		newF		
ren V5850  		ageH		
ren V5851  		sexH		
ren V6209  		raceH				
ren V6197 		maritalH
ren V6157  		educH	
ren V6194		educH2					
ren V5852  		ageW		
gen raceW		= .				
ren V6116  		educW	
ren V6195		educW2
ren V5872  		emplH
gen selfH1 		= .	
gen selfH2 		= .	
gen selfH3 		= .	
gen selfH4 		= .	
ren V5875  		selfH			
ren V5731  		hoursH
ren	V6153  		experH
ren	V6154  		experFTH	
gen emplW		= .
gen selfW1 		= .	
gen selfW2 		= .	
gen selfW3 		= .	
gen selfW4 		= .
gen selfW		= .	
ren V5743  		hoursW
ren	V6123  		experW
ren	V6124  		experFTW	
gen	farmerH		= .			
ren V6076  		business
ren V5781		blincH			
ren V6174  		lH
gen blincW 		= .
ren V5788  		lW			
ren V6173  		incF
ren V5873		occH_alt
ren V5873_A		occH1
gen occH2		= .
gen occH3		= .
gen occH4		= .
ren V5874		indH_alt
ren V5874_A		indH1
gen indH2		= .
gen indH3		= .
gen indH4		= .
ren V6039		occW_alt
ren V6039_A		occW1
gen occW2		= .
gen occW3		= .
gen occW4		= .
ren V6040		indW_alt
ren V6040_A		indW1
gen indW2		= .
gen indW3		= .
gen indW4		= .				

gen wave 		= 1978

* cd $EXPORTSdir
compress
save FAM1978.dta, replace 


/*******************************************************************************
Family (Interview) File - Wave 1979
*******************************************************************************/	

*cd $DATAdir
use f1979.dta, clear

#delimit;
keep 	V6302 V6303 V6461 V6465 V6466 V6724 V6712 V6310 V6462 V6463 V6802 V6790 
		V6754 V6464 V6713 V6492 V6493 V6336 V6750 V6751 V6591 V6592 V6348 V6720 
		V6721 V6678 V6680 V6390 V6767 V6398 V6766 V6787 V6788 V6497 V6497_A 
		V6498 V6498_A V6596 V6596_A V6597 V6597_A;	
#delimit cr

ren V6302  		id				
ren V6303  		state		
ren V6461  		numfu		
ren V6465  		kids		
ren V6466  		ageK		
ren V6724  		newH		
ren	V6712  		newW		
ren V6310  		newF		
ren V6462  		ageH		
ren V6463  		sexH		
ren V6802  		raceH				
ren V6790 		maritalH
ren V6754  		educH	
ren V6787		educH2				
ren V6464  		ageW		
gen raceW		= .				
ren V6713  		educW
ren V6788		educW2
ren V6492  		emplH
gen selfH1 		= .	
gen selfH2 		= .	
gen selfH3 		= .	
gen selfH4 		= .	
ren V6493		selfH			
ren V6336  		hoursH
ren	V6750  		experH
ren	V6751  		experFTH		
ren V6591 		emplW
gen selfW1 		= .	
gen selfW2 		= .	
gen selfW3 		= .	
gen selfW4 		= .
ren V6592 		selfW	
ren V6348  		hoursW
ren	V6720  		experW
ren	V6721  		experFTW		
ren	V6678 		farmerH		
ren V6680  		business
ren V6390		blincH			
ren V6767  		lH
gen blincW 		= .
ren V6398  		lW			
ren V6766  		incF
ren V6497		occH_alt
ren V6497_A		occH1
gen occH2		= .
gen occH3		= .
gen occH4		= .
ren V6498		indH_alt
ren V6498_A		indH1
gen indH2		= .
gen indH3		= .
gen indH4		= .
ren V6596		occW_alt
ren V6596_A		occW1
gen occW2		= .
gen occW3		= .
gen occW4		= .
ren V6597		indW_alt
ren V6597_A		indW1
gen indW2		= .
gen indW3		= .
gen indW4		= .				

gen wave 		= 1979

* cd $EXPORTSdir
compress
save FAM1979.dta, replace 


/*******************************************************************************
Family (Interview) File - Wave 1980
*******************************************************************************/	

*cd $DATAdir
use f1980.dta, clear

#delimit;
keep 	V6902 V6903 V7066 V7070 V7071 V7357 V7345 V6910 V7067 V7068 V7447 V7435 
		V7387 V7069 V7346 V7095 V7096 V6934 V7383 V7384 V7193 V7194 V6946 V7353 
		V7354 V7275 V7277 V6980 V7413 V6988 V7412 V7433 V7434 V7100 V7100_A 
		V7101 V7101_A V7198 V7198_A V7199 V7199_A;	
#delimit cr

ren V6902  		id				
ren V6903  		state		
ren V7066  		numfu		
ren V7070  		kids		
ren V7071  		ageK		
ren V7357  		newH		
ren	V7345  		newW	
ren V6910  		newF		
ren V7067  		ageH		
ren V7068  		sexH		
ren V7447  		raceH				
ren V7435 		maritalH
ren V7387  		educH	
ren V7433		educH2					
ren V7069  		ageW		
gen raceW		= .				
ren V7346  		educW
ren V7434		educW2
ren V7095  		emplH
gen selfH1 		= .	
gen selfH2 		= .	
gen selfH3 		= .	
gen selfH4 		= .	
ren V7096  		selfH			
ren V6934  		hoursH
ren	V7383  		experH
ren	V7384  		experFTH		
ren V7193  		emplW
gen selfW1 		= .	
gen selfW2 		= .	
gen selfW3 		= .	
gen selfW4 		= .
ren V7194  		selfW	
ren V6946  		hoursW
ren	V7353  		experW
ren	V7354  		experFTW		
ren	V7275  		farmerH		
ren V7277  		business
ren V6980		blincH			
ren V7413  		lH
gen blincW 		= .
ren V6988  		lW			
ren V7412  		incF
ren V7100		occH_alt
ren V7100_A		occH1
gen occH2		= .
gen occH3		= .
gen occH4		= .
ren V7101		indH_alt
ren V7101_A		indH1
gen indH2		= .
gen indH3		= .
gen indH4		= .
ren V7198		occW_alt
ren V7198_A		occW1
gen occW2		= .
gen occW3		= .
gen occW4		= .
ren V7199		indW_alt
ren V7199_A		indW1
gen indW2		= .
gen indW3		= .
gen indW4		= .			

gen wave 		= 1980

* cd $EXPORTSdir
compress
save FAM1980.dta, replace 


/*******************************************************************************
Family (Interview) File - Wave 1981
*******************************************************************************/	

*cd $DATAdir
use f1981.dta, clear

#delimit;
keep 	V7502 V7503 V7657 V7661 V7662 V8009 V7997 V7510 V7658 V7659 V8099 V8087 
		V8039 V7660 V7998 V7706 V7707 V7530 V8035 V8036 V7879 V7880 V7540 V8005 
		V8006 V7967 V7969 V7572 V8066 V7580 V8065 V8085 V8086 V7712 V7713 V7885 
		V7886; 	
#delimit cr

ren V7502  		id				
ren V7503  		state		
ren V7657  		numfu		
ren V7661  		kids		
ren V7662  		ageK		
ren V8009  		newH		
ren	V7997  		newW	
ren V7510  		newF		
ren V7658  		ageH		
ren V7659  		sexH		
ren V8099  		raceH				
ren V8087 		maritalH
ren V8039  		educH	
ren V8085		educH2				
ren V7660  		ageW		
gen raceW		= .				
ren V7998  		educW	
ren V8086		educW2
ren V7706  		emplH
gen selfH1 		= .	
gen selfH2 		= .	
gen selfH3 		= .	
gen selfH4 		= .	
ren V7707  		selfH			
ren V7530  		hoursH
ren	V8035  		experH
ren	V8036  		experFTH		
ren V7879  		emplW
gen selfW1 		= .	
gen selfW2 		= .	
gen selfW3 		= .	
gen selfW4 		= .
ren V7880  		selfW	
ren V7540  		hoursW
ren	V8005  		experW
ren	V8006  		experFTW	
ren	V7967  		farmerH			
ren V7969  		business
ren V7572		blincH			
ren V8066  		lH
gen blincW 		= .				
ren V7580  		lW				
ren V8065  		incF
gen occH_alt	= .
gen occH1		= .
ren V7712		occH2
gen occH3		= .
gen occH4		= .
gen indH_alt	= .
gen indH1		= .
ren V7713		indH2
gen indH3		= .
gen indH4		= .
gen occW_alt	= .
gen occW1		=.
ren V7885		occW2
gen occW3		= .
gen occW4		= .
gen indW_alt	= .
gen	indW1		= .
ren V7886		indW2
gen indW3		= .
gen indW4		= .		

gen wave 		= 1981

* cd $EXPORTSdir
compress
save FAM1981.dta, replace


/*******************************************************************************
Family (Interview) File - Wave 1982
*******************************************************************************/	

*cd $DATAdir
use f1982.dta, clear

#delimit;
keep 	V8202 V8203 V8351 V8355 V8356 V8633 V8621 V8210 V8352 V8353 V8723 V8711 
		V8663 V8354 V8622 V8374 V8375 V8228 V8659 V8660 V8538 V8539 V8238 V8629 
		V8630 V8606 V8608 V8264 V8690 V8273 V8689 V8709 V8710 V8380 V8381 V8544
		V8545; 	
#delimit cr

ren V8202  		id				
ren V8203  		state		
ren V8351  		numfu		
ren V8355  		kids		
ren V8356  		ageK		
ren V8633  		newH		
ren	V8621  		newW	
ren V8210  		newF		
ren V8352  		ageH		
ren V8353  		sexH		
ren V8723  		raceH				
ren V8711 		maritalH
ren V8663  		educH	
ren V8709		educH2				
ren V8354  		ageW		
gen raceW		= .				
ren V8622  		educW
ren V8710		educW2
ren V8374  		emplH
gen selfH1 		= .	
gen selfH2 		= .	
gen selfH3 		= .	
gen selfH4 		= .	
ren V8375  		selfH			
ren V8228  		hoursH
ren	V8659  		experH
ren	V8660  		experFTH		
ren V8538  		emplW
gen selfW1 		= .	
gen selfW2 		= .	
gen selfW3 		= .	
gen selfW4 		= .
ren V8539  		selfW	
ren V8238  		hoursW
ren	V8629  		experW
ren	V8630  		experFTW	
ren	V8606  		farmerH			
ren V8608  		business
ren V8264		blincH			
ren V8690  		lH
gen blincW 		= .				
ren V8273  		lW				
ren V8689  		incF
gen occH_alt	= .
gen occH1		= .
ren V8380		occH2
gen occH3		= .
gen occH4		= .
gen indH_alt	= .
gen indH1		= .
ren V8381		indH2
gen indH3		= .
gen indH4		= .
gen occW_alt	= .
gen occW1		=.
ren V8544		occW2
gen occW3		= .
gen occW4		= .
gen indW_alt	= .
gen indW1		= .
ren V8545		indW2
gen indW3		= .
gen indW4		= .			

gen wave 		= 1982

* cd $EXPORTSdir
compress
save FAM1982.dta, replace  


/*******************************************************************************
Family (Interview) File - Wave 1983
*******************************************************************************/

*cd $DATAdir
use f1983.dta, clear

#delimit;
keep 	V8802 V8803 V8960 V8964 V8965 V9319 V9307 V8810 V8961 V8962 V9408 V9419 
		V9349 V8963 V9308 V9005 V9006 V8830 V9345 V9346 V9188 V9189 V8840 V9315 
		V9316 V9286 V9288 V8872 V9376 V8881 V9375 V9395 V9396 V9011 V9012 V9194
		V9195;	
#delimit cr

ren V8802  		id				
ren V8803  		state		
ren V8960  		numfu		
ren V8964  		kids		
ren V8965  		ageK		
ren V9319  		newH		
ren	V9307  		newW		
ren V8810  		newF		
ren V8961  		ageH		
ren V8962  		sexH		
ren V9408  		raceH				
ren V9419 		maritalH
ren V9349  		educH	
ren V9395		educH2				
ren V8963  		ageW		
gen raceW		= .				
ren V9308  		educW
ren V9396		educW2
ren V9005  		emplH
gen selfH1 		= .	
gen selfH2 		= .	
gen selfH3 		= .	
gen selfH4 		= .	
ren V9006  		selfH			
ren V8830  		hoursH
ren	V9345  		experH
ren	V9346  		experFTH		
ren V9188  		emplW
gen selfW1 		= .	
gen selfW2 		= .	
gen selfW3 		= .	
gen selfW4 		= .
ren V9189  		selfW	
ren V8840  		hoursW
ren	V9315  		experW
ren	V9316  		experFTW		
ren	V9286  		farmerH			
ren V9288  		business
ren V8872		blincH			
ren V9376  		lH
gen blincW 		= .			
ren V8881  		lW				
ren V9375  		incF
gen occH_alt	= .
gen occH1		= .
ren V9011		occH2
gen occH3		= .
gen occH4		= .
gen indH_alt	= .
gen indH1		= .
ren V9012		indH2
gen indH3		= .
gen indH4		= .
gen occW_alt	= .
gen occW1		=.
ren V9194		occW2
gen occW3		= .
gen occW4		= .
gen indW_alt	= .
gen indW1		= .
ren V9195		indW2
gen indW3		= .
gen indW4		= .			

gen wave 		= 1983

* cd $EXPORTSdir
compress
save FAM1983.dta, replace 


/*******************************************************************************
Family (Interview) File - Wave 1984
*******************************************************************************/

*cd $DATAdir
use f1984.dta, clear

#delimit;
keep 	V10002 V10003 V10418 V10422 V10423 V10966 V10954 V10010 V10419 V10420 
		V11055 V11065 V10996 V10421 V10955 V10453 V10456 V10037 V10992 V10993 
		V10671 V10674 V10131 V10962 V10963 V10870 V10872 V10255 V11023 V10263 
		V11022 V11042 V11043 V10640 V10641 V10678 V10679; 	
#delimit cr

ren V10002 		id				
ren V10003 		state		
ren V10418 		numfu		
ren V10422 		kids		
ren V10423 		ageK		
ren V10966 		newH		
ren	V10954 		newW	
ren V10010 		newF		
ren V10419 		ageH		
ren V10420 		sexH		
ren V11055 		raceH				
ren V11065 		maritalH
ren V10996 		educH			
ren V11042		educH2		
ren V10421 		ageW		
gen raceW		= .				
ren V10955 		educW
ren V11043		educW2
ren V10453 		emplH
gen selfH1 		= .	
gen selfH2 		= .	
gen selfH3 		= .	
gen selfH4 		= .	
ren V10456 		selfH			
ren V10037 		hoursH
ren	V10992 		experH
ren	V10993 		experFTH	
ren V10671 		emplW
gen selfW1 		= .	
gen selfW2 		= .	
gen selfW3 		= .	
gen selfW4 		= .
ren V10674 		selfW	
ren V10131 		hoursW
ren	V10962 		experW
ren	V10963 		experFTW		
ren	V10870 		farmerH		
ren V10872 		business
ren V10255		blincH		
ren V11023 		lH
gen blincW 		= .			
ren V10263 		lW					
ren V11022 		incF
gen occH_alt	= .
gen occH1		= .
ren V10640		occH2
gen occH3		= .
gen occH4		= .
gen indH_alt	= .
gen indH1		= .
ren V10641		indH2
gen indH3		= .
gen indH4		= .
gen occW_alt	= .
gen occW1		=.
ren V10678		occW2
gen occW3		= .
gen occW4		= .
gen indW_alt	= .
gen indW1		= .
ren V10679		indW2
gen indW3		= .
gen indW4		= .			

gen wave 		= 1984

* cd $EXPORTSdir
compress
save FAM1984.dta, replace 


/*******************************************************************************
Family (Interview) File - Wave 1985
*******************************************************************************/	

*cd $DATAdir
use f1985.dta, clear

#delimit;
keep 	V11102 V11103 V11605 V11609 V11610 V11906 V11112 V11606 V11607 V11938 
		V12426 V11608 V12293 V11637 V11640 V11146 V11739 V11740 V12000 V12003 
		V11258 V12102 V12103 V11886 V11888 V11396 V12372 V11404 V12371 V12400 
		V12401 V11651 V11652 V12014 V12015; 	
#delimit cr

ren V11102 		id				
ren V11103 		state		
ren V11605 		numfu		
ren V11609 		kids		
ren V11610 		ageK		
ren V11906 		newH		
gen	newW		= .
ren V11112 		newF		
ren V11606 		ageH		
ren V11607 		sexH		
ren V11938 		raceH				
ren V12426 		maritalH
gen educH		= .	
ren V12400		educH2			
ren V11608 		ageW		
ren V12293 		raceW			
gen educW		= .
ren V12401		educW2
ren V11637 		emplH
gen selfH1 		= .	
gen selfH2 		= .	
gen selfH3 		= .	
gen selfH4 		= .	
ren V11640 		selfH			
ren V11146 		hoursH
ren	V11739 		experH
ren	V11740 		experFTH		
ren V12000 		emplW
gen selfW1 		= .	
gen selfW2 		= .	
gen selfW3 		= .	
gen selfW4 		= .
ren V12003 		selfW	
ren V11258 		hoursW
ren	V12102 		experW
ren	V12103 		experFTW		
ren	V11886 		farmerH			
ren V11888 		business
ren V11396		blincH			
ren V12372 		lH
gen blincW 		= .				
ren V11404 		lW			
ren V12371 		incF
gen occH_alt	= .
gen occH1		= .
ren V11651		occH2
gen occH3		= .
gen occH4		= .
gen indH_alt	= .
gen indH1		= .
ren V11652		indH2
gen indH3		= .
gen indH4		= .
gen occW_alt	= .
gen occW1		=.
ren V12014		occW2
gen occW3		= .
gen occW4		= .
gen indW_alt	= .
gen indW1		= .
ren V12015		indW2
gen indW3		= .
gen indW4		= .	

gen wave 		= 1985

* cd $EXPORTSdir
compress
save FAM1985.dta, replace 


/*******************************************************************************
Family (Interview) File - Wave 1986
*******************************************************************************/	

*cd $DATAdir
use f1986.dta, clear

#delimit;
keep 	V12502 V12503 V13010 V13014 V13015 V13533 V13484 V12510 V13011 V13012 
		V13565 V13665 V13013 V13500 V13046 V13049 V12545 V13605 V13606 V13225 
		V13228 V12657 V13531 V13532 V13397 V13399 V12795 V13624 V12803 V13623 		 
		V13640 V13641 V13054 V13055 V13233 V13234;	
#delimit cr

ren V12502 		id				
ren V12503 		state		
ren V13010 		numfu		
ren V13014 		kids		
ren V13015 		ageK		
ren V13533 		newH		
ren	V13484 		newW	
ren V12510 		newF		
ren V13011 		ageH		
ren V13012 		sexH		
ren V13565 		raceH				
ren V13665 		maritalH
gen educH		= .		
ren V13640		educH2	
ren V13013 		ageW		
ren V13500 		raceW				
gen educW		= .
ren V13641		educW2
ren V13046  	emplH
gen selfH1 		= .	
gen selfH2 		= .	
gen selfH3 		= .	
gen selfH4 		= .	
ren V13049 		selfH			
ren V12545 		hoursH
ren	V13605 		experH
ren	V13606 		experFTH		
ren V13225 		emplW
gen selfW1 		= .	
gen selfW2 		= .	
gen selfW3 		= .	
gen selfW4 		= .
ren V13228 		selfW	
ren V12657 		hoursW
ren	V13531 		experW
ren	V13532 		experFTW		
ren	V13397 		farmerH			
ren V13399 		business
ren V12795		blincH			
ren V13624 		lH
gen blincW 		= .				
ren V12803 		lW	
ren V13623 		incF
gen occH_alt	= .
gen occH1		= .
ren V13054		occH2
gen occH3		= .
gen occH4		= .
gen indH_alt	= .
gen indH1		= .
ren V13055		indH2
gen indH3		= .
gen indH4		= .
gen occW_alt	= .
gen occW1		=.
ren V13233		occW2
gen occW3		= .
gen occW4		= .
gen indW_alt	= .
gen indW1		= .
ren V13234		indW2
gen indW3		= .
gen indW4		= .			

gen wave 		= 1986

* cd $EXPORTSdir
compress
save FAM1986.dta, replace 


/*******************************************************************************
Family (Interview) File - Wave 1987
*******************************************************************************/	

*cd $DATAdir
use f1987.dta, clear

#delimit;
keep 	V13702 V13703 V14113 V14117 V14118 V14580 V14531 V13710 V14114 V14115 
		V14612 V14712 V14116 V14547 V14146 V14149 V13745 V14652 V14653 V14321 
		V14324 V13809 V14578 V14579 V14494 V14496 V13897 V14671 V13905 V14670		 
		V14688 V14687 V14154 V14155 V14329 V14330; 	
#delimit cr

ren V13702 		id				
ren V13703 		state		
ren V14113 		numfu		
ren V14117 		kids		
ren V14118 		ageK		
ren V14580   	newH		
ren	V14531 		newW	
ren V13710 		newF		
ren V14114 		ageH		
ren V14115 		sexH		
ren V14612 		raceH				
ren V14712 		maritalH
gen educH		= .	
ren V14687		educH2		
ren V14116   	ageW		
ren V14547 		raceW				
gen educW		= .
ren V14688		educW2
ren V14146 		emplH
gen selfH1 		= .	
gen selfH2 		= .	
gen selfH3 		= .	
gen selfH4 		= .	
ren V14149 		selfH			
ren V13745 		hoursH
ren	V14652 		experH
ren	V14653 		experFTH		
ren V14321 		emplW
gen selfW1 		= .	
gen selfW2 		= .	
gen selfW3 		= .	
gen selfW4 		= .
ren V14324 		selfW	
ren V13809 		hoursW
ren	V14578 		experW
ren	V14579 		experFTW		
ren	V14494 		farmerH			
ren V14496		business
ren V13897		blincH			
ren V14671 		lH
gen blincW 		= .		
ren V13905 		lW	
ren V14670 		incF
gen occH_alt	= .
gen occH1		= .
ren V14154		occH2
gen occH3		= .
gen occH4		= .
gen indH_alt	= .
gen indH1		= .
ren V14155		indH2
gen indH3		= .
gen indH4		= .
gen occW_alt	= .
gen occW1		=.
ren V14329		occW2
gen occW3		= .
gen occW4		= .
gen indW_alt	= .
gen indW1		= .
ren V14330		indW2
gen indW3		= .
gen indW4		= .		

gen wave 		= 1987

* cd $EXPORTSdir
compress
save FAM1987.dta, replace 


/*******************************************************************************
Family (Interview) File - Wave 1988
*******************************************************************************/	

*cd $DATAdir
use f1988.dta, clear

#delimit;
keep 	V14802 V14803 V15129 V15133 V15134 V16054 V16005 V14810 V15130 V15131 
		V16086 V16187 V15132 V16021 V15154 V15157 V14835 V16126 V16127 V15456 
		V15459 V14865 V16052 V16053 V15762 V15764 V14912 V16145 V14920 V16144 
		V16161 V16162 V15162 V15163 V15464 V15465; 	
#delimit cr

ren V14802 		id				
ren V14803 		state		
ren V15129 		numfu		
ren V15133 		kids		
ren V15134 		ageK		
ren V16054 		newH		
ren	V16005 		newW	
ren V14810 		newF		
ren V15130 		ageH		
ren V15131 		sexH		
ren V16086 		raceH				
ren V16187 		maritalH
gen educH		= .	
ren V16161		educH2			
ren V15132 		ageW		
ren V16021 		raceW				
gen educW		= .
ren V16162		educW2
ren V15154 		emplH
gen selfH1 		= .	
gen selfH2 		= .	
gen selfH3 		= .	
gen selfH4 		= .	
ren V15157 		selfH			
ren V14835 		hoursH
ren	V16126 		experH
ren	V16127 		experFTH		
ren V15456 		emplW
gen selfW1 		= .	
gen selfW2 		= .	
gen selfW3 		= .	
gen selfW4 		= .
ren V15459 		selfW	
ren V14865 		hoursW
ren	V16052 		experW
ren	V16053 		experFTW		
ren	V15762 		farmerH			
ren V15764 		business
ren V14912		blincH			
ren V16145 		lH
gen blincW 		= .	
ren V14920 		lW					
ren V16144 		incF
gen occH_alt	= .
gen occH1		= .
ren V15162		occH2
gen occH3		= .
gen occH4		= .
gen indH_alt	= .
gen indH1		= .
ren V15163		indH2
gen indH3		= .
gen indH4		= .
gen occW_alt	= .
gen occW1		=.
ren V15464		occW2
gen occW3		= .
gen occW4		= .
gen indW_alt	= .
gen indW1		= .
ren V15465		indW2
gen indW3		= .
gen indW4		= .			

gen wave 		= 1988

* cd $EXPORTSdir
compress
save FAM1988.dta, replace 


/*******************************************************************************
Family (Interview) File - Wave 1989
*******************************************************************************/	

*cd $DATAdir
use f1989.dta, clear

#delimit;
keep 	V16302 V16303 V16630 V16634 V16635 V17451 V17402 V16310 V16631 V16632 
		V17483 V17565 V16633 V17418 V16655 V16658 V16335 V17523 V17524 V16974 
		V16977 V16365 V17449 V17450 V17297 V17299 V16412 V17534 V16420
		V17533 V17545 V17546 V16663 V16664 V16982 V16983; 	
#delimit cr

ren V16302 		id				
ren V16303 		state		
ren V16630 		numfu		
ren V16634 		kids		
ren V16635 		ageK		
ren V17451 		newH		
ren	V17402 		newW	
ren V16310 		newF		
ren V16631 		ageH		
ren V16632 		sexH		
ren V17483 		raceH				
ren V17565 		maritalH
gen educH		= .		
ren V17545		educH2	
ren V16633 		ageW		
ren V17418 		raceW				
gen educW		= .
ren V17546		educW2
ren V16655 		emplH
gen selfH1 		= .	
gen selfH2 		= .	
gen selfH3 		= .	
gen selfH4 		= .	
ren V16658 		selfH			
ren V16335 		hoursH
ren	V17523 		experH
ren	V17524 		experFTH		
ren V16974 		emplW
gen selfW1 		= .	
gen selfW2 		= .	
gen selfW3 		= .	
gen selfW4 		= .
ren V16977 		selfW	
ren V16365 		hoursW
ren	V17449 		experW
ren	V17450 		experFTW	
ren	V17297 		farmerH			
ren V17299 		business
ren V16412		blincH			
ren V17534 		lH
gen blincW 		= .
ren V16420 		lW
ren V17533 		incF
gen occH_alt	= .
gen occH1		= .
ren V16663		occH2
gen occH3		= .
gen occH4		= .
gen indH_alt	= .
gen indH1		= .
ren V16664		indH2
gen indH3		= .
gen indH4		= .
gen occW_alt	= .
gen occW1		=.
ren V16982		occW2
gen occW3		= .
gen occW4		= .
gen indW_alt	= .
gen indW1		= .
ren V16983		indW2
gen indW3		= .
gen indW4		= .					

gen wave 		= 1989

* cd $EXPORTSdir
compress
save FAM1989.dta, replace 


/*******************************************************************************
Family (Interview) File - Wave 1990
*******************************************************************************/	

*cd $DATAdir
use f1990.dta, clear

#delimit;
keep 	V17702 V17703 V18048 V18052 V18053 V18782 V18733 V17710 V18049 V18050 
		V18814 V18916 V18051 V18749 V18093 V18096 V17744 V18854 V18855 V18395 
		V18398 V17774 V18780 V18781 V18701 V18703 V17828 V18878 V17836 V18875 
		V18898 V18899 V18101 V18102 V18403 V18404; 	
#delimit cr

ren V17702 		id				
ren V17703 		state		
ren V18048 		numfu		
ren V18052 		kids		
ren V18053 		ageK		
ren V18782 		newH		
ren	V18733 		newW	
ren V17710 		newF		
ren V18049 		ageH		
ren V18050 		sexH		
ren V18814 		raceH				
ren V18916 		maritalH
gen educH		= .		
ren V18898		educH2	
ren V18051 		ageW		
ren V18749 		raceW				
gen educW		= .
ren V18899		educW2
ren V18093 		emplH
gen selfH1 		= .	
gen selfH2 		= .	
gen selfH3 		= .	
gen selfH4 		= .	
ren V18096 		selfH			
ren V17744 		hoursH
ren	V18854 		experH
ren	V18855 		experFTH		
ren V18395 		emplW
gen selfW1 		= .	
gen selfW2 		= .	
gen selfW3 		= .	
gen selfW4 		= .
ren V18398  	selfW	
ren V17774 		hoursW
ren	V18780 		experW
ren	V18781 		experFTW	
ren	V18701 		farmerH			
ren V18703 		business
ren V17828		blincH			
ren V18878 		lH
gen blincW 		= .	
ren V17836 		lW				
ren V18875 		incF	
gen occH_alt	= .
gen occH1		= .
ren V18101		occH2
gen occH3		= .
gen occH4		= .
gen indH_alt	= .
gen indH1		= .
ren V18102		indH2
gen indH3		= .
gen indH4		= .
gen occW_alt	= .
gen occW1		=.
ren V18403		occW2
gen occW3		= .
gen occW4		= .
gen indW_alt	= .
gen indW1		= .
ren V18404		indW2
gen indW3		= .
gen indW4		= .				

gen wave 		= 1990

* cd $EXPORTSdir
compress
save FAM1990.dta, replace 


/*******************************************************************************
Family (Interview) File - Wave 1991
*******************************************************************************/		

*cd $DATAdir
use f1991.dta, clear

#delimit;
keep 	V19002 V19003 V19348 V19352 V19353 V20082 V20033 V19010 V19349 V19350 
		V20114 V20216 V20198 V19351 V20049 V20199 V19393 V19396 V19044 V20154 
		V20155 V19695 V19698 V19074 V20080 V20081 V20001 V20003 V19128 V20178 
		V19136 V20175 V19401 V19402 V19703 V19704;	
#delimit cr

ren V19002 		id				
ren V19003 		state		
ren V19348 		numfu		
ren V19352 		kids		
ren V19353 		ageK		
ren V20082 		newH		
ren	V20033 		newW	
ren V19010 		newF		
ren V19349 		ageH		
ren V19350 		sexH		
ren V20114 		raceH				
ren V20216 		maritalH
ren V20198 		educH	
gen educH2		= .				
ren V19351 		ageW		
ren V20049 		raceW				
ren V20199 		educW
gen educW2		= .
ren V19393 		emplH
gen selfH1 		= .	
gen selfH2 		= .	
gen selfH3 		= .	
gen selfH4 		= .	
ren V19396 		selfH			
ren V19044 		hoursH
ren	V20154 		experH
ren	V20155 		experFTH	
ren V19695 		emplW
gen selfW1 		= .	
gen selfW2 		= .	
gen selfW3 		= .	
gen selfW4 		= .
ren V19698 		selfW	
ren V19074 		hoursW
ren	V20080 		experW
ren	V20081 		experFTW		
ren	V20001 		farmerH			
ren V20003 		business
ren V19128		blincH			
ren V20178 		lH
gen blincW 		= .
ren V19136 		lW				
ren V20175 		incF
gen occH_alt	= .
gen occH1		= .
ren V19401		occH2
gen occH3		= .
gen occH4		= .
gen indH_alt	= .
gen indH1		= .
ren V19402		indH2
gen indH3		= .
gen indH4		= .
gen occW_alt	= .
gen occW1		=.
ren V19703		occW2
gen occW3		= .
gen occW4		= .
gen indW_alt	= .
gen indW1		= .
ren V19704		indW2
gen indW3		= .
gen indW4		= .					

gen wave 		= 1991

* cd $EXPORTSdir
compress
save FAM1991.dta, replace 


/*******************************************************************************
Family (Interview) File - Wave 1992
*******************************************************************************/	

*cd $DATAdir
use f1992.dta, clear

#delimit;
keep 	V20302 V20303 V20650 V20654 V20655 V21388 V21339 V20310 V20651 V20652 
		V21420 V21522 V21504 V20653 V21355 V21505 V20693 V20696 V20344 V21460 
		V21461 V20995 V20998 V20374 V21386 V21387 V21301 V21303 V20428 V21484 
		V20436 V21481 V20701 V20702 V21003 V21004; 	
#delimit cr

ren V20302 		id				
ren V20303		state		
ren V20650		numfu		
ren V20654		kids		
ren V20655		ageK		
ren V21388		newH		
ren	V21339 		newW		
ren V20310		newF		
ren V20651		ageH		
ren V20652 		sexH		
ren V21420 		raceH				
ren V21522 		maritalH
ren V21504		educH	
gen educH2		= .				
ren V20653		ageW		
ren V21355 		raceW					
ren V21505		educW
gen educW2		= .
ren V20693 		emplH
gen selfH1 		= .	
gen selfH2 		= .	
gen selfH3 		= .	
gen selfH4 		= .	
ren V20696		selfH			
ren V20344		hoursH
ren	V21460 		experH
ren	V21461 		experFTH		
ren V20995 		emplW
gen selfW1 		= .	
gen selfW2 		= .	
gen selfW3 		= .	
gen selfW4 		= .
ren V20998		selfW	
ren V20374		hoursW
ren	V21386 		experW
ren	V21387 		experFTW		
ren	V21301		farmerH		
ren V21303		business
ren V20428		blincH			
ren V21484		lH
gen blincW 		= .
ren V20436 		lW	
ren V21481		incF
gen occH_alt	= .
gen occH1		= .
ren V20701		occH2
gen occH3		= .
gen occH4		= .
gen indH_alt	= .
gen indH1		= .
ren V20702		indH2
gen indH3		= .
gen indH4		= .
gen occW_alt	= .
gen occW1		=.
ren V21003		occW2
gen occW3		= .
gen occW4		= .
gen indW_alt	= .
gen indW1		= .
ren V21004		indW2
gen indW3		= .
gen indW4		= .					

gen wave 		= 1992

* cd $EXPORTSdir
compress
save FAM1992.dta, replace 


/*******************************************************************************
Family (Interview) File - Wave 1993
*******************************************************************************/		

*cd $DATAdir
use f1993.dta, clear

#delimit;
keep 	V21602 V21603 V22405 V22409 V22410 V23245 V23196 V21608 V22406 V22407 
		V23276 V23336 V23333 V22408 V23212 V23334 V22448 V22451 V21634 V23316 
		V23317 V22801 V22804 V21670 V23243 V23244 V23160 V23162 V21738 V23323 
		V21806 V23324 V23322 V22456 V22457 V22809 V22810; 	
#delimit cr

ren V21602	id				
ren V21603	state		
ren V22405 	numfu		
ren V22409	kids		
ren V22410 	ageK		
ren V23245  newH		
ren V23196  newW		
ren V21608 	newF		
ren V22406  ageH		
ren V22407	sexH		
ren V23276	raceH				
ren V23336 	maritalH	
ren V23333 	educH	
gen educH2	= .					
ren V22408 	ageW		
ren V23212 	raceW						
ren V23334  educW	
gen educW2	= .				
ren V22448	emplH
gen selfH1 	= .	
gen selfH2 	= .	
gen selfH3 	= .	
gen selfH4 	= .			
ren V22451	selfH			
ren V21634	hoursH
ren	V23316 	experH
ren	V23317 	experFTH		
ren V22801 	emplW
gen selfW1 	= .	
gen selfW2 	= .	
gen selfW3 	= .	
gen selfW4 	= .		
ren V22804	selfW			
ren V21670	hoursW
ren	V23243 	experW
ren	V23244 	experFTW	
ren	V23160	farmerH			
ren V23162	business
ren V21738	blincH		
ren V23323	lH
ren V21806	blincW
ren	V23324	lW							
ren V23322	incF
gen occH_alt	= .
gen occH1		= .
ren V22456		occH2
gen occH3		= .
gen occH4		= .
gen indH_alt	= .
gen indH1		= .
ren V22457		indH2
gen indH3		= .
gen indH4		= .
gen occW_alt	= .
gen occW1		=.
ren V22809		occW2
gen occW3		= .
gen occW4		= .
gen indW_alt	= .
gen indW1		= .
ren V22810		indW2
gen indW3		= .
gen indW4		= .					

gen wave = 1993

* cd $EXPORTSdir
compress
save FAM1993.dta, replace 


/*******************************************************************************
Family (Interview) File - Wave 1994
*******************************************************************************/		

*cd $DATAdir
use f1994.dta, clear

#delimit;
keep 	ER2002 ER4156 ER2006 ER2010 ER2011 ER3917 ER3863 ER2007 ER2008 ER3944 
	    ER4159A ER4158 ER2009 ER3883 ER4159 ER2069 ER2074 ER4096 ER3985 ER3986 
		ER2563 ER2568 ER4107 ER3915 ER3916 ER3092 ER3096 ER4119 ER4140 ER4141 
		ER4144 ER4153 ER4017 ER4018 ER4048 ER4049;
#delimit cr

ren ER2002	id						
ren ER4156 	state		
ren ER2006 	numfu		
ren ER2010 	kids		
ren ER2011 	ageK		
ren ER3917 	newH		
ren ER3863 	newW		
gen newF	= .		
ren ER2007	ageH		
ren ER2008	sexH		
ren ER3944	raceH				
ren ER4159A maritalH	
ren ER4158	educH	
gen educH2	= .				
ren ER2009 	ageW		
ren ER3883 	raceW					
ren ER4159 	educW
gen educW2	= .					
ren ER2069 	emplH
gen selfH1 	= .	
gen selfH2 	= .	
gen selfH3 	= .	
gen selfH4 	= .		
ren ER2074 	selfH		
ren ER4096 	hoursH
ren	ER3985 	experH
ren	ER3986 	experFTH		
ren ER2563 	emplW
gen selfW1 	= .	
gen selfW2 	= .	
gen selfW3 	= .	
gen selfW4 	= .		
ren ER2568 	selfW			
ren ER4107 	hoursW
ren	ER3915 	experW
ren	ER3916 	experFTW	
ren ER3092 	farmerH				
ren ER3096 	business
ren ER4119	blincH		
ren ER4140 	lH
ren ER4141	blincW									
ren ER4144 	lW		
ren ER4153 	incF
gen occH_alt	= .
gen occH1		= .
ren ER4017		occH2
gen occH3		= .
gen occH4		= .
gen indH_alt	= .
gen indH1		= .
ren ER4018		indH2
gen indH3		= .
gen indH4		= .
gen occW_alt	= .
gen occW1		=.
ren ER4048		occW2
gen occW3		= .
gen occW4		= .
gen indW_alt	= .
gen indW1		= .
ren ER4049		indW2
gen indW3		= .
gen indW4		= .						

gen wave = 1994

* cd $EXPORTSdir
compress
save FAM1994.dta, replace 


/*******************************************************************************
Family (Interview) File - Wave 1995
*******************************************************************************/	

*cd $DATAdir
use f1995.dta, clear

#delimit;
keep 	ER5002 ER6996 ER5005 ER5009 ER5010 ER6787 ER6733 ER5006 ER5007 ER6814 
		ER6999A ER6998 ER5008 ER6753 ER6999 ER5068 ER5073 ER6936 ER6855 ER6856 
		ER5562 ER5567 ER6947 ER6785 ER6786 ER6092 ER6096 ER6959 ER6980 ER6981 
		ER6984 ER6993 ER6857 ER6858 ER6888 ER6889;	
#delimit cr

ren ER5002	id					
ren ER6996 	state		
ren ER5005 	numfu		
ren ER5009 	kids		
ren ER5010 	ageK		
ren ER6787 	newH		
ren ER6733 	newW		
gen	newF	= .		
ren ER5006 	ageH		
ren ER5007 	sexH		
ren ER6814 	raceH					
ren ER6999A maritalH	
ren ER6998 	educH
gen educH2	= .							
ren ER5008 	ageW		
ren ER6753 	raceW						
ren ER6999 	educW	
gen educW2	= .				
ren ER5068 	emplH
gen selfH1 	= .	
gen selfH2 	= .	
gen selfH3 	= .	
gen selfH4 	= .		
ren ER5073 	selfH		
ren ER6936 	hoursH
ren	ER6855 	experH
ren	ER6856 	experFTH	
ren ER5562 	emplW
gen selfW1 	= .	
gen selfW2 	= .	
gen selfW3 	= .	
gen selfW4 	= .		
ren ER5567 	selfW			
ren ER6947 	hoursW
ren	ER6785 	experW
ren	ER6786 	experFTW	
ren ER6092 	farmerH				
ren ER6096 	business
ren ER6959	blincH		
ren ER6980 	lH
ren ER6981	blincW				
ren ER6984 	lW									
ren ER6993 	incF
gen occH_alt	= .
gen occH1		= .
ren ER6857		occH2
gen occH3		= .
gen occH4		= .
gen indH_alt	= .
gen indH1		= .
ren ER6858		indH2
gen indH3		= .
gen indH4		= .
gen occW_alt	= .
gen occW1		=.
ren ER6888		occW2
gen occW3		= .
gen occW4		= .
gen indW_alt	= .
gen indW1		= .
ren ER6889		indW2
gen indW3		= .
gen indW4		= .						

gen wave = 1995

* cd $EXPORTSdir
compress
save FAM1995.dta, replace


/*******************************************************************************
Family (Interview) File - Wave 1996
*******************************************************************************/	

*cd $DATAdir
use f1996.dta, clear

#delimit;
keep 	ER7002 ER9247 ER7005 ER7009 ER7010 ER9033 ER8979 ER7006 ER7007 ER9060 
		ER9250A ER9249 ER7008 ER8999 ER9250 ER7164 ER7169 ER9187 ER9101 ER9102 
		ER7658 ER7663 ER9198 ER9031 ER9032 ER8189 ER8193 ER9210 ER9231 ER9232 
		ER9235 ER9244 ER9108 ER9109 ER9139 ER9140;
#delimit cr
		
ren ER7002	id				
ren ER9247 	state		
ren ER7005 	numfu		
ren ER7009 	kids		
ren ER7010 	ageK		
ren ER9033 	newH		
ren ER8979 	newW		
gen newF	= .	
ren ER7006 	ageH		
ren ER7007 	sexH		
ren ER9060 	raceH						
ren ER9250A maritalH	
ren ER9249 	educH	
gen educH2	= .				
ren ER7008 	ageW		
ren ER8999 	raceW					
ren ER9250 	educW	
gen educW2	= .				
ren ER7164 	emplH
gen selfH1 	= .	
gen selfH2 	= .	
gen selfH3 	= .	
gen selfH4 	= .	
ren ER7169 	selfH			
ren ER9187 	hoursH
ren	ER9101 	experH
ren	ER9102 	experFTH		
ren ER7658 	emplW
gen selfW1 	= .	
gen selfW2 	= .	
gen selfW3 	= .	
gen selfW4 	= .		
ren ER7663 	selfW			
ren ER9198 	hoursW
ren	ER9031 	experW
ren	ER9032 	experFTW		
ren ER8189 	farmerH				
ren ER8193 	business
ren ER9210	blincH			
ren ER9231 	lH
ren ER9232	blincW	
ren ER9235 	lW	
ren ER9244 	incF
gen occH_alt	= .
gen occH1		= .
ren ER9108		occH2
gen occH3		= .
gen occH4		= .
gen indH_alt	= .
gen indH1		= .
ren ER9109		indH2
gen indH3		= .
gen indH4		= .
gen occW_alt	= .
gen occW1		=.
ren ER9139		occW2
gen occW3		= .
gen occW4		= .
gen indW_alt	= .
gen indW1		= .
ren ER9140		indW2
gen indW3		= .
gen indW4		= .				

gen wave = 1996

* cd $EXPORTSdir
compress
save FAM1996.dta, replace


/*******************************************************************************
Family (Interview) File - Wave 1997
*******************************************************************************/		

*cd $DATAdir
use f1997.dta, clear

#delimit;
keep 	ER10002 ER12221 ER10008 ER10012 ER10013 ER11812 ER11731 ER10009 ER10010 
		ER11848 ER12223A ER12222 ER10011 ER11760 ER12223 ER10081 ER10086 ER12174 
		ER11897 ER11898 ER10563 ER10568 ER12185 ER11809 ER11810 ER11084 ER11088 
		ER12193 ER12080 ER12214 ER12082 ER12079 ER12085 ER12086 ER12116 ER12117;
#delimit cr
		
ren ER10002	id							
ren ER12221 state		
ren ER10008 numfu		
ren ER10012 kids		
ren ER10013 ageK		
ren ER11812 newH		
ren ER11731 newW		
gen	newF	= .	
ren ER10009 ageH		
ren ER10010 sexH		
ren ER11848 raceH				
ren ER12223A maritalH	
ren ER12222 educH
gen educH2	= .							
ren ER10011 ageW		
ren ER11760 raceW					
ren ER12223 educW	
gen educW2	= .				
ren ER10081 emplH
gen selfH1 	= .	
gen selfH2 	= .	
gen selfH3 	= .	
gen selfH4 	= .		
ren ER10086 selfH		
ren ER12174 hoursH
ren	ER11897 experH
ren	ER11898 experFTH		
ren ER10563 emplW
gen selfW1 	= .	
gen selfW2 	= .	
gen selfW3 	= .	
gen selfW4 	= .		
ren ER10568 selfW			
ren ER12185 hoursW
ren	ER11809 experW
ren	ER11810 experFTW	
ren ER11084 farmerH				
ren ER11088 business
ren ER12193	blincH		
ren ER12080 lH
ren ER12214	blincW	
ren ER12082 lW							
ren ER12079 incF
gen occH_alt	= .
gen occH1		= .
ren ER12085		occH2
gen occH3		= .
gen occH4		= .
gen indH_alt	= .
gen indH1		= .
ren ER12086		indH2
gen indH3		= .
gen indH4		= .
gen occW_alt	= .
gen occW1		=.
ren ER12116		occW2
gen occW3		= .
gen occW4		= .
gen indW_alt	= .
gen indW1		= .
ren ER12117		indW2
gen indW3		= .
gen indW4		= .							

gen wave = 1997

* cd $EXPORTSdir
compress
save FAM1997.dta, replace


/*******************************************************************************
Family (Interview) File - Wave 1999
*******************************************************************************/		

*cd $DATAdir
use f1999.dta, clear

#delimit;
keep 	ER13002 ER13004 ER13009 ER13013 ER13014 ER15890 ER15805 ER13010 ER13011 
		ER15928 ER16423 ER16516 ER13012 ER15836 ER16517 ER13205 ER13210 ER16471 
		ER15979 ER15980 ER13717 ER13722 ER16482 ER15886 ER15887 ER14345 ER14349 
		ER16490 ER16463 ER16511 ER16465 ER16462 ER13215 ER13216 ER13727 ER13728;
#delimit cr
	
ren ER13002	id							
ren ER13004 state		
ren ER13009 numfu		
ren ER13013 kids		
ren ER13014 ageK		
ren ER15890 newH		
ren ER15805 newW		
gen	newF	= .		
ren ER13010 ageH		
ren ER13011 sexH		
ren ER15928 raceH				
ren ER16423 maritalH	
ren ER16516 educH
gen educH2	= .							
ren ER13012 ageW		
ren ER15836 raceW			
ren ER16517 educW	
gen educW2	= .				
ren ER13205 emplH
gen selfH1 	= .	
gen selfH2 	= .	
gen selfH3 	= .	
gen selfH4 	= .		
ren ER13210 selfH			
ren ER16471 hoursH
ren	ER15979 experH
ren	ER15980 experFTH		
ren ER13717 emplW
gen selfW1 	= .	
gen selfW2 	= .	
gen selfW3 	= .	
gen selfW4 	= .	
ren ER13722 selfW			
ren ER16482 hoursW
ren	ER15886 experW
ren	ER15887 experFTW	
ren ER14345 farmerH				
ren ER14349 business
ren ER16490	blincH		
ren ER16463 lH
ren ER16511	blincW			
ren ER16465 lW										
ren ER16462 incF
gen occH_alt	= .
gen occH1		= .
ren ER13215		occH2
gen occH3		= .
gen occH4		= .
gen indH_alt	= .
gen indH1		= .
ren ER13216		indH2
gen indH3		= .
gen indH4		= .
gen occW_alt	= .
gen occW1		=.
ren ER13727		occW2
gen occW3		= .
gen occW4		= .
gen indW_alt	= .
gen indW1		= .
ren ER13728		indW2
gen indW3		= .
gen indW4		= .					

gen wave = 1999

* cd $EXPORTSdir
compress
save FAM1999.dta, replace


/*******************************************************************************
Family (Interview) File - Wave 2001
*******************************************************************************/		

*cd $DATAdir
use f2001.dta, clear

#delimit;
keep 	ER17002 ER17004 ER17012 ER17016 ER17017 ER19951 ER19866 ER17007 ER17013 
		ER17014 ER19989 ER20369 ER20457 ER17015 ER19897 ER20458 ER17216 ER17221 
		ER20399 ER20040 ER20041 ER17786 ER17791 ER20410 ER19947 ER19948 ER18484 
		ER18489 ER20422 ER20443 ER20444 ER20447 ER20456 ER17226 ER17227 ER17796
		ER17797;
#delimit cr
	
ren ER17002	id						
ren ER17004 state		
ren ER17012 numfu		
ren ER17016 kids		
ren ER17017 ageK		
ren ER19951 newH		
ren ER19866 newW		
ren ER17007 newF		
ren ER17013 ageH		
ren ER17014 sexH		
ren ER19989 raceH				
ren ER20369 maritalH	
ren ER20457 educH	
gen educH2	= .						
ren ER17015 ageW		
ren ER19897 raceW			
ren ER20458 educW	
gen educW2	= .				
ren ER17216 emplH
gen selfH1 	= .	
gen selfH2 	= .	
gen selfH3 	= .	
gen selfH4 	= .	
ren ER17221	selfH			
ren ER20399 hoursH
ren	ER20040 experH
ren	ER20041 experFTH		
ren ER17786 emplW
gen selfW1 	= .	
gen selfW2 	= .	
gen selfW3 	= .	
gen selfW4 	= .		
ren ER17791	selfW			
ren ER20410 hoursW
ren	ER19947 experW
ren	ER19948 experFTW	
ren ER18484 farmerH				
ren ER18489 business
ren ER20422	blincH		
ren ER20443 lH
ren ER20444	blincW				
ren ER20447 lW								
ren ER20456 incF
gen occH_alt	= .
gen occH1		= .
ren ER17226		occH2
gen occH3		= .
gen occH4		= .
gen indH_alt	= .
gen indH1		= .
ren ER17227		indH2
gen indH3		= .
gen indH4		= .
gen occW_alt	= .
gen occW1		=.
ren ER17796		occW2
gen occW3		= .
gen occW4		= .
gen indW_alt	= .
gen indW1		= .
ren ER17797		indW2
gen indW3		= .
gen indW4		= .				

gen wave = 2001

* cd $EXPORTSdir
compress
save FAM2001.dta, replace


/*******************************************************************************
Family (Interview) File - Wave 2003
*******************************************************************************/		

*cd $DATAdir
use f2003.dta, clear

#delimit;
keep 	ER21002 ER21003 ER21016 ER21020 ER21021 ER23388 ER23303 ER21007 ER21017 
		ER21018 ER23426 ER24150 ER24148 ER21019 ER23334 ER24149 ER21123 ER21147 
		ER21203 ER21235 ER21267 ER24080 ER23476 ER23477 ER21373 ER21397 ER21453 
		ER21485 ER21517 ER24091 ER23384 ER23385 ER21852 ER21857 ER24109 ER24116 
		ER24111 ER24135 ER24099 ER21145 ER21146 ER21395 ER21396;
#delimit cr
		
ren ER21002	id				
ren ER21003 state		
ren ER21016 numfu		
ren ER21020 kids		
ren ER21021 ageK		
ren ER23388 newH		
ren ER23303 newW		
ren ER21007 newF		
ren ER21017 ageH		
ren ER21018 sexH		
ren ER23426 raceH			
ren ER24150 maritalH	
ren ER24148 educH
gen educH2	= .						
ren ER21019 ageW		
ren ER23334 raceW					
ren ER24149 educW	
gen educW2	= .				
ren ER21123 emplH	
ren ER21147 selfH1		
ren ER21203 selfH2		
ren ER21235 selfH3		
ren ER21267 selfH4		
gen	selfH	= .		
ren ER24080 hoursH
ren	ER23476 experH
ren	ER23477 experFTH	
ren ER21373 emplW	
ren ER21397 selfW1 		
ren ER21453 selfW2		
ren ER21485 selfW3		
ren ER21517 selfW4		
gen	selfW	= .			
ren ER24091 hoursW
ren	ER23384 experW
ren	ER23385 experFTW		
ren ER21852 farmerH				
ren ER21857 business
ren ER24109	blincH		
ren ER24116 lH
ren ER24111	blincW					
ren ER24135 lW									
ren ER24099 incF
gen occH_alt	= .
gen occH1		= .
gen occH2		= .
ren ER21145		occH3
gen occH4		= .
gen indH_alt	= .
gen indH1		= .
gen indH2		= .
ren ER21146		indH3
gen indH4		= .
gen occW_alt	= .
gen occW1		=.
gen occW2		= .
ren ER21395		occW3
gen occW4		= .
gen indW_alt	= .
gen indW1		= .
gen indW2		= .
ren ER21396		indW3
gen indW4		= .	
				

gen wave = 2003

* cd $EXPORTSdir
compress
save FAM2003.dta, replace


/*******************************************************************************
Family (Interview) File - Wave 2005
*******************************************************************************/		

*cd $DATAdir
use f2005.dta, clear

#delimit;
keep 	ER25002 ER25003 ER25016 ER25020 ER25021 ER27352 ER27263 ER25007 ER25017 
		ER25018 ER27393 ER28049 ER28047 ER25019 ER27297 ER28048 ER25104 ER25129 
		ER25192 ER25224 ER25256 ER27886 ER27444 ER27445 ER25362 ER25387 ER25450 
		ER25482 ER25514 ER27897 ER27348 ER27349 ER25833 ER25838 ER27910 ER27931 
		ER27940 ER27943 ER28037 ER25127 ER25128 ER25385 ER25386;
#delimit cr
	
ren ER25002 id					
ren ER25003 state		
ren ER25016 numfu		
ren ER25020 kids		
ren ER25021 ageK		
ren ER27352 newH		
ren ER27263 newW		
ren ER25007 newF		
ren ER25017 ageH		
ren ER25018 sexH		
ren ER27393 raceH					
ren ER28049 maritalH	
ren ER28047 educH	
gen educH2	= .						
ren ER25019 ageW		
ren ER27297 raceW					
ren ER28048 educW	
gen educW2	= .				
ren ER25104 emplH	
ren ER25129 selfH1		
ren ER25192 selfH2		
ren ER25224 selfH3		
ren ER25256 selfH4		
gen	selfH	= .			
ren ER27886 hoursH
ren	ER27444 experH
ren	ER27445 experFTH		
ren ER25362 emplW	
ren ER25387 selfW1 		
ren ER25450 selfW2		
ren ER25482 selfW3		
ren ER25514 selfW4		
gen	selfW	= .		
ren ER27897 hoursW
ren	ER27348 experW
ren	ER27349 experFTW	
ren ER25833 farmerH				
ren ER25838 business
ren ER27910	blincH		
ren ER27931 lH
ren ER27940	blincW		
ren ER27943 lW									
ren ER28037 incF
gen occH_alt	= .
gen occH1		= .
gen occH2		= .
ren ER25127		occH3
gen occH4		= .
gen indH_alt	= .
gen indH1		= .
gen indH2		= .
ren ER25128		indH3
gen indH4		= .
gen occW_alt	= .
gen occW1		=.
gen occW2		= .
ren ER25385		occW3
gen occW4		= .
gen indW_alt	= .
gen indW1		= .
gen indW2		= .
ren ER25386		indW3
gen indW4		= .						

gen wave = 2005

* cd $EXPORTSdir
compress
save FAM2005.dta, replace


/*******************************************************************************
Family (Interview) File - Wave 2007
*******************************************************************************/	

*cd $DATAdir
use f2007.dta, clear

#delimit;
keep 	ER36002 ER36003 ER36016 ER36020 ER36021 ER40527 ER40438 ER36007 ER36017 
		ER36018 ER40565 ER41039 ER41037 ER36019 ER40472 ER41038 ER36109 ER36134 
		ER36197 ER36229 ER36261 ER40876 ER40616 ER40617 ER36367 ER36392 ER36455 
		ER36487 ER36519 ER40887 ER40523 ER40524 ER36851 ER36856 ER40900 ER40921 
		ER40930 ER40933 ER41027 ER36132 ER36133 ER36390 ER36391;
#delimit cr

ren ER36002	id					
ren ER36003 state		
ren ER36016 numfu		
ren ER36020 kids		
ren ER36021 ageK		
ren ER40527 newH		
ren ER40438 newW		
ren ER36007 newF		
ren ER36017 ageH		
ren ER36018 sexH		
ren ER40565 raceH						
ren ER41039 maritalH	
ren ER41037 educH
gen educH2	= .							
ren ER36019 ageW		
ren ER40472 raceW						
ren ER41038 educW
gen educW2	= .					
ren ER36109 emplH	
ren ER36134 selfH1		
ren ER36197 selfH2		
ren ER36229 selfH3		
ren ER36261 selfH4		
gen	selfH	= .		
ren ER40876 hoursH
ren	ER40616 experH
ren	ER40617 experFTH	
ren ER36367 emplW	
ren ER36392 selfW1 		
ren ER36455 selfW2		
ren ER36487 selfW3		
ren ER36519 selfW4		
gen	selfW	= .	
ren ER40887 hoursW
ren	ER40523 experW
ren	ER40524 experFTW	
ren ER36851 farmerH			
ren ER36856 business
ren ER40900	blincH	
ren ER40921 lH
ren ER40930	blincW									
ren ER40933 lW			
ren ER41027 incF
gen occH_alt	= .
gen occH1		= .
gen occH2		= .
ren ER36132		occH3
gen occH4		= .
gen indH_alt	= .
gen indH1		= .
gen indH2		= .
ren ER36133		indH3
gen indH4		= .
gen occW_alt	= .
gen occW1		=.
gen occW2		= .
ren ER36390		occW3
gen occW4		= .
gen indW_alt	= .
gen indW1		= .
gen indW2		= .
ren ER36391		indW3
gen indW4		= .				
					

gen wave = 2007

* cd $EXPORTSdir
compress
save FAM2007.dta, replace


/*******************************************************************************
Family (Interview) File - Wave 2009
*******************************************************************************/		

*cd $DATAdir
use f2009.dta, clear

#delimit;
keep	ER42002 ER42003 ER42016 ER42020 ER42021 ER46504 ER46410 ER42007 ER42017 
		ER42018 ER46543 ER46983 ER46981 ER42019 ER46449 ER46982 ER42140 ER42169 
		ER42230 ER42260 ER42290 ER46767 ER46594 ER46595 ER42392 ER42421 ER42482 
		ER42512 ER42542 ER46788 ER46500 ER46501 ER42842 ER42847 ER46808 ER46829 
		ER46838 ER46841 ER46935 ER42167 ER42168 ER42419 ER42420;
#delimit cr
	
ren ER42002 id					
ren ER42003 state		
ren ER42016 numfu		
ren ER42020 kids		
ren ER42021 ageK		
ren ER46504 newH		
ren ER46410 newW		
ren ER42007 newF		
ren ER42017 ageH		
ren ER42018 sexH		
ren ER46543 raceH				
ren ER46983 maritalH	
ren ER46981 educH
gen educH2	= .						
ren ER42019 ageW		
ren ER46449 raceW				
ren ER46982 educW
gen educW2	= .				
ren ER42140 emplH	
ren ER42169 selfH1		
ren ER42230 selfH2		
ren ER42260 selfH3		
ren ER42290 selfH4		
gen	selfH	= .		
ren ER46767 hoursH
ren	ER46594 experH
ren	ER46595 experFTH		
ren ER42392 emplW	
ren ER42421 selfW1 		
ren ER42482 selfW2		
ren ER42512 selfW3		
ren ER42542 selfW4		
gen	selfW	= .		
ren ER46788 hoursW
ren	ER46500 experW
ren	ER46501 experFTW	
ren ER42842 farmerH			
ren ER42847 business
ren ER46808	blincH		
ren ER46829 lH
ren ER46838	blincW		
ren ER46841 lW									
ren ER46935 incF
gen occH_alt	= .
gen occH1		= .
gen occH2		= .
ren ER42167		occH3
gen occH4		= .
gen indH_alt	= .
gen indH1		= .
gen indH2		= .
ren ER42168		indH3
gen indH4		= .
gen occW_alt	= .
gen occW1		=.
gen occW2		= .
ren ER42419		occW3
gen occW4		= .
gen indW_alt	= .
gen indW1		= .
gen indW2		= .
ren ER42420		indW3
gen indW4		= .							

gen wave = 2009

* cd $EXPORTSdir
compress
save FAM2009.dta, replace


/*******************************************************************************
Family (Interview) File - Wave 2011
*******************************************************************************/		

*cd $DATAdir
use f2011.dta, clear

#delimit;
keep 	ER47302 ER47303 ER47316 ER47320 ER47321 ER51865 ER51771 ER47307 ER47317 
		ER47318 ER51904 ER52407 ER52405 ER47319 ER51810 ER52406 ER47448 ER47482 
		ER47543 ER47573 ER47603 ER52175 ER51955 ER51956 ER47705 ER47739 ER47800 
		ER47830 ER47860 ER52196 ER51861 ER51862 ER48164 ER48169 ER52216 ER52237 
		ER52246 ER52249 ER52343 ER47479 ER47480 ER47736 ER47737;
#delimit cr

ren ER47302	id						
ren ER47303	state		
ren ER47316	numfu		
ren ER47320	kids		
ren ER47321	ageK		
ren ER51865	newH		
ren ER51771	newW		
ren ER47307	newF		
ren ER47317	ageH		
ren ER47318	sexH		
ren ER51904	raceH				
ren ER52407	maritalH	
ren ER52405	educH		
gen educH2	= .					
ren ER47319	ageW		
ren ER51810	raceW					
ren ER52406	educW
gen educW2	= .					
ren ER47448	emplH	
ren ER47482	selfH1		
ren ER47543	selfH2		
ren ER47573	selfH3		
ren ER47603	selfH4		
gen	selfH	= .	
ren ER52175	hoursH
ren	ER51955 experH
ren	ER51956 experFTH		
ren ER47705	emplW	
ren ER47739	selfW1 		
ren ER47800	selfW2		
ren ER47830	selfW3		
ren ER47860	selfW4		
gen	selfW	= .		
ren ER52196	hoursW
ren	ER51861 experW
ren	ER51862 experFTW	
ren ER48164	farmerH				
ren ER48169	business
ren ER52216	blincH
ren ER52237	lH
ren ER52246	blincW	
ren ER52249	lW								
ren ER52343	incF
gen occH_alt	= .
gen occH1		= .
gen occH2		= .
ren ER47479		occH3
gen occH4		= .
gen indH_alt	= .
gen indH1		= .
gen indH2		= .
ren ER47480		indH3
gen indH4		= .
gen occW_alt	= .
gen occW1		=.
gen occW2		= .
ren ER47736		occW3
gen occW4		= .
gen indW_alt	= .
gen indW1		= .
gen indW2		= .
ren ER47737		indW3
gen indW4		= .									

gen wave = 2011

* cd $EXPORTSdir
compress
save FAM2011.dta, replace


/*******************************************************************************
Family (Interview) File - Wave 2013
*******************************************************************************/	

*cd $DATAdir
use f2013.dta, clear

#delimit;
keep 	ER53002 ER53003 ER53016 ER53020 ER53021 ER57618 ER57508 ER53007 ER53017 
		ER53018 ER57659 ER58225 ER58223 ER53019 ER57549 ER58224 ER53148 ER53182 
		ER53243 ER53273 ER53303 ER57976 ER57711 ER57712 ER53411 ER53445 ER53506 
		ER53536 ER53566 ER57997 ER57601 ER57602 ER53858 ER53863 ER58017 ER58038 
		ER58047 ER58050 ER58152 ER53179 ER53180 ER53442 ER53443;
#delimit cr

ren ER53002	id						
ren ER53003	state		
ren ER53016	numfu		
ren ER53020	kids		
ren ER53021	ageK		
ren ER57618	newH		
ren ER57508	newW		
ren ER53007	newF		
ren ER53017	ageH		
ren ER53018	sexH		
ren ER57659	raceH				
ren ER58225	maritalH	
ren ER58223	educH		
gen educH2	= .					
ren ER53019	ageW		
ren ER57549	raceW					
ren ER58224	educW
gen educW2	= .					
ren ER53148	emplH	
ren ER53182	selfH1		
ren ER53243	selfH2		
ren ER53273	selfH3		
ren ER53303	selfH4		
gen	selfH	= .	
ren ER57976	hoursH
ren	ER57711 experH
ren	ER57712 experFTH		
ren ER53411	emplW	
ren ER53445	selfW1 		
ren ER53506	selfW2		
ren ER53536	selfW3		
ren ER53566	selfW4		
gen	selfW	= .		
ren ER57997	hoursW
ren	ER57601 experW
ren	ER57602 experFTW	
ren ER53858	farmerH				
ren ER53863	business
ren ER58017	blincH
ren ER58038	lH
ren ER58047	blincW	
ren ER58050	lW								
ren ER58152	incF
gen occH_alt	= .
gen occH1		= .
gen occH2		= .
ren ER53179		occH3
gen occH4		= .
gen indH_alt	= .
gen indH1		= .
gen indH2		= .
ren ER53180		indH3
gen indH4		= .
gen occW_alt	= .
gen occW1		=.
gen occW2		= .
ren ER53442		occW3
gen occW4		= .
gen indW_alt	= .
gen indW1		= .
gen indW2		= .
ren ER53443		indW3
gen indW4		= .									

gen wave = 2013

* cd $EXPORTSdir
compress
save FAM2013.dta, replace


/*******************************************************************************
Family (Interview) File - Wave 2015
*******************************************************************************/	

*cd $DATAdir
use f2015.dta, clear

#delimit;
keep 	ER60002 ER60003 ER60016 ER60021 ER60022 ER64769 ER64630 ER60007 ER60017 
		ER60018 ER64810 ER65461 ER65459 ER60019 ER64671 ER65460 ER60163 ER60197 
		ER60258 ER60288 ER60318 ER65156 ER64871 ER64872 ER60426 ER60460 ER60521 
		ER60551 ER60581 ER65177 ER64732 ER64733 ER60917 ER60922 ER65197 ER65216 
		ER65225 ER65244 ER65349 ER60194 ER60195 ER60457 ER60458;
#delimit cr

ren ER60002	id						
ren ER60003	state		
ren ER60016	numfu		
ren ER60021	kids		
ren ER60022	ageK		
ren ER64769	newH		
ren ER64630	newW		
ren ER60007	newF		
ren ER60017	ageH		
ren ER60018	sexH		
ren ER64810	raceH				
ren ER65461	maritalH	
ren ER65459	educH	
gen educH2	= .						
ren ER60019	ageW		
ren ER64671	raceW					
ren ER65460	educW
gen educW2	= .					
ren ER60163	emplH	
ren ER60197	selfH1		
ren ER60258	selfH2		
ren ER60288	selfH3		
ren ER60318	selfH4		
gen	selfH	= .	
ren ER65156	hoursH
ren	ER64871 experH
ren	ER64872 experFTH		
ren ER60426	emplW	
ren ER60460	selfW1 		
ren ER60521	selfW2		
ren ER60551	selfW3		
ren ER60581	selfW4		
gen	selfW	= .		
ren ER65177	hoursW
ren	ER64732 experW
ren	ER64733 experFTW	
ren ER60917	farmerH				
ren ER60922	business
ren ER65197	blincH
ren ER65216	lH
ren ER65225	blincW	
ren ER65244	lW								
ren ER65349	incF
gen occH_alt	= .
gen occH1		= .
gen occH2		= .
ren ER60194		occH3
gen occH4		= .
gen indH_alt	= .
gen indH1		= .
gen indH2		= .
ren ER60195		indH3
gen indH4		= .
gen occW_alt	= .
gen occW1		=.
gen occW2		= .
ren ER60457		occW3
gen occW4		= .
gen indW_alt	= .
gen indW1		= .
gen indW2		= .
ren ER60458		indW3
gen indW4		= .									

gen wave = 2015

* cd $EXPORTSdir
compress
save FAM2015.dta, replace


/*******************************************************************************
Family (Interview) File - Wave 2017
*******************************************************************************/

*cd $DATAdir
use f2017.dta, clear

#delimit;
keep 	ER66002 ER66003 ER66016 ER66021 ER66022 ER70841 ER70703 ER66007 ER66017
		ER66018 ER70882 ER71540 ER71538 ER71539 ER66019 ER70744 ER66164 ER66198 
		ER66261 ER66291 ER66321 ER71233 ER70943 ER70944 ER66439 ER66473 ER66536 
		ER66566 ER66596 ER71254 ER70805 ER70806 ER66969 ER66974 ER71274 ER71293 
		ER71302 ER71321 ER71426 ER66195 ER66196 ER66470 ER66471;
#delimit cr

ren ER66002		id						
ren ER66003		state		
ren ER66016		numfu		
ren ER66021		kids		
ren ER66022		ageK		
ren ER70841		newH		
ren ER70703		newW		
ren ER66007		newF		
ren ER66017		ageH		
ren ER66018		sexH		
ren ER70882		raceH				
ren ER71540		maritalH
ren ER71538		educH	
gen educH2	= .							
ren ER66019		ageW		
ren ER70744		raceW
ren ER71539		educW
gen educW2	= .						
ren ER66164		emplH	
ren ER66198		selfH1		
ren ER66261		selfH2		
ren ER66291		selfH3		
ren ER66321		selfH4		
gen	selfH		= .	
ren ER71233		hoursH
ren	ER70943 	experH
ren	ER70944 	experFTH
ren ER66439		emplW	
ren ER66473		selfW1 		
ren ER66536		selfW2		
ren ER66566		selfW3		
ren ER66596		selfW4		
gen	selfW		= .		
ren ER71254		hoursW	
ren	ER70805 	experW
ren	ER70806 	experFTW
ren ER66969		farmerH				
ren ER66974		business
ren ER71274		blincH
ren ER71293		lH
ren ER71302		blincW
ren ER71321		lW
ren ER71426		incF
gen occH_alt	= .
gen occH1		= .
gen occH2		= .
gen occH3		= .
ren ER66195		occH4
gen indH_alt	= .
gen indH1		= .
gen indH2		= .
gen indH3		= .
ren ER66196		indH4
gen occW_alt	= .
gen occW1		=.
gen occW2		= .
gen occW3		= .
ren ER66470		occW4
gen indW_alt	= .
gen indW1		= .
gen indW2		= .
gen indW3		= .
ren ER66471		indW4				

gen wave = 2017

* cd $EXPORTSdir
compress
save FAM2017.dta, replace

/*******************************************************************************
Family (Interview) File - Wave 2019
*******************************************************************************/

*cd $DATAdir
use f2019.dta, clear

#delimit;
keep 	ER72002 ER72003 ER72016 ER72021 ER72022 ER76856 ER76711 ER72007 ER72017
		ER72018 ER76897 ER77601 ER77599 ER77600 ER72019 ER76752 ER72164 ER72198 
		ER72261 ER72291 ER72321 ER77255 ER76961 ER76962 ER72441 ER72475 ER72538 
		ER72568 ER72598 ER77276 ER76816 ER76817 ER72992 ER72997 ER77296 ER77315 
		ER77324 ER77343 ER77448 ER72195 ER72196 ER72472 ER72473;
#delimit cr

ren ER72002		id						
ren ER72003		state		
ren ER72016		numfu		
ren ER72021		kids		
ren ER72022		ageK		
ren ER76856		newH		
ren ER76711		newW	
ren ER72007		newF		
ren ER72017		ageH		
ren ER72018		sexH		
ren ER76897		raceH			
ren ER77601		maritalH
ren ER77599		educH	
gen educH2	= .					
ren ER72019		ageW 		
ren ER76752		raceW
ren ER77600		educW
gen educW2	= .					
ren ER72164		emplH	
ren ER72198		selfH1		
ren ER72261		selfH2		
ren ER72291		selfH3		
ren ER72321		selfH4		
gen	selfH		= .	
ren ER77255		hoursH
ren	ER76961 	experH
ren	ER76962		experFTH
ren ER72441		emplW	
ren ER72475		selfW1 		
ren ER72538		selfW2		
ren ER72568		selfW3		
ren ER72598		selfW4		
gen	selfW		= .		
ren ER77276		hoursW
ren	ER76816 	experW
ren	ER76817		experFTW
ren ER72992		farmerH	
ren ER72997		business
ren ER77296		blincH
ren ER77315		lH
ren ER77324		blincW
ren ER77343		lW
ren ER77448		incF
gen occH_alt	= .
gen occH1		= .
gen occH2		= .
gen occH3		= .
ren ER72195 	occH4
gen indH_alt	= .
gen indH1		= .
gen indH2		= .
gen indH3		= .
ren ER72196		indH4
gen occW_alt	= .
gen occW1		=.
gen occW2		= .
gen occW3		= .
ren ER72472		occW4
gen indW_alt	= .
gen indW1		= .
gen indW2		= .
gen indW3		= .
ren ER72473		indW4		

gen wave = 2019

* cd $EXPORTSdir
compress
save FAM2019.dta, replace

/*******************************************************************************
Family (Interview) File - Wave 2021
*******************************************************************************/

*cd $DATAdir
use f2021.dta, clear

#delimit;
keep 	ER78002 ER78003 ER78016 ER78021 ER78022 ER80976 ER81103 ER78007 ER78017
		ER78018 ER81144 ER81928 ER81926 ER81927 ER78019 ER81017 ER78167 ER78203 
		ER78266 ER78296 ER78326 ER81582 ER81189 ER81190 ER78481 ER78517 ER78580 
		ER78610 ER78640 ER81603 ER81062 ER81063 ER79069 ER79074 ER81623 ER81642 
		ER81651 ER81670 ER81775 ER78198 ER78199 ER78512 ER78513;
#delimit cr

ren ER78002		id						
ren ER78003		state		
ren ER78016		numfu		
ren ER78021		kids		
ren ER78022		ageK		
ren ER81103		newH		
ren ER80976		newW	
ren ER78007		newF		
ren ER78017		ageH		
ren ER78018		sexH		
ren ER81144		raceH			
ren ER81928		maritalH
ren ER81926		educH
gen educH2	= .						
ren ER78019		ageW 		
ren ER81017		raceW
ren ER81927		educW
gen educW2	= .					
ren ER78167		emplH	
ren ER78203		selfH1		
ren ER78266		selfH2		
ren ER78296		selfH3		
ren ER78326		selfH4		
gen	selfH		= .	
ren ER81582		hoursH
ren	ER81189 	experH
ren	ER81190		experFTH
ren ER78481		emplW	
ren ER78517		selfW1 		
ren ER78580		selfW2		
ren ER78610		selfW3		
ren ER78640		selfW4		
gen	selfW		= .		
ren ER81603		hoursW
ren	ER81062		experW
ren	ER81063		experFTW
ren ER79069		farmerH	
ren ER79074		business
ren ER81623		blincH
ren ER81642		lH
ren ER81651		blincW
ren ER81670		lW
ren ER81775		incF
gen occH_alt	= .
gen occH1		= .
gen occH2		= .
gen occH3		= .
ren ER78198		occH4
gen indH_alt	= .
gen indH1		= .
gen indH2		= .
gen indH3		= .
ren ER78199		indH4
gen occW_alt	= .
gen occW1		=.
gen occW2		= .
gen occW3		= .
ren ER78512		occW4
gen indW_alt	= .
gen indW1		= .
gen indW2		= .
gen indW3		= .
ren ER78513		indW4		

gen wave = 2021

* cd $EXPORTSdir
compress
save FAM2021.dta, replace

/*******************************************************************************
Append yearly family files to generate repeated cross-section
*******************************************************************************/

* cd $EXPORTSdir
use FAM2021.dta, clear

forvalues yy = 2019 2017 to 1999 {
	append using "FAM`yy'.dta"
}
forvalues yy = 97 96 to 68 {
	append using "FAM19`yy'.dta"
}
order id wave
sort wave id

*	Label variables:		
label variable 	id			"Interview #"	
label variable 	wave 		"PSID wave"	
label variable 	state		"State"
label variable 	numfu		"# FU Members"
label variable 	kids		"# Children"
label variable 	ageK		"Age youngest child"
label variable 	newH		"New HD"
label variable 	newW		"New WF"
label variable 	newF		"New Fam"
label variable 	ageH		"Age HD"
label variable 	sexH		"Sex HD"
label variable 	raceH		"Race HD"
label variable 	maritalH	"Marital status HD"
label variable 	educH		"Education HD"
label variable 	ageW		"Age WF"
label variable 	raceW		"Race WF"
label variable 	educW		"Education WF"
label variable 	emplH		"Employment HD"
label variable 	selfH1		"Self empl HD mention 1"
label variable 	selfH2		"Self empl HD mention 2"
label variable 	selfH3		"Self empl HD mention 3"
label variable 	selfH4		"Self empl HD mention 4"
label variable 	selfH		"Self Employm HD"
label variable 	hoursH		"Hours HD"
label variable 	emplW		"Employment WF"
label variable 	selfW1 		"Self empl WF mention 1"
label variable 	selfW2		"Self empl WF mention 2"
label variable 	selfW3		"Self empl WF mention 3"
label variable 	selfW4		"Self empl WF mention 4"
label variable 	selfW		"Self Employm WF"
label variable 	hoursW		"Hours WF"
label variable 	farmerH		"HD farmer?"
label variable 	business	"Own business?"
label variable 	lH			"Earnings HD"
label variable 	lW			"Earnings WF"
label variable 	blincH 		"Labor part business HD"
label variable 	blincW		"Labor part business WF"
label variable 	incF		"Total family income"
label variable  experH		"Experience HD"
label variable 	experFTH	"FT experience HD"
label variable 	experW		"Experience WF"
label variable 	experFTW	"FT experience WF"

*	Save dataset:
* cd $EXPORTSdir
save cross_sectional_1968_2021.dta, replace

forvalues yy = 68 69 to 97 {
	erase "FAM19`yy'.dta"
}
forvalues yy = 1999 2001 to 2021 {
	erase "FAM`yy'.dta"
} 
*

/*******************************************************************************
Individual file 1968-2017: Creation of panel
*******************************************************************************/

*cd $DATAdir
use i1968_2021.dta, clear

#delimit;
/*																		1968	1969		*/
keep																	ER30001	ER30020		/* interview number 	*/
																				ER30021		/* sequence number 		*/
																		ER30003 ER30022	 	/* relationship head 	*/
																		/* ER30010 	*/		/* education  			*/
/*		1970	1971	1972	1973	1974	1975	1976	1977	1978	1979		*/
		ER30043	ER30067	ER30091	ER30117	ER30138	ER30160	ER30188	ER30217	ER30246	ER30283		/* interview number 	*/
		ER30044	ER30068	ER30092 ER30118	ER30139	ER30161	ER30189	ER30218	ER30247	ER30284		/* sequence number 		*/
		ER30045 ER30069	ER30093	ER30119 ER30140 ER30162 ER30190 ER30219 ER30248 ER30285  	/* relationship head 	*/
	/*	ER30052 ER30076 ER30100 ER30126 ER30147 ER30169 ER30197 ER30226 ER30255 ER30296  */	/* education  			*/
/*		1980	1981	1982	1983	1984	1985	1986	1987	1988	1989		*/
		ER30313	ER30343 ER30373	ER30399	ER30429	ER30463	ER30498	ER30535	ER30570	ER30606		/* interview number 	*/
		ER30314	ER30344 ER30374	ER30400	ER30430	ER30464	ER30499	ER30536	ER30571	ER30607		/* sequence number 		*/
		ER30315 ER30345 ER30375 ER30401 ER30431 ER30465 ER30500 ER30537 ER30572 ER30608  	/* relationship head 	*/
	/*	ER30326 ER30356 ER30384 ER30413 ER30443 ER30478 ER30513 ER30549 ER30584 ER30620  */	/* education  			*/
/*		1990	1991	1992 	1993	1994	1995	1996	1997			1999		*/
		ER30642	ER30689	ER30733 ER30806 ER33101 ER33201 ER33301 ER33401 		ER33501 	/* interview number 	*/
		ER30643	ER30690	ER30734 ER30807 ER33102 ER33202 ER33302 ER33402 		ER33502 	/* sequence number 		*/
		ER30644 ER30691 ER30735 ER30808 ER33103 ER33203 ER33303 ER33403 		ER33503 	/* relationship head 	*/
	/*	ER30657 ER30703 ER30748 ER30820 ER33115 ER33215 ER33315 ER33415 		ER33516 */	/* education  			*/
/*				2001			2003			2005			2007			2009		*/
				ER33601 		ER33701 		ER33801 		ER33901 		ER34001 	/* interview number 	*/
				ER33602 		ER33702 		ER33802 		ER33902 		ER34002 	/* sequence number 		*/
				ER33603 		ER33703 		ER33803 		ER33903 		ER34003		/* relationship head 	*/
	/*			ER33616 		ER33716 		ER33817  		ER33917 		ER34020 */	/* education  			*/
/*				2011			2013			2015			2017			2019		*/	
				ER34101			ER34201 		ER34301			ER34501			ER34701		/* interview number 	*/	
				ER34102			ER34202 		ER34302			ER34502			ER34702		/* sequence number 		*/
				ER34103			ER34203  		ER34303			ER34503			ER34703		/* relationship head 	*/
	/*			ER34119 		ER34230 		ER34349			ER34548			ER34752		*/	/* education  			*/
/*				2021		*/	
				ER34901			
				ER34902			
				ER34903			
	/*			ER34052 	*/			
				ER32000   	/* sex of individual	*/	
				ER32022     /* live births to this individual */
				ER32023     /* month first/only child born */
				ER32024  ;  /* year first/only child born */

#delimit cr 

ren ER30001 fam68
ren ER32000 sex
ren ER32022 numbirth
ren ER32023 birthmonth
ren ER32024 birthyear

ren ER30020 id1969
ren ER30043	id1970
ren ER30067	id1971
ren ER30091	id1972
ren ER30117	id1973
ren ER30138	id1974
ren ER30160	id1975
ren ER30188	id1976
ren ER30217	id1977
ren ER30246	id1978
ren ER30283	id1979
ren ER30313	id1980
ren ER30343	id1981
ren ER30373	id1982
ren ER30399	id1983
ren ER30429	id1984
ren ER30463	id1985
ren ER30498	id1986
ren ER30535	id1987
ren ER30570	id1988
ren ER30606	id1989
ren ER30642	id1990
ren ER30689	id1991
ren ER30733	id1992
ren ER30806	id1993
ren ER33101	id1994
ren ER33201 id1995
ren ER33301 id1996
ren ER33401 id1997
ren ER33501 id1999
ren ER33601 id2001
ren ER33701 id2003
ren ER33801 id2005
ren ER33901 id2007
ren ER34001	id2009
ren ER34101 id2011
ren ER34201 id2013
ren ER34301 id2015
ren ER34501 id2017
ren ER34701 id2019
ren ER34901 id2021

ren ER30021 seq1969
ren	ER30044	seq1970
ren	ER30068	seq1971
ren	ER30092	seq1972
ren	ER30118	seq1973
ren	ER30139	seq1974
ren	ER30161	seq1975
ren	ER30189	seq1976
ren	ER30218	seq1977
ren	ER30247	seq1978
ren	ER30284	seq1979
ren	ER30314	seq1980
ren	ER30344	seq1981
ren	ER30374	seq1982
ren	ER30400	seq1983
ren	ER30430	seq1984
ren	ER30464	seq1985
ren	ER30499	seq1986
ren	ER30536	seq1987
ren	ER30571	seq1988
ren	ER30607	seq1989
ren	ER30643	seq1990
ren	ER30690	seq1991
ren	ER30734	seq1992
ren ER30807 seq1993
ren ER33102 seq1994
ren ER33202 seq1995
ren ER33302 seq1996
ren ER33402 seq1997
ren ER33502 seq1999
ren ER33602 seq2001
ren ER33702 seq2003
ren ER33802 seq2005
ren ER33902 seq2007
ren ER34002 seq2009
ren ER34102 seq2011
ren ER34202 seq2013
ren ER34302 seq2015
ren ER34502 seq2017
ren ER34702 seq2019
ren ER34902 seq2021

ren ER30003 rel1968
ren ER30022 rel1969
ren ER30045 rel1970
ren ER30069	rel1971
ren ER30093	rel1972
ren ER30119 rel1973
ren ER30140 rel1974
ren ER30162 rel1975
ren ER30190 rel1976
ren ER30219 rel1977
ren ER30248 rel1978
ren ER30285 rel1979
ren ER30315 rel1980
ren ER30345 rel1981
ren ER30375 rel1982
ren ER30401 rel1983
ren ER30431 rel1984
ren ER30465 rel1985
ren ER30500 rel1986
ren ER30537 rel1987
ren ER30572 rel1988
ren ER30608 rel1989
ren ER30644 rel1990
ren ER30691 rel1991
ren ER30735 rel1992
ren ER30808 rel1993
ren ER33103 rel1994
ren ER33203 rel1995
ren ER33303 rel1996
ren ER33403 rel1997
ren ER33503 rel1999
ren ER33603 rel2001
ren ER33703 rel2003
ren ER33803 rel2005
ren ER33903 rel2007
ren ER34003 rel2009
ren ER34103 rel2011
ren ER34203 rel2013
ren ER34303 rel2015
ren ER34503 rel2017
ren ER34703 rel2019
ren ER34903 rel2021

/*
ren ER30010 ed1968
gen ed1969 = .
ren ER30052 ed1970
ren ER30076 ed1971
ren ER30100 ed1972
ren ER30126 ed1973
ren ER30147 ed1974
ren ER30169 ed1975
ren ER30197 ed1976
ren ER30226 ed1977
ren ER30255 ed1978
ren ER30296 ed1979
ren ER30326 ed1980
ren ER30356 ed1981
ren ER30384 ed1982
ren ER30413 ed1983
ren ER30443 ed1984
ren ER30478 ed1985
ren ER30513 ed1986
ren ER30549 ed1987
ren ER30584 ed1988
ren ER30620 ed1989
ren ER30657 ed1990
ren ER30703 ed1991
ren ER30748 ed1992
ren ER30820 ed1993
ren ER33115 ed1994
ren ER33215 ed1995
ren ER33315 ed1996
ren ER33415 ed1997
ren ER33516 ed1999
ren ER33616 ed2001
ren ER33716 ed2003
ren ER33817 ed2005
ren ER33917 ed2007
ren ER34020 ed2009
ren ER34119 ed2011
ren ER34230 ed2013
ren ER34349 ed2015
ren ER34548 ed2017
ren ER34752 ed2019
ren ER34952 ed2019
*/

*	Label different samples within PSID. I will only use the core sample:
gen sample = 1											/* core src family 		*/
replace sample = 2 if fam68 >= 5001 & fam68 <= 6872		/* low income seo family*/
replace sample = 3 if fam68 >= 3001 & fam68 <= 3511		/* immigrant family		*/
replace sample = 4 if fam68 >= 7001						/* Latino family		*/ 
label define samplel 1 "core" 2 "low_income" 3 "immigrants" 4 "Latino"
label values sample samplel 

*	Generate unique id for each person in the dataset & convert to long.
* 	'person_id' uniquely describes an individual in the dataset:
gen person_id = 1
replace person_id = sum(person_id)
reshape long id seq rel, i(person_id fam68 sample sex numbirth birthmonth birthyear) j(wave)
replace id = fam68 if wave==1968
sort person_id wave
order id wave person_id
drop if id == 0	/* I drop person-years that have intv_id == 0 (no interview) */

*	Drop all those who aren't HH heads in any given year: 
gen head = 1 if (rel == 1 & seq >= 1 & seq <= 20) | (rel == 10 & seq >= 1 & seq <= 20) | (wave==1968 & rel==1)
drop if head != 1
sort person_id wave
drop seq rel head

*	Verify that there aren't any duplicate 'intv_id's to avoid problems when
*	merging with the family (interview) files:
forvalues i = 1997 1999 to 2021 {						
duplicates tag id if wave == `i', gen(dup_intv)
qui sum dup_intv if wave == `i'
	if r(mean) != 0 {
		error(1)
	}					
drop dup_intv	
}
*

/********************************************************************************************
Merge Family (Interview) and Individual Files - Years 1968-2021 (biennially from 1999 onward)
*********************************************************************************************/

sort wave id
*cd $STATAdir
merge 1:1 id wave using cross_sectional_1968_2021.dta

*	Interrupt if merge was not perfect:
qui sum _merge
if r(mean) != 3 {
	error(1)
}
drop _merge

*	Order, label variables, sort:
rename person_id hh_id
order hh_id wave fam68 id newH newW ageH ageW newF numfu kids lH lW emplH* emplW*
label variable hh_id	"HH ID" 
label variable wave		"WAVE"
label variable id	"INTERVIEW #"
sort hh_id wave
 
merge m:1 wave using CPI.dta, nogenerate

*Preliminary
label define selfHL  ///
       1 "Someone else"  ///
       2 "Both someone and self"  ///
       3 "Self only" ///
	   4 "NA, DK" ///
	   8 "NA, DK" ///
	   9 "NA, DK" ///
	   0 "Inap.: unemployed, retired, housewife, student"
	   
label values selfH selfHL

* cd $EXPORTSdir
save panel_1968_2021.dta, replace
*erase cross_sectional_1968_2021.dta
erase CPI.dta

*** end of do file ***
