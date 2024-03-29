
library(udunits2)
library(units)
library(geobr)
library(sf)
library(ggplot2)
library(cowplot)
library(RColorBrewer)
library(dplyr)
dados <- structure(
  list(X = 1:27, 
       uf = c("Acre", "Alagoas", "Amap�", 
              "Amaz�nas", "Bahia", "Cear�", "Distrito Federal", "Esp�rito Santo", 
              "Goi�s", "Maranh�o", "Mato Grosso do Sul", "Mato Grosso", "Minas Gerais", 
              "Para�ba", "Paran�", "Par�", "Pernambuco", "Piau�", "Rio de Janeiro", 
              "Rio Grande do Norte", "Rio Grande do Sul", "Rond�nia", "Roraima", 
              "Santa Catarina", "S�o Paulo", "Sergipe", "Tocantins"), 
       GDP_Per_Capita = c(17.636, 16.375, 20.247, 24.542, 19.324, 17.178, 85.661, 34.493, 28.272, 13.955, 38.925, 39.931, 29.223,
                          16.107, 38.772, 18.952, 19.623, 15.432, 44.222,19.242 ,40.362 , 25.554, 23.188, 42.149, 48.542, 18.442, 22.933)), class = "data.frame", row.names = c(NA, -27L))
states <- read_country(year = 2019)
states$name_state <- tolower(states$name_state)
dados$uf <- tolower(dados$uf)

states <- dplyr::left_join(states, dados, by = c("name_state" = "uf")); states

L = min(states$GDP_Per_Capita)
S = max(states$GDP_Per_Capita)


# se colocar S no limite superior fica p�ssimo o gradiente, por isso usei 50.00
p = states %>% ggplot() + 
  geom_sf(aes(fill = GDP_Per_Capita ), size = .15) +   scale_fill_gradient(low = "red", high = "blue", name = "GDP Per Capita (R$)", limits = c(L, 50.000))+ 
  xlab("") +  ylab("") +geom_sf_label(aes(label = abbrev_state),label.padding = unit(0.5, "mm"),size = 3) 


p = p +   labs(title = "GDP per Capita by State",caption  = "Autores: Gerson J�nior e Henrique Martins.") +
  theme(plot.caption = element_text(hjust = 0, face= "italic"), 
        plot.title.position = "plot", 
        plot.caption.position =  "plot") 

p = p + theme(legend.position = "bottom") + theme(legend.title = element_text(size = 10),legend.text=element_text(size=10))
plot(p)
