# ARGO DOCS

## Requisiti:
*   Docker
*   Docker Compose plugin

## Istruzioni:

1.  Eseguire docker con:
    docker compose up -d

2. All'interno del container, aprire una shell bash con:
    docker exec -it argo-docs-latexpdfbuilder-1 bash

3. Raggiungi i volumi dell'immagine Docker con:
    cd /data/

4. Compila i documenti con:
    ./compilescript.sh

## Script
compilescript.sh è un semplice shell script per compilare i file LaTeX mantenendo una organizzazione di directory equivalente tra input e output.
Lo script utilizza due variabili SOURCE_DIR e DESTINATION_DIR come directory di partenza per le sorgenti e gli output rispettivamente, definiti all'inizio dello script.
L'opzione -a, --all avvia lo script da SOURCE_DIR. \
L'opzione -d, --directory permette di inserire come argomento aggiuntivo la path relativa (a partire da SOURCE_DIR) della directory da cui avviare lo script.
    
Per permettere l'uso di file multipli .tex senza specificare quale di essi compone l'effettivo documento è necessario:
* Creare una directory per ciascun PDF richiesto. \
      Esempio:  "$SOURCE_DIR/1 - Candidatura/Verbali/Verbale Interno 2001-01-01/"           # Directory di input
                "$DESTINATION_DIR/1 - Candidatura/Verbali/Verbale Interno 2001-01-01.pdf"   # Directory di output

* All'interno della directory, il file che viene compilato dallo script è quello con lo stesso nome della directory in cui si trova.
      Esempio:  "$SOURCE_DIR/1 - Candidatura/Verbali/Verbale Interno 2001-01-01/Verbale Interno 2001-01-01.tex"         # Questo viene individuato dallo script
                "$SOURCE_DIR/1 - Candidatura/Verbali/Verbale Interno 2001-01-01/Verbale01012001.tex"                    # Questo NON viene individuato dallo script