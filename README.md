# Bucintoro

###### Indirizzo database: heroku pg:psql --app heroku-postgres-d34a3d1f HEROKU_POSTGRESQL_PUCE

* Q1 Trova tutti i colori delle barche riservate da Albert
   ```sh
	SELECT b.colore 
	FROM soci AS s, barche AS b, prenotazioni AS p 
	WHERE (p.sid = s.socio_id AND p.bid = b.barca_id) AND s.snome = 'Dustin'; 
	```
    
* Q2. Trova tutti gli identificatori dei soci che hanno un punteggio maggiore 
      di 8 oppure hanno prenotato la barca 103.
	```sh
	SELECT DISTINCT s.socio_id AS INDENTIFICATORI,  s.punteggio  
	FROM soci AS s, prenotazioni AS p, barche as b
	WHERE s.punteggio > 8 OR (p.bid = 103 AND s.socio_id = p.sid AND b.barca_id = p.bid);
	```
    
* Q3. Trova i nomi dei soci che non hanno prenotato una barca e il cui nome 
      contiene la stringa 'storm'. Ordina il risultato in senso crescente.
	```sh
	SELECT s.snome
	FROM soci AS s
	WHERE s.snome LIKE '%storm%' AND s.socio_id NOT IN
    	(SELECT sid 
    	FROM prenotazioni)
    ORDER BY s.snome;
	```
* Q4. Trova gli id dei soci di età superiore a 20 che non hanno prenotato 
      barche il cui nome contenga la stringa 'thunder'.
    ```sh
	SELECT socio_id
	FROM soci AS s
	WHERE eta > 20 AND socio_id NOT IN
        (SELECT sid 
    	FROM prenotazioni, barche
    	WHERE sid = barca_id AND bnome LIKE '%thunder%')
    ORDER BY s.snome;
	```
* Q5. Trova i nomi dei soci che hanno prenotato almeno due barche.
     ```sh
	SELECT s.snome, s.socio_id, COUNT(DISTINCT p.bid)
    FROM soci AS s, prenotazioni AS p
    WHERE s.socio_id = p.sid 
    GROUP BY s.socio_id
    HAVING COUNT(*) >= 2;
	```    

* Q6. Trova i nomi dei soci che hanno prenotato tutte le barche.
    ```sh
    SELECT s.snome
    FROM soci AS s
    WHERE NOT EXISTS (
        (SELECT b.barca_id
        FROM barche AS b) 
        
        EXCEPT ALL
        
        (SELECT DISTINCT p.bid
        FROM prenotazioni AS p
        WHERE p.sid = s.socio_id) );
    ```
 
* Q7. Trova i nomi dei soci che hanno prenotato tutte le barche che si chiamano iniziando con ','.
     ```sh
    SELECT s.socio_id, s.snome
    FROM soci AS s
    WHERE NOT EXISTS (
        (SELECT b.barca_id
        FROM barche AS b
        WHERE b.bnome LIKE 'Inter%')
        
        EXCEPT ALL
        
        (SELECT DISTINCT p.bid
        FROM prenotazioni AS p, barche AS b1
        WHERE p.sid = s.socio_id
        AND b1.bnome LIKE 'Inter%' AND p.bid = b1.barca_id ) );
     ```
* Q8. Trova gli id dei soci che hanno un punteggio più alto del socio di nome Bob.
    ```sh
    SELECT s.socio_id, s.snome, s.punteggio
    FROM soci AS s
    WHERE s.punteggio > 
    
        (SELECT s1.punteggio
        FROM soci AS s1
        WHERE s1.socio_id = 95);
    ```

* Q11. Trova il nome e l'età del socio più vecchio.
    ```sh
   SELECT s1.snome, s1.eta
   FROM soci AS s1
   WHERE s1.eta = 
        (SELECT MAX(s.eta)
        FROM soci AS s)
    
    ```

* Q12. Trova i nomi dei soci che hanno prenotato tutte le barche prenotate da quelli con punteggio minore.
    ```sh
    
    ```
    
* Q13. Trovare per ogni punteggio l'età media dei soci con quel livello di punteggio.

    ```sh
    SELECT s.punteggio, AVG(s.eta)
    FROM soci AS s
    GROUP BY s.punteggio;
    ```

* Q14. Per ogni barca prenotata da almeno 2 distinti soci, trovare l'id della barca e l'età media del socio che l'ha prenotata.
    
    ```sh
    SELECT p.bid, COUNT(Distinct p.sid), AVG(s.eta)
    FROM 
        (SELECT p1.sid, p1.bid    -- per non avere dublicati delle prenotazioni
        FROM prenotazioni AS p1 
        GROUP by p1.sid, p1.bid) AS p, soci AS s
    WHERE p.sid = s.socio_id
    GROUP BY p.bid
    ```
    
### Comandi Bash

    1  heroku pg:psql --app heroku-postgres-aeeb42bd HEROKU_POSTGRESQL_CRIMSON < create.sql 
    2  heroku pg:psql --app heroku-postgres-aeeb42bd HEROKU_POSTGRESQL_CRIMSON < insert.sql 
    3  heroku pg:psql --app heroku-postgres-aeeb42bd HEROKU_POSTGRESQL_CRIMSON
    4  git status
    5  git add create.sql insert.sql 
    6  git commit -m "Testo esercizio."   
    7  git push -u origin master
    8  git add README.md 
    9  git commit -m "add readme1.0" 
    10 git push
    12 git add README.md
    13 git commit -m "add readme1.1"
    14 git push
    15 git add insert.sql
    16 git commit -m "add new insert"
    17 git push 
    18 git add README.md
    19 git commit -m "add readme1.2"
    20 git push
    21 git add README.md
    22 git commit -m "add readme 1.3"
    23 git push

### Commandi SQL
    
    1 SET search_path TO bucintoro;