
** IMPUTE *******************************************************************

***********************!!!!!!!!!!!ADJUST!!!!!!!!!!!!*************************
//adjust the following three locals:

//impute input 
#delimit ;
local imputeinput = `"
w1_x12122 
w1_x32007 
w1_x32010 
w1_x42030 
w1hhhage 
w1hhavage 
w1under6 
w1genratio 
w1_x31002 
w1_x31004 
w1_x31005a 
w1_x31006a 
w1_x41003 
w1ownlandaS 
w1ricekgtotL 
w1ricekgrai 
w1expendL 
w1ricekgsldL 
w1ricelandS 
w1_x42032 
w1_x43109 
w1_x43202n 
w1_x44002n 
w1_x50002n 
w1_x60002n 
w1_cap_total 



"'
;
#delimit cr


//impute input categorial
#delimit ;
local imputeinput_c = `"
w1hhhethn 
w1hhhrel 
w1hhhpol 
w1hhhgen 
w1hhhprim
"'
;
#delimit cr




//to be imputed

local tobeimputed = "$ylistw2 $ylistw3 $ylistw5 $ylistw6 $ylistw7 $ylistw8 $xlist $xlistw2 $xlistw3 $xlistw5 $xlistw6 $xlistw7 $xlistw8" // Shouldn't ylistw1 be added as well?
foreach var of local tobeimputed {
cap confirm variable `var'
if !_rc {
local tobeimputed2 "`tobeimputed2' `var'" // Alle Variablen die in den angegebenen Listen des locals tobeimputed enthalten sind, bekommen den prefix tobeimputed2
}
}


*****************************************************************************

sum vill
scalar N=r(N)

foreach var of varlist `tobeimputed2' {

	quiet tab `var'
	
	if r(N)<N {
	impute2 `var' `imputeinput', xc(`imputeinput_c') xl(T prov vill) nonegative
	table i`var' if `var'==.
	replace `var'=i`var' if `var'==.
	drop i`var'
	lab var `var' "IMP `: var lab `var''"
	}
}
*
