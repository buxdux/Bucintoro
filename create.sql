DROP SCHEMA IF EXISTS bucintoro CASCADE;
CREATE SCHEMA bucintoro;
SET search_path TO bucintoro;

-- --------------------------------------------------------

DROP TABLE IF EXISTS soci CASCADE;
CREATE TABLE soci (
  socio_id INTEGER PRIMARY KEY NOT NULL,
  snome varchar(30) NOT NULL,
  punteggio INTEGER,
  eta REAL NOT NULL
);

-- --------------------------------------------------------

DROP TABLE IF EXISTS barche CASCADE;
CREATE TABLE barche (
  barca_id INTEGER PRIMARY KEY NOT NULL,
  bnome varchar(30) NOT NULL,
  colore VARCHAR(10) NOT NULL
);

-- --------------------------------------------------------

DROP TABLE IF EXISTS prenotazioni CASCADE;
CREATE TABLE prenotazioni (
  sid integer,
  bid integer,
  data DATE,
  PRIMARY KEY (sid, bid, data),
  FOREIGN KEY (sid) REFERENCES soci(socio_id),
  FOREIGN KEY (bid) REFERENCES barche(barca_id)
);

