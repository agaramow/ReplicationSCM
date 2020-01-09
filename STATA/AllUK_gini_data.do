cd "C:\Users\adeli\student-project-agaramow\SCM\Final_Data"

import excel AlldataUK_gini.xlsx, firstrow clear

gen ccode_nr = .
replace ccode_nr = 1 if Country=="Australia"
replace ccode_nr = 2 if Country=="Canada"
replace ccode_nr = 3 if Country=="Denmark"
replace ccode_nr = 4 if Country=="Finland"
replace ccode_nr = 5 if Country=="France"
replace ccode_nr = 6 if Country=="Germany"
replace ccode_nr = 7 if Country=="Ireland"
replace ccode_nr = 8 if Country=="Italy"
replace ccode_nr = 9 if Country=="Japan"
replace ccode_nr = 10 if Country=="Netherlands"
replace ccode_nr = 11 if Country=="New Zealand"
replace ccode_nr = 12 if Country=="Norway"
*replace ccode_nr = 13 if Country==""
*replace ccode_nr = 14 if Country==""
replace ccode_nr = 15 if Country=="Sweden"
replace ccode_nr = 16 if Country=="Switzerland"
replace ccode_nr = 17 if Country=="United Kingdom"

drop ccode
rename ccode_nr ccode

outsheet using AlldataUK_gini.csv, comma replace





