---

title: "A highchart of GDP growth"

categories: []

date: '2021-03-13T00:00:00Z'

draft: no

featured: no

gallery_item: null

image:
  caption: "https://unsplash.com/photos/tI_DEyjWOkY"
  focal_point: Top
  preview_only: no

projects: []

subtitle: null

summary: null

tags:
- Open Data
- Open Science
- Brazil
- Finance
- Research
- Master
- Phd

authors:
- admin
- Gerson

---

[Gerson](https://scholar.google.com/citations?user=bbgB49g0N2cC&hl=pt-BR) and I are working in several projects to foster Open Science in our research community. We are sharing in this post a code to create a map using open data from the World Bank. The code is simple, and you can pay all along it.

First, install and load these packages.

    library(WDI)
    library(highcharter)
    library(dplyr)
    library(maps)

Then, you need data. So download using the following code. It is a shame that we do not have 2020 data yet! Let's use 2019 insted.
	
    GDP <- WDI(
      country = "all",
      indicator = "NY.GDP.MKTP.KD.ZG",
      start = 2019,
      end = 2019,
      extra = FALSE,
      cache = NULL)
      
      
For simplicity, rename the collum where GDP Growth is.

      names(GDP)[names(GDP) == "NY.GDP.MKTP.KD.ZG"] <- "GDP_Growth"
      

Here is where you decide which countries you want to analyse. Let's keep in simple for the moment, and use only a few contries.

    Countries  <- c("Brazil","Argentina","Chile","Russian Federation","United States","China","Germany","Australia","South Africa","Canada","India","Egypt, Arab Rep.","United Kingdom")
    GDP_Filter <- GDP[GDP$country %in% Countries ,]

We also will need the list of ISO codes. You can find the ISO codes [here](https://www.iban.com/country-codes).

    Countries_iso3  <- c("BRA","ARG","CHL","RUS", "USA","CHN","DEU","AUS","ZAF","CAN","IND","EGY","GBR")


The rows below are necessary to create the map later. Basically, the map needs the ISO3 codes to read countries.

    dat <- iso3166
    dat <- rename(dat, "iso-a3" = a3 )
    dat = dat[dat$`iso-a3` %in% Countries_iso3 ,]
    GDP_Filter_Integer = as.integer(GDP_Filter$GDP_Growth)


Notice that China is duplicated in "dat". Let's remove it.

    dat<-dat[!duplicated(dat$sovereignty), ]
    
Now, let's merge the GDP Growth data with the ISO3 codes  

    dat$GDP <- GDP_Filter$GDP_Growth
    
    
Finally, the fun part. Create the map using the following code.    

    hc<-hcmap(
      map = "custom/world-highres3", 
      data = dat, 
      joinBy = "iso-a3",
      value = "GDP",
      showInLegend = FALSE, 
      nullColor = "#DADADA",
      download_map_data = TRUE) %>%
      hc_mapNavigation(enabled = TRUE) %>%
      hc_legend(align = "center",
                verticalAlign = "top",
                layout = "horizontal",
                x = 100,
                y = 0) %>%
      hc_title(text = "GDP Growth in 2019 for selected Countries")

      hc

This is what you have to find.


url_slides: "map.html"


{{% staticref "map.html" "newtab" %}}



This {{% staticref "files/map.html" "newtab" %}} here {{% /staticref %}}.
