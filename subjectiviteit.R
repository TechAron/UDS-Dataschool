lex_sentiment_v2 <- read.csv(file="C:/Users/bdien/OneDrive/Documenten/Taalwetenschap/UDS/Sentimentanalyse/lexicon_sentiment_nl_v2.csv", header=TRUE, sep=";", stringsAsFactors = FALSE, fileEncoding="UTF-8-BOM")
lex_sentiment_bg <- read.csv(file="C:/Users/bdien/OneDrive/Documenten/Taalwetenschap/UDS/Sentimentanalyse/lexicon_sentiment_nl_bigram.csv", header=TRUE, sep=";", stringsAsFactors = FALSE, fileEncoding="UTF-8-BOM")

lex_sentiment_nl <- c(lex_sentiment_v2, lex_sentiment_bg)

sub01_sent_nl <- subset(lex_sentiment_nl$word, lex_sentiment_nl$subjectivity == "1")
sub02_sent_nl <- subset(lex_sentiment_nl$word, lex_sentiment_nl$subjectivity == "0,9")
sub03_sent_nl <- subset(lex_sentiment_nl$word, lex_sentiment_nl$subjectivity == "0,8")
sub04_sent_nl <- subset(lex_sentiment_nl$word, lex_sentiment_nl$subjectivity == "0,7")
sub05_sent_nl <- subset(lex_sentiment_nl$word, lex_sentiment_nl$subjectivity == "0,6")
sub06_sent_nl <- subset(lex_sentiment_nl$word, lex_sentiment_nl$subjectivity == "0,5")
sub07_sent_nl <- subset(lex_sentiment_nl$word, lex_sentiment_nl$subjectivity == "0,4")
sub08_sent_nl <- subset(lex_sentiment_nl$word, lex_sentiment_nl$subjectivity == "0,3")
sub09_sent_nl <- subset(lex_sentiment_nl$word, lex_sentiment_nl$subjectivity == "0,2")
sub10_sent_nl <- subset(lex_sentiment_nl$word, lex_sentiment_nl$subjectivity == "0,1")
sub11_sent_nl <- subset(lex_sentiment_nl$word, lex_sentiment_nl$subjectivity == "0")
sub12_sent_nl <- subset(lex_sentiment_nl$word, lex_sentiment_nl$subjectivity == "-0,1")
sub13_sent_nl <- subset(lex_sentiment_nl$word, lex_sentiment_nl$subjectivity == "-0,3")
sub14_sent_nl <- subset(lex_sentiment_nl$word, lex_sentiment_nl$subjectivity == "-0,6")

sentilex <- quanteda::dictionary(list(sub01=sub01_sent_nl,
                                      sub02=sub02_sent_nl,
                                      sub03=sub03_sent_nl,
                                      sub04=sub04_sent_nl,
                                      sub05=sub05_sent_nl,
                                      sub06=sub06_sent_nl,
                                      sub07=sub07_sent_nl,
                                      sub08=sub08_sent_nl,
                                      sub09=sub09_sent_nl,
                                      sub10=sub10_sent_nl,
                                      sub11=sub11_sent_nl,
                                      sub12=sub12_sent_nl,
                                      sub13=sub13_sent_nl,
                                      sub14=sub14_sent_nl
))

dfm_corpus <- quanteda::dfm(vlucht_nieuw)
dfm_sent <- quanteda::dfm_lookup(dfm_corpus,sentilex)
df_sent <- convert(dfm_sent,to = "data.frame")
score <- c(
  df_sent["sub01"] +
    df_sent["sub02"] * 0.9 +
    df_sent["sub03"] * 0.8 +
    df_sent["sub04"] * 0.7 +
    df_sent["sub05"] * 0.6 +
    df_sent["sub06"] * 0.5 +
    df_sent["sub07"] * 0.4 +
    df_sent["sub08"] * 0.3 +
    df_sent["sub09"] * 0.2 +
    df_sent["sub10"] * 0.1 +
    df_sent["sub12"] * -0.1 +
    df_sent["sub13"] * -0.3 +
    df_sent["sub14"] * -0.6
)
rated_words <- c(
  df_sent["sub01"] +
    df_sent["sub02"] +
    df_sent["sub03"] +
    df_sent["sub04"] +
    df_sent["sub05"] +
    df_sent["sub06"] +
    df_sent["sub07"] +
    df_sent["sub08"] +
    df_sent["sub09"] +
    df_sent["sub10"] +
#   df_sent["sub11"] +
    df_sent["sub12"] +
    df_sent["sub13"] +
    df_sent["sub14"])

#Ik wil nog ervoor zorgen dat de score door het aantal bekeken woorden gedeeld wordt. Artikelen
#waarin geen woorden bekeken zijn moeten dan automatisch een score 0 krijgen, plus dat artikelen
#waarin heel weinig woorden (ben uit gegaan van minder dan tien) een disproportioneel hoge score
#krijgen, dus zou ik die er ook uit willen halen. Dit is mijn mislukte poging:
#if(rated_words > 9){
#  score <- score / rated_words
#}
#else{
#  if(rated_words == 0){
#    score <- 0    
#  }
#  else{
#    score <- NULL
#  }
#} 
#dit heb ik (Aron) gedaan met dezelfde formule als die bij de sentimentsanalyse. Op deze manier kunnen we hopelijk ook een gewogen cijfer krijgen (dat is volgens mij ook het geval). 

df_textscores <- data.frame(df_sent["document"],score,rated_words)
write.csv2(df_textscores,file="df_subscores_new.csv")
