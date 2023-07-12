
//TREATMENT
global treatment w3registered


//XVARS for PSM
//PRE-treatment characteristics that might have affected assignment to treatment. These variables should not be affected by the treatment!
//Often they take their values prior to unit being exposed to the treatment, although this is not sufficient condition. 
//This vector of covariates can include lagged outcomes.

#delimit ;
global xlist_base `"

w2ricekgtot
w2ricekgsld

w2_x41003
w2_x10093 
w2_x31024
w2_x32003

w2hhhprim 
w2hhhage  
w2under6 
w2hhhgen 
w2_x12122

"'
;
#delimit cr
dis  "$xlist_base"


*w2o14_oc_wa //had to be ecluded


#delimit ;
global xlist_all `"

w2_x31002
w2_x31004 
w2_x31005a

w2_x31025				

w2_x32004
w2_x32003a 

w2_x71514  

w2_x71133c
w2_x32010


w2expend
w2_x91009_a
w2agriloanD

w2o14_jobs
w2income

w2ricelandS
w2_x10084
w2_x10085 
w2_x10086 
w2_x10087
w2_x10088
w2_x10080   

w2_x43202n 
w2_x44002n 
w2_x50002n 
w2_x60002n 

"'
;
#delimit cr
dis  "$xlist_all"
//in general in this section: when DD takes out the w2 vars, is that good? nothing much left. should take out one by one and run design seperately for each yvar?
//why not productive assets?


global xlist $xlist_base $xlist_all 

*w2_x31025			w2_total	w2_x32004    w2_x42032 w2_x41003 w2_x12122 w2_x91009_a




** XVARS ADDITIONAL, ONLY FOR BALANCE TEST **

#delimit ;
global xlist_balance `"

w2anymem_oc_go
w2anymem_pol
w2hhhpol
w2takloanD 
w2n60borgov 
w2n60relfr
w2mregriskD

w2baacloanD

w2hhhprim7 
w2hhhread 
w2hhh_healthy 
w2hhh_canmanage 
w2hhh_sick 
w2hhedupr
w2hheduls
w2hhavage
w2btw020 
w2btw1016 
w2btw1115
w2btw1214
w2btw1564f
w2btw1564m

w2weatriskD
w2outpriskD 
w3outpriskD

w2pricekg
w2ppricekg 
w2pricekgD
w2ppricekgD 
w2pricekgsD
w2pprickgsD

w2ricelando

w3ricekgsld

w2casskgtot
w3casskgtot
w5casskgtot
w2cass
w3cass
w5cass

w2richD50

"'
;
#delimit cr
dis  "$xlist_balance"

// w2btw2040 
// w2btw4060 
// w2btw60up
//
// w2ricelandp 
// w2hhhsec
// w2baacloans 
// w2polloans 
// w2takloans  
//
// w2_x31013a 
// w2_x31013b 
// w2_x31014a 
// w2_x31014b 
// w2_x31019a 
// w2_x31019b 
// w2_x31020a 
// w2_x31020b
//
// w2hiredlab
// w2e_lndprep 
// w2e_seeds 
// w2e_fertil 
// w2e_pestiz 
// w2e_harvest 
// w2e_irrig 
//
// w2_x72201

// w2corncass

//XLIST w2 w3 w5 for FE ANALYSIS
foreach wave in w2 w3 w5 w6 w7 w8 {
#delimit ;
global xlist`wave' `"
          

"'
;
#delimit cr
dis  "$xlist`wave'"
}
*Add variable in the following format to the list:
*`wave'var      
*`wave'var           
*`wave'var 


//XLIST as controls in FE ANALYSIS
#delimit ;
global xlistfe`"

"'
;
#delimit cr
dis  "$xlistfe"



//CHECK FOR HIGHLY SKEWED VARS THAT COULD OFFSET PSCORE CALC
/*
foreach var of global xlist {
  hist `var', name(`var', replace) nodraw
  local graphs "`graphs' `var'"
}
graph combine `graphs', col(3) xsize(1.5) ysize(20) iscale(*2)
cd "$output"
graph export graphs.pdf
*/
