cd "C:\Users\adeli\student-project-agaramow\SCM\Final_Data"

import excel WID_middle40.xlsx, firstrow clear

drop sptinc_p50p90_z_DKPretaxnatio p50p90

rename Denmark Country
rename D year
rename E middle

save WID_middle40.dta, replace

import excel WID_lower50.xlsx, firstrow clear

drop sptinc_p0p50_z_DKPretaxnation p0p50

rename Denmark Country
rename D year
rename E lower

save WID_lower50.dta, replace

merge 1:1 Country year using WID_middle40.dta, nogen

save WID_data.dta, replace

outsheet using WID_data.csv, comma replace

levelsof Country
describe Country


