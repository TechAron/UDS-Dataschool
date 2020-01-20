#Stap voor stap uitgelegd hoe de grafiek met sentiment en frequentie in ggplot gemaakt is, in dit geval van vluchtelingen

library(ggplot2)   #basispakket
library(ggimage)   #afbeeldingen als nodes
library(ggpmisc)   #weet oprecht niet meer wat deze deed
library(ggthemes)  #verschillende themas van hoe de grafiek eruit komt te zien
library(extrafont) #laat je het lettertype aanpassen

#laad hier een bestand met gegevens in:
sent_freq <- read.csv(file="C:/Users/.../sent_freq_vlucht.csv",dec=",", header=TRUE, sep=";", stringsAsFactors = FALSE, fileEncoding="UTF-8-BOM")

#begin met ggplot([NAAM BESTAND], aes(x-waarde, y-waarde), eventueel een kleur ofzo)
ggplot(sent_freq, aes(sent_freq$frequentie, sent_freq$sentiment), color = "red") + #als je meer wil toevoegen doe je dat met een '+' aan het einde van een regel
  geom_image(aes(image=sent_freq$krant), size=.1) + #laadt de afbeeldingen in, in de kolom krant staan linkjes naar de afbeeldingen
  theme_classic() + #bepaald thema, verhoudt zich tot de achtergrond, opmaak van de lijnen, punten, etc.
  theme(plot.title = element_text(hjust = 0.5)) + #zet de titel in het midden
  xlab("Aandeel tekst") + #label van de x-as
  ylab("Gemiddelde sentimentscore") + #label van de y-as
  ylim(-0.12,0) + #handmatige limiet van de y-as
  scale_x_discrete(position = "top") + #plaatst de x-as bovenaan de grafiek
  theme(text=element_text(size=11,  family="Georgia")) + #lettertype georgia
  ggtitle("Framing per krant binnen het thema ‘Vluchtelingen’") #titel van de grafiek
