library(quanteda)
lex_sentiment_nl <- read.csv(file="C:/Users/bdien/OneDrive/Documenten/Taalwetenschap/UDS/Sentimentanalyse/lexicon_sentiment_nl_v2.csv", header=TRUE, sep=";", stringsAsFactors = FALSE, fileEncoding="UTF-8-BOM")

word_pol_dict <- quanteda::dictionary(list(word=lex_sentiment_nl$word,pol=lex_sentiment_nl$polarity))
pol <- rep(0, length(aug_klimaat_texts)) #TODO: Algemenere functie voor aantal documenten vinden

opties <- unique(word_pol_dict$pol)
for(optie in opties){
  woorden <- word_pol_dict[word_pol_dict$pol==optie,"word"]
  d <- dictionary(x=woorden)
  #in dictionary d staan alle woorden met de polariteit van de waarde optie
  #voor elk artikel moeten het aantal van deze woorden opgeteld worden en 
  #polariteitswaarde pol moet als volgt aangepast worden:
  #pol <- pol + optie * hoeveelheid_woorden
}
