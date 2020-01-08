#De output van deze code is een .csv met twee getallen, de linker is de totale score van de
#beoordeelde woorden en de rechter het aantal beoordeelde woorden. In excel moet nog een for-
#mule toegepast worden om de uiteindelijke getallen te krijgen. Het is mij niet gelukt die
#berekening in R te laten doen. De formule die ik heb gebruikt is =ALS(D2>0;C2/D2;0), zolang
#de totale score maar door het aantal beoordeelde woorden gedeeld wordt.

#Laad hier het bestand lexicon_sentiment_nl_v2.csv in, staat op de drive (Tutorials > R > Sentiment analysis)
lex_sentiment_v2 <- read.csv(file="C:/Users/.../lexicon_sentiment_nl_v2.csv", header=TRUE, sep=";", stringsAsFactors = FALSE, fileEncoding="UTF-8-BOM")

pos10_sent_nl <- subset(lex_sentiment_v2$word, lex_sentiment_v2$polarity == "1")
pos09_sent_nl <- subset(lex_sentiment_v2$word, lex_sentiment_v2$polarity == "0,9")
pos08_sent_nl <- subset(lex_sentiment_v2$word, lex_sentiment_v2$polarity == "0,8")
pos07_sent_nl <- subset(lex_sentiment_v2$word, lex_sentiment_v2$polarity == "0,7")
pos06_sent_nl <- subset(lex_sentiment_v2$word, lex_sentiment_v2$polarity == "0,6")
pos05_sent_nl <- subset(lex_sentiment_v2$word, lex_sentiment_v2$polarity == "0,5")
pos04_sent_nl <- subset(lex_sentiment_v2$word, lex_sentiment_v2$polarity == "0,4")
pos03_sent_nl <- subset(lex_sentiment_v2$word, lex_sentiment_v2$polarity == "0,3")
pos02_sent_nl <- subset(lex_sentiment_v2$word, lex_sentiment_v2$polarity == "0,2")
pos01_sent_nl <- subset(lex_sentiment_v2$word, lex_sentiment_v2$polarity == "0,1")
pos00_sent_nl <- subset(lex_sentiment_v2$word, lex_sentiment_v2$polarity == "0")
neg01_sent_nl <- subset(lex_sentiment_v2$word, lex_sentiment_v2$polarity == "-0,1")
neg02_sent_nl <- subset(lex_sentiment_v2$word, lex_sentiment_v2$polarity == "-0,2")
neg03_sent_nl <- subset(lex_sentiment_v2$word, lex_sentiment_v2$polarity == "-0,3")
neg04_sent_nl <- subset(lex_sentiment_v2$word, lex_sentiment_v2$polarity == "-0,4")
neg05_sent_nl <- subset(lex_sentiment_v2$word, lex_sentiment_v2$polarity == "-0,5")
neg06_sent_nl <- subset(lex_sentiment_v2$word, lex_sentiment_v2$polarity == "-0,6")
neg07_sent_nl <- subset(lex_sentiment_v2$word, lex_sentiment_v2$polarity == "-0,7")
neg08_sent_nl <- subset(lex_sentiment_v2$word, lex_sentiment_v2$polarity == "-0,8")
neg09_sent_nl <- subset(lex_sentiment_v2$word, lex_sentiment_v2$polarity == "-0,9")
neg10_sent_nl <- subset(lex_sentiment_v2$word, lex_sentiment_v2$polarity == "-1")

sentilex <- quanteda::dictionary(list(pos10=pos10_sent_nl,
                                      pos09=pos09_sent_nl,
                                      pos08=pos08_sent_nl,
                                      pos07=pos07_sent_nl,
                                      pos06=pos06_sent_nl,
                                      pos05=pos05_sent_nl,
                                      pos04=pos04_sent_nl,
                                      pos03=pos03_sent_nl,
                                      pos02=pos02_sent_nl,
                                      pos01=pos01_sent_nl,
                                      pos00=pos00_sent_nl,
                                      neg01=neg01_sent_nl,
                                      neg02=neg02_sent_nl,
                                      neg03=neg03_sent_nl,
                                      neg04=neg04_sent_nl,
                                      neg05=neg05_sent_nl,
                                      neg06=neg06_sent_nl,
                                      neg07=neg07_sent_nl,
                                      neg08=neg08_sent_nl,
                                      neg09=neg09_sent_nl,
                                      neg10=neg10_sent_nl
))
dfm_corpus <- quanteda::dfm(vlucht_volledig)
dfm_sent <- quanteda::dfm_lookup(dfm_corpus,sentilex)
df_sent <- convert(dfm_sent,to = "data.frame")
score <- c(
  df_sent["pos10"] +
    df_sent["pos09"] * 0.9 +
    df_sent["pos08"] * 0.8 +
    df_sent["pos07"] * 0.7 +
    df_sent["pos06"] * 0.6 +
    df_sent["pos05"] * 0.5 +
    #    df_sent["pos04"] * 0.4 +
    #    df_sent["pos03"] * 0.3 +
    #    df_sent["pos02"] * 0.2 +
    #    df_sent["pos01"] * 0.1 +
    df_sent["neg01"] * -0.1 +
    df_sent["neg02"] * -0.2 +
    df_sent["neg03"] * -0.3 +
    df_sent["neg04"] * -0.4 +
    df_sent["neg05"] * -0.5 +
    df_sent["neg06"] * -0.6 +
    df_sent["neg07"] * -0.7 +
    df_sent["neg08"] * -0.8 +
    df_sent["neg09"] * -0.9 +
    df_sent["neg10"] * -1
)
rated_words <- c(
  df_sent["pos10"] +
    df_sent["pos09"] +
    df_sent["pos08"] +
    df_sent["pos07"] +
    df_sent["pos06"] +
    df_sent["pos05"] +
    #   df_sent["pos04"] +
    #   df_sent["pos03"] +
    #   df_sent["pos02"] +
    #   df_sent["pos01"] +
    #   df_sent["pos00"] +
    df_sent["neg01"] +
    df_sent["neg02"] +
    df_sent["neg03"] +
    df_sent["neg04"] +
    df_sent["neg05"] +
    df_sent["neg06"] +
    df_sent["neg07"] +
    df_sent["neg08"] +
    df_sent["neg09"] +
    df_sent["neg10"])

df_textscores <- data.frame(df_sent["document"],score,rated_words)
write.csv2(df_textscores,file="df_textscores.csv")
