lex_sentiment_nl <- read.csv(file="C:/.../lexicon_sentiment_nl_v2.csv",             #Dit bestand staat op de drive onder
                             header=TRUE, sep=";",                                  #Tutorials > R > Sentiment analysis
                             stringsAsFactors = FALSE,
                             fileEncoding="UTF-8-BOM")
                             
pos_sent_nl <- subset(lex_sentiment_nl$word, lex_sentiment_nl$polarity > 0)         #alles met een positieve polariteit is positief
neg_sent_nl <- subset(lex_sentiment_nl$word, lex_sentiment_nl$polarity < 0)         #en negatief negatief
subj_nl <- subset(lex_sentiment_nl$word, lex_sentiment_nl$subjectivity > 0)         #en toevoeging van subjectiviteit

sentilex <- quanteda::dictionary(list(positive=pos_sent_nl,negative=neg_sent_nl))   #maakt een dictionary met daarin de twee lijsten
dfm_aug_kli <- quanteda::dfm(aug_klimaat)                                           #maakt een dfm van aug_klimaat
posneg <- quanteda::dfm_lookup(dfm_aug_kli,sentilex)                                #maakt een nader te onderzoeken dfm: in deze dfm staat voor elke text hoeveel positive, negatieve, en subjectieve (pas op, deze kunnen daarnaast óók pos/neg zijn) woorden.
posnegtbl <- tibble::as_tibble(posneg) #het maken van een tibble voor verdere behandeling
posnegtbl$document <- NULL #zo verwijder je de kolom 'document', zodat die in de volgende stap in een keer behandeld kan worden

docvars(aug_klimaat, c("Positieve woorden","Negatieve woorden","Subjectieve woorden")) <- posnegtbl #zo worden rechts in de docvars de resultaten van boven bijgeschreven. voor de <- kunnen nog extra kolommen bijgeschreven worden, zolang die ook in posneg staan.

write.csv2(aug_klimaat$documents, file = "sept_EUposnegsubj.csv") #opslaan
