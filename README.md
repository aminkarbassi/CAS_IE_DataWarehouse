# Datawarehouse implementation

### Aufgabenstellung
In dieser Aufgabe geht es darum, ein kleines datawarehouse (eigentlich einen kleinen data mart)
aufzubauen. Dabei müssen sowohl ETL-Probleme gelöst als auch Modellierungsaufgaben und
konkrete Auswertungen umgesetzt werden.

### Tools
Zur Umsetzung müssen folgende Tools verwendet werden:
• Back-End: Pentaho Data Integration (ETL), MySQL (staging-area, DWH) 

### Ausgangslage
Das Unternehmen „Northwind“ betreibt ein ERP-System (OLTP). Diesem liegt eine relationale
Datenbank zugrunde. Aus verschiedenen Gründen ist es jedoch nicht gestattet, für analytische
Zwecke direkt auf dieser Datenbank Abfragen zu tätigen. Es soll daher ein eigenständiges DWH
aufgebaut werden. Die Daten stammen zwar aus dieser ERP-Datenbank, müssen aber von dort
zuerst in eine staging-area exportiert werden, die dann via ETL-Prozesse in die DB des DWH
gelangen.

### Ausgangsdaten
• Northwind-Database.sql
• Northwind-Daten.sql
• Northwind-ERM.pdf
Skript, um die ERP-Datenbank zu erzeugen
Skript, um die ERP-Datenbank zu füllen
ER-Diagramm der ERP-Datenbank

### Aufgaben
Aufsetzen der ERP-Datenbank (d.h. obige Skripte laufen lassen). Studium des Schemas und
vertraut werden mit den Datenbankinhalten.
1. Überlegen, welche Auswertungen mit dem DWH ermöglicht werden sollen und festlegen,
welche Daten dazu benötigt werden.
2. Erstellen eines zu den geplanten Abfragen passenden „multidimensionalen“
Datenbankschemas.
3. Implementieren dieses Schemas in einer neuen DWH-Datenbank (mittels SQL-Skript).
4. Implementieren von „staging Tabellen“ in der DWH-DB (mittels SQL-Skript).
5. Implementieren eines ETL-Prozesses mit PDI.
◦ E-Schritt: Kopieren der erforderlichen Daten aus der ERP-Datenbank in die
stagingTabellen. Dabei können Attribute, die später nicht benötigt werden, natürlich
bereits weggelassen werden.
◦ T- und L-Schritt: Beheben der folgenden Datenqualitätsprobleme.
i. Aufgrund eines technischen Problems wurden alle Discounts in der Tabelle
order_details negativ erfasst. Diese Werte sollen im ETL-Prozess in positive Werte
umgewandelt werden.
ii. In der Tabelle products wurden einige Produkte irrtümlicherweise doppelt erfasst.
Finden Sie heraus, inwiefern sich die Einträge der identischen Produkte
unterscheiden. Eliminieren Sie dann alle Duplikate, so dass es pro Produkt genau
einen Eintrag in der Zieltabelle gibt (und zwar den, mit der jeweils kleineren id).
iii. Füllen der DWH-DB mit entsprechenden Daten aus den staging-Tabellen
