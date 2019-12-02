#Commentaar op de code volgt nog
library(quanteda)

taug_klimaat <- corpus_subset(klimaat_volledig, Date < as.Date("2018-9-1"))
aug_klimaat <- corpus_subset(taug_klimaat, Date >= as.Date("2018-8-1"))
save(aug_klimaat, file = "C:/.../aug_klimaat.rdata")

summary(aug_klimaat$documents$Date)

#texts(corpus_sample(mei_vlucht, size = 10))
