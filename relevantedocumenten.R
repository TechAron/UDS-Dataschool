library(quanteda)     #Voor tokensiatie, corpora, etc.
library(topicmodels)  #Voor de topicmodels

september_corpus <- corpus(september)   #Corpus van de data van september (was miss al)
tok <- tokens(september_corpus,         #tokeniseert door:
              remove_numbers = TRUE,        #nummers te verwijderen
              remove_url = TRUE,            #urls te verwijderen
              remove_symbols = TRUE,        #symbolen(?) te verwijderen
              remove_punct = TRUE) %>%      #leestekens te verwijderen
  tokens_tolower() %>%                      #alle letters kleine letters te maken
  tokens_remove(stopwords::stopwords(language = "nl")) #en stopwoorden te verwijderen

#Woordenlijst thema migratie
migr_tok <- tokens_select(tok,c("vluchte*","rohingya","asiel*","migr*","opvang","azc","integratie","grens"), selection = "keep", padding = FALSE)
newthing <- ntoken(migr_tok) #telt het aantal voorkomens van één van de woorden op de woordenlijst per artikel
vluchtelingen_bool <- newthing > 0L #als er meer dan 0 relevante woorden in voorkomen, is het een relevant artikel
                                    #in vluchtelingen_bool komt voor elk artikel te staan of dit het geval is

sept_C <- september_corpus #slaat het corpus opnieuw voor het geval we het corpus per ongeluk slopen

docvars(sept_C, "vluchtelingen") <- vluchtelingen_bool #maakt een nieuwe kolom waarin staat of het artikel relevant
                                                       #is voor het onderwerp 'vluchtelingen'

vlucht_sept <- corpus_subset(sept_C, vluchtelingen == TRUE) #maakt een nieuw corpus 'vlucht_sept' met alle relevante artikelen
