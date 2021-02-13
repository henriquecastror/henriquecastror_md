
use "D:\Dropbox\Artigos\Artigo 1 ESG\3 ESG and Corruption\2 data.dta"  , clear

keep if country =="Brazil"
drop if esg==.

drop if year<2010

keep year id_firm id_ind id_country ticker cname naics csr esg esge esgs esgg esgcomb esgcontr esgresources esgemissions esgenvinov esgwork esghr esgcom esgpr esgman esgshar esgcsr /*
*/ esg_z esge_z esgs_z esgg_z esgcomb_z esgcontr_z esgresources_z esgemissions_z esgenvinov_z esgwork_z esghr_z esgcom_z esgpr_z esgman_z esgshar_z esgcsr_z


bys ticker : egen n = count(year)

foreach x in esg esge esgs {

bys year : egen `x'_mean  = mean(`x')
bys year : egen `x'_meanN = mean(`x') if n ==10
}
*


twoway line esg_mean year , ytitle("Average Corporate ESG score") xtitle(Year) note(Source: Thomson Reuters) title("Evolution of Corporate ESG Score")  subtitle("All firms available in all years")  /*
*/ xlab(2010(1)2019) lc(edkblue) lwidth(medthick ) graphregion(color(eggshell)) 
graph export "Graph1.png", as(png) replace


twoway line esg_meanN year, ytitle("Average Corporate ESG score") xtitle(Year) note(Source: Thomson Reuters) title("Evolution of Corporate ESG Score")  subtitle("Firms with 10 years of data")  /*
*/ xlab(2010(1)2019) lc(dkgreen) lwidth(medthick ) graphregion(color(ltbluishgray))
graph export "Graph2.png", as(png) replace


save "esg post.dta" , replace
