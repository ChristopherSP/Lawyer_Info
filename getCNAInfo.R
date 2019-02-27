library("RSelenium")
library(stringi)

remDr = RSelenium::rsDriver(browser = "firefox")

client = remDr$client

baseURL = "http://cna.oab.org.br/"

client$navigate(baseURL)

lawyerName = client$findElement(using = 'id', value = "txtName")

idx = 1
lista = list()
lawyer = "LICINIO VIEIRA DE ALMEIDA JUNIOR"

lawyerName$clearElement()
lawyerName$sendKeysToElement(list(lawyer))

oabTable = client$findElement(using = 'id', value = "divResult")
tableContent = oabTable$getElementText()[[1]]
content = strsplit(tableContent,"\n")[[1]]

type = content[seq(4,length(content),by=8)]
number = content[seq(6,length(content),by=8)]
uf = content[seq(8,length(content),by=8)]


lista[[idx]] = data.table(advogado = lawyer, oab = number, tipo = type, uf = uf)
idx = idx+1


write.table(rbindlist(lista),"~/Downloads/ofensorsCNA.txt",sep="\t",row.names = F,quote = T)
