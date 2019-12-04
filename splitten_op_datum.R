library(quanteda)

taug_klimaat <- corpus_subset(klimaat_volledig, Date < as.Date("2018-9-1")) #maakt een subset van het hele corpus t/m maand x
aug_klimaat <- corpus_subset(taug_klimaat, Date >= as.Date("2018-8-1")) #haalt uit de subset alle artikelen tot maand x weg, maand x blijft over
save(aug_klimaat, file = "C:/.../aug_klimaat.rdata") #slaat de maand op, op de puntjes komt uiteraard het filepath te staam

summary(aug_klimaat$documents$Date) #checkt of de data kloppen, puur voor controle

#texts(corpus_sample(mei_vlucht, size = 10)) #extra controle, haalt tien artikelen uit de subset (uit de code van Amber gehaald)
