========================================Przydatne komendy===================================
Operacje CRUDOWE 
CRUD - create read update delete

INSERT INTO klienci VALUES (900000001, 'Konrad', 'Testowa', 'Kraków', '31-000', '000 000 000');
INSERT INTO tabela VALUES (dane jakie wstawiamy do tabeli, musza byc w kolejnosci w  jakiej wystepuja kolumny)

Dodanie kilka rekordów na raz:
INSERT INTO klienci VALUES
(900000004, 'Konrad', 'Testowa', 'Kraków', '31-000', '000 000 000'),
(900000005, 'Konrad', 'Testowa', 'Kraków', '31-000', '000 000 000'),
(900000006, 'Konrad', 'Testowa', 'Kraków', '31-000', '000 000 000');

Podaje które konkretne kolumny bede dodawać, reszte wypełni nullami w takiej sytuacji nie trzeba podawac ich w kolejnosci
INSERT INTO klienci (idklienta, nazwa, ulica, miejscowosc, kod, telefon) VALUES (900000002, 'Konrad', 'Testowa', 'Kraków', '31-000', '000 000 000');

idczekoladki: W98,
nazwa: Biały kieł,
czekolada: biała,
orzechy: laskowe,
nadzienie: marcepan,
opis: Rozpływające się w rękach i kieszeniach,
koszt: 45 gr,
masa: 20 g.

insert into czekoladki (idczekoladki, nazwa, czekolada, orzechy, nadzienie, opis, koszt, masa) values ('W98', 'Biały kieł', 'biała', 'laskowe', 'marcepan', 'Rozpływające się w rękach i kieszeniach', 45, 20);
INSERT INTO klienci (
    idklienta,
    nazwa,
    ulica,
    miejscowosc,
    kod,
    telefon
) VALUES (
    900000003,
    'Konrad',
    'Testowa',
    (SELECT miejscowosc FROM klienci WHERE idklienta = 80),
    '31-000',
    '000 000 000'
);

Tutaj wyżej mamy przypadek że dodajemy klienta który ma podzapytanie w sobie osnzaczajace zeby za miejscowosc podstawiło miejscowosc której idklieneta jest równe 80 czyli powinno tam podstawić Płock 
!Podzapytanie ma być w nawiasie!

INSERT INTO klienci2 SELECT * FROM klienci; - przeniesienie wszystkich rekordów do klienci2 (skopiowanie)

USUWANIE DANYCH

DELETE FROM klienci WHERE idklienta IN (900000001, 900000002, 900000004, 900000005, 900000006)

DELETE FROM klienci - skasuje wszystko z tabeli klienci


AKTUALIZACJA DANYCH

UPDATE klienci SET miejscowosc = 'Kraków' WHERE idklienta = 900000003

UPDATE zamowienia z SET dane_klienta = k.nazwa FROM klienci k WHERE z.idklienta = k.idklienta

(UWAGA: to zapytanie zadziala jezeli w tabeli zamowienia utworzono dodatkowa kolumne dane_klienta)

6.1

1.

insert into czekoladki (idczekoladki, nazwa, czekolada, orzechy, nadzienie, opis, koszt, masa) values ('W98', 'Biały kieł', 'biała', 'laskowe', 'marcepan', 'Rozpływające się w rękach i kieszeniach', 45, 20);
select * from czekoladki where idczekoladki like 'W98';

2.

select * from klienci;
INSERT INTO Klienci (idklienta, nazwa, ulica, miejscowosc, kod, telefon)
VALUES 
    (90, 'Matusiak Edward', 'Kropiwnickiego 6/3', 'Leningrad', '31-471', '031 423 45 38'),
    (91, 'Matusiak Alina', 'Kropiwnickiego 6/3', 'Leningrad', '31-471', '031 423 45 38'),
    (92, 'Kimono Franek', 'Karateków 8', 'Mistrz', '30-029', '501 498 324');
	
SELECT * FROM Klienci
WHERE idklienta IN (90, 91, 92);


3.

INSERT INTO klienci (idklienta, nazwa, ulica, miejscowosc, kod, telefon)
SELECT
    93,
    'Iza Matusiak',
    ulica,
    miejscowosc,
    kod,
    telefon
FROM
    klienci
WHERE
    idklienta = 90;

6.2

1.

INSERT INTO czekoladki VALUES
('X91', 'Nieznana Nieznajoma', NULL, 'Niewidzialna czekoladka wspomagająca odchudzanie.', 0.26, 0),
('M98', 'Mleczny Raj', 'Mleczna', 'Aksamitna mleczna czekolada w kształcie butelki z mlekiem.', 0.26, 36);


INSERT INTO czekoladki (IDCzekoladki, Nazwa, Czekolada, Opis, Koszt, Masa)
VALUES 
    ('X91', 'Nieznana Nieznajoma', NULL, 'Niewidzialna czekoladka wspomagająca odchudzanie.', 0.26, 0),
    ('M98', 'Mleczny Raj', 'Mleczna', 'Aksamitna mleczna czekolada w kształcie butelki z mlekiem.', 0.26, 36);

SELECT * FROM czekoladki
WHERE idczekoladki IN ('X91', 'M98');


6.3
1.

DELETE FROM czekoladki
WHERE idczekoladki IN ('X91', 'M98');


2.

SELECT * FROM czekoladki
WHERE idczekoladki IN ('X91', 'M98');

3.

INSERT INTO czekoladki (IDCzekoladki, Nazwa, Czekolada, Opis, Koszt, Masa)
VALUES 
    ('X91', 'Nieznana Nieznajoma', NULL, 'Niewidzialna czekoladka wspomagająca odchudzanie.', 0.26, 0),
    ('M98', 'Mleczny Raj', 'Mleczna', 'Aksamitna mleczna czekolada w kształcie butelki z mlekiem.', 0.26, 36);
SELECT * FROM czekoladki
WHERE idczekoladki IN ('X91', 'M98');

6.4
1.

select * from klienci WHERE idklienta = 93;

UPDATE Klienci
SET nazwa = 'Iza Nowak'
WHERE nazwa = 'Iza martyniuk';

2.

UPDATE czekoladki
SET koszt = koszt * 0.9
WHERE idczekoladki IN ('W98', 'M98', 'X91');

-- Sprawdzenie zmian
SELECT * FROM czekoladki
WHERE idczekoladki IN ('W98', 'M98', 'X91');

3.

-- Aktualizacja danych
UPDATE czekoladki
SET koszt = (SELECT koszt FROM czekoladki WHERE idczekoladki = 'W98')
WHERE Nazwa = 'Nieznana Nieznajoma';

-- Sprawdzenie zmian
SELECT * FROM czekoladki
WHERE Nazwa = 'Nieznana Nieznajoma' or idczekoladki = 'W98';

##########
#
# 6.4.3 - wersja z podzapytaniem
#
##########

UPDATE czekoladki SET koszt = (SELECT koszt FROM czekoladki WHERE idczekoladki = 'W98') WHERE nazwa = 'Nieznana Nieznajoma';

##########
#
# 6.4.3 - wersja ze zlaczeniem
#
##########

UPDATE czekoladki cz1 SET koszt = cz2.koszt
FROM czekoladki cz2
WHERE cz1.nazwa = 'Nieznana Nieznajoma' AND cz2.idczekoladki = 'W98';



##########
#
# 6.4.5
#
##########

UPDATE czekoladki cz SET koszt = cz.koszt + 0.15 WHERE substr(cz.idczekoladki, 2, 2)::int > 90

SELECT * FROM czekoladki cz WHERE substr(cz.idczekoladki, 2, 2)::int > 90



6.5
1.
-- Usunięcie klientów o nazwisku "Matusiak"
DELETE FROM Klienci
WHERE nazwa LIKE '%Matusiak';

2.

-- Usunięcie klientów o identyfikatorze większym niż 91
DELETE FROM Klienci
WHERE idklienta > 91;


3.

-- Usunięcie czekoladek spełniających warunki
DELETE FROM czekoladki
WHERE koszt >= 0.45 OR masa >= 36 OR masa = 0;

6.6


INSERT INTO Pudelka (idpudelka, nazwa, opis, cena, stan)
VALUES
    ('P1', 'Pudełko 1', 'Opis pudełka 1', 20.00, 10),
    ('P2', 'Pudełko 2', 'Opis pudełka 2', 15.00, 8);
-- Wstawienie czekoladek do pudełek
-- Pudełko 1
INSERT INTO Zawartosc (idpudelka, idczekoladki, sztuk)
SELECT 'P1', idczekoladki, 5
FROM Czekoladki
WHERE idczekoladki IN ('b01', 'b02', 'b03', 'b04', 'b05');

-- Pudełko 2
INSERT INTO Zawartosc (idpudelka, idczekoladki, sztuk)
SELECT 'P2', idczekoladki, 5
FROM Czekoladki
WHERE idczekoladki IN ('d01', 'd02', 'd03', 'd04', 'd06');

select * from pudelka 
where idpudelka  in ('P1', 'P2');

6.7	======================Przerobic na zajeciach============================


★ Polecenie COPY pozwala m.in. kopiowanie danych między bazą danych i standardowym systemem plików. Polecenie COPY FROM kopiuje dane z pliku do wskazanej tabeli. Domyślnie wartości atrybutów są oddzielane tabulatorem, zaś NULL jest oznaczany symbolem \N. Polecenie COPY TO kopiuje dane z bazy danych (cała tabela, wybrane kolumny lub wynik instrukcji SELECT) do pliku. Opcje polecenia pozwalają zdefiniować m.in. separator, oznaczenia wartości null, oznaczenie napisu pustego itp. http://www.postgresql.org/docs/9.1/static/sql-copy.html

★ Napisz skrypt zawierający instrukcje COPY wstawiające do bazy danych cukiernia dwa nowe rekordy do tabeli pudelka oraz odpowiednie rekordy związane z tymi pudełkami do tabeli zawartosc. Każde z nowych pudełek ma zawierać łącznie co najmniej 10 czekoladek, w co najmniej 4 różnych smakach.


Przygotuj plik CSV o nazwie "dane_pudelka.csv" zawierający dane dla tabel "Pudelka" i "Zawartosc". Przykładowa zawartość pliku może wyglądać następująco:
"P1","Pudełko 1","Opis pudełka 1",20.00,10
"P2","Pudełko 2","Opis pudełka 2",15.00,8

Przygotuj plik CSV o nazwie "dane_zawartosc.csv" zawierający dane dla tabeli "Zawartosc." Przykładowa zawartość pliku może wyglądać tak:
1,"P1","b01",5
2,"P1","b02",5
3,"P1","b03",5
4,"P1","b04",5
5,"P1","b05",5
6,"P2","d01",5
7,"P2","d02",5
8,"P2","d03",5
9,"P2","d04",5
10,"P2","d06",5

Następnie możesz użyć polecenia COPY, aby wczytać te dane do bazy danych. Oto przykład:

-- Wstawienie danych do tabeli "Pudelka" z pliku CSV
COPY Pudelka FROM 'ścieżka/do/pliku/dane_pudelka.csv' WITH CSV HEADER;

-- Wstawienie danych do tabeli "Zawartosc" z pliku CSV
COPY Zawartosc FROM 'ścieżka/do/pliku/dane_zawartosc.csv' WITH CSV;

6.8 ======================Przerobic na zajeciach =====================
Oto skrypty SQL, które realizują opisane operacje:

Zwiększenie o 1 liczbę czekoladek każdego smaku w pudełkach dodanych wcześniej:
-- Zwiększenie o 1 liczbę czekoladek każdego smaku w pudełkach
UPDATE Zawartosc
SET sztuk = sztuk + 1
WHERE idpudelka IN ('P3', 'P4');

Aktualizacja tabeli "czekoladki", zastępując wartości NULL w kolumnach "czekolada," "orzechy" i "nadzienie" wartością "brak":

-- Aktualizacja kolumny "czekolada" w tabeli "czekoladki"
UPDATE czekoladki
SET czekolada = 'brak'
WHERE czekolada IS NULL;

-- Aktualizacja kolumny "orzechy" w tabeli "czekoladki"
UPDATE czekoladki
SET orzechy = 'brak'
WHERE orzechy IS NULL;

-- Aktualizacja kolumny "nadzienie" w tabeli "czekoladki"
UPDATE czekoladki
SET nadzienie = 'brak'
WHERE nadzienie IS NULL;
	
Anulowanie zmian wprowadzonych w poprzednim punkcie, przywracając wartości NULL:

-- Przywrócenie wartości NULL w kolumnie "czekolada" w tabeli "czekoladki"
UPDATE czekoladki
SET czekolada = NULL
WHERE czekolada = 'brak';

-- Przywrócenie wartości NULL w kolumnie "orzechy" w tabeli "czekoladki"
UPDATE czekoladki
SET orzechy = NULL
WHERE orzechy = 'brak';

-- Przywrócenie wartości NULL w kolumnie "nadzienie" w tabeli "czekoladki"
UPDATE czekoladki
SET nadzienie = NULL
WHERE nadzienie = 'brak';





------------------------codeshare-----------------
zadanie 6.1
INSERT INTO klienci(idklienta, nazwa, ulica, miejscowosc, kod, telefon) 
VALUES
(90, 'Matusiak Edward', 'Kropiwnickiego 6/3', 'Leningrad', '31-471', '031 423 45 38'), 
(91, 'Matusiak Alina', 'Kropiwnickiego 6/3', 'Leningrad', '31-471', '031 423 45 38'), 
(92, 'Kimono Franek', 'Karateków 8', 'Mistrz', '30-029', '501 498 324');

6.1.2
insert into klienci (idklienta, nazwa, ulica, miejscowosc, kod, telefon) select 91, 'Matusiak Alina', ulica, miejscowosc, kod, telefon from klienci
where idklienta = 90;


6.2 

1.

INSERT INTO czekoladki VALUES
('X91', 'Nieznana Nieznajoma', NULL, 'Niewidzialna czekoladka wspomagająca odchudzanie.', 0.26, 0),
('M98', 'Mleczny Raj', 'Mleczna', 'Aksamitna mleczna czekolada w kształcie butelki z mlekiem.', 0.26, 36);


INSERT INTO czekoladki (IDCzekoladki, Nazwa, Czekolada, Opis, Koszt, Masa)
VALUES 
    ('X91', 'Nieznana Nieznajoma', NULL, 'Niewidzialna czekoladka wspomagająca odchudzanie.', 0.26, 0),
    ('M98', 'Mleczny Raj', 'Mleczna', 'Aksamitna mleczna czekolada w kształcie butelki z mlekiem.', 0.26, 36);
SELECT * FROM czekoladki
WHERE idczekoladki IN ('X91', 'M98');

zadanie 6.3
DELETE FROM czekoladki WHERE idczekoladki IN ('X91', 'M98');

zadani 6.4.1 PF
UPDATE klienci SET nazwa = 'Nowak Iza' WHERE nazwa = 'Matusiak Iza';

6.4.2
UPDATE czekoladki
SET koszt = koszt * 0.9
WHERE idczekoladki IN ('W98', 'M98', 'X91');

zadanie 6.5 GCZ
delete from klienci where nazwa like 'Matusiak %'

delete from klienci where idklienta>91

delete from czekoladki where masa = 0 or masa >=36 or koszt >=0.45

