library(quanteda)     #Voor tokensiatie, corpora, etc.
library(topicmodels)  #Voor de topicmodels

#maken van de subset (deze versie is van september)
NewscorpusEU <- corpus(newspapers5)   #Corpus van de data van september (was miss al)
tok <- tokens(Newscorpus,         #tokeniseert door:
              remove_numbers = TRUE,        #nummers te verwijderen
              remove_url = TRUE,            #urls te verwijderen
              remove_symbols = TRUE,        #symbolen(?) te verwijderen
              remove_punct = TRUE) %>%      #leestekens te verwijderen
  tokens_tolower() %>%                      #alle letters kleine letters te maken
  tokens_remove(stopwords::stopwords(language = "nl"))  #en stopwoorden te verwijderen
#Woordenlijst thema migratie
EU_tok <- tokens_select(tok,c("euroscepticus", "juncker", "brexit", "nexit", "^e(u|urope(es|se))$", "boris_johnson", "^may$"), selection = "keep", padding = FALSE) #hij is een beetje aangepast. HIerdoor werd de LDA relevanter, met vaker dingen over advocaten, rechters, stoornissen et cetera. Psychiaters en ontsnappingen zijn eruit. 
newthingEU <- ntoken(EU_tok) #telt het aantal voorkomens van Ã©Ã©n van de woorden op de woordenlijst per artikel
EU_bool <- newthingEU > 0L #als er meer dan 0 relevante woorden in voorkomen, is het een relevant artikel
#in vluchtelingen_bool komt voor elk artikel te staan of dit het geval is

docvars(NewscorpusEU, "EU") <- EU_bool #maakt een nieuwe kolom waarin staat of het artikel relevant
#is voor het onderwerp 'tbsd'

subset_EU <- corpus_subset(NewscorpusEU, EU == TRUE) #maakt een nieuw corpus 'tbs' met alle relevante artikelen

save(subset_EU, file = "SubsetEU.RDATA") 

texts(corpus_sample(subset_EU, size = 10))
