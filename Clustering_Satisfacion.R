
#subir datos (opcion 1)
install.packages("RODBC")
library("RODBC")
odbcChannel<-odbcConnect("explotacion_sql")
encuestas_espeech<-sqlFetch(odbcChannel,"encuestas_speech_r")

#subir datos (opcion 2)

canal_bd <- odbcDriverConnect('driver={SQL Server};server=BTINTERACTION;
database=TELESOFT_BT;trusted_connection=true')

resultado <- sqlQuery(canal_bd, 'SELECT * FROM tipo_reclamo') 
resultado
odbcClose(canal_bd)

#Subir datos Transformación data
sat_speech<-sqlQuery(canal_bd, 'SELECT v1, porcent_silen, cat_insatisfacción,
                     resolutividad, nps, 
                     FROM tipo_reclamo') 

#Analizar

str(encuestas_espeech)
summary(encuestas_espeech$satisfaccion_neta)
plot(encuestas_espeech$satisfaccion_neta)

sqlQuery(canal_bd, 'select top 10 * from encuestas_speech_r') 

#Guardar

sqlSave(odbcChannel,tiporeclamo_sql, addPK=TRUE)

#Querys otros
