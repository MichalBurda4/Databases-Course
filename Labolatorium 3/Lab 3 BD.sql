Przydatne komendy:

INTERSECT - część wspólna obu zapytań 

(Select idzamowinia, datarealizacji from zamowienia where idzamowienia < 20)
intersect
(select idzamowieni, datarealizacji form zamownienia where idzamowienia > 5)
order by idzamowienia asc

EXCEPT - różnica 

SELECT idklienta FROM klienci
EXCEPT
SELECT idklienta FROM zamowienia

klienic - zamownienia 

SELECT * FROM zamowienia WHERE datarealizacji::text LIKE '2013-10-%' - pobranie wszystkiego z pazdziernika 
trzeba zrobic tak jak wyzej poniewaz like dotyczy ciagów tekstowych a nie dat dlatego trzeba skastować je na tekst

Wyciaganie pewnych elementów daty (dzień miesiąc rok)

SELECT idzamowienia, datarealizacji, EXTRACT(month from datarealizacji) FROM zamowienia
EXTRACT(co chczemy wyciągnąć from jakiej kolumny)

SELECT idzamowienia, datarealizacji, DATE_PART('month', datarealizacji) FROM zamowienia
DATE_PART('co chcemy wyciągnąc', 'zjakiej kolumny')


SZUKANIE ULICY=====================================================================================

SELECT ulica FROM klienci WHERE ulica LIKE 'E%' OR ulica LIKE 'W%'
Wyszukuje ulice zaczynajaca sie na E lub W

SELECT ulica FROM klienci WHERE ulica SIMILAR TO '(E|W)%' - Lepiej nie używać bo się może  popierodlic cos

Wyszukuje ulice zaczynajaca sie na E lub W

SELECT ulica FROM klienci WHERE ulica ~ '^(E|W)' - wyrażenie regularne

3.6.3 z filmu
SELECT
    idmeczu,
    CONCAT (
        CASE WHEN gospodarze[1] > goscie[1] THEN 1 ELSE 0 END
        + CASE WHEN gospodarze[2] > goscie[2] THEN 1 ELSE 0 END
        + CASE WHEN gospodarze[3] > goscie[3] THEN 1 ELSE 0 END
        + CASE WHEN COALESCE(gospodarze[4], 0) > COALESCE(goscie[4], 0) THEN 1 ELSE 0 END
        + CASE WHEN COALESCE(gospodarze[5], 0) > COALESCE(goscie[5], 0) THEN 1 ELSE 0 END
    , ':',
        CASE WHEN goscie[1] > gospodarze[1] THEN 1 ELSE 0 END
        + CASE WHEN goscie[2] > gospodarze[2] THEN 1 ELSE 0 END
        + CASE WHEN goscie[3] > gospodarze[3] THEN 1 ELSE 0 END
        + CASE WHEN COALESCE(goscie[4], 0) > COALESCE(gospodarze[4], 0) THEN 1 ELSE 0 END
        + CASE WHEN COALESCE(goscie[5], 0) > COALESCE(gospodarze[5], 0) THEN 1 ELSE 0 END
    ) as wynik
FROM siatkowka.statystyki

contact łączy nam wynik gospodarz potem łączy w tym przypadku : a potem pobiera wynik gości wszystko umieszcza w jednej kolumnuie


funkcja coalesce
coalesce(NULL, 5) - zwróci 5 bo pierwszy argument jest nullem
coalesce(8, 5) - zwórci 8 bo pierwszy argument nie jest nullem



===============================================3.1============================================================================


1. select idZamowienia, datarealizacji from zamowienia where dataRealizacji BETWEEN '2013-11-12' AND '2013-11-20';
2. select idZamowienia, datarealizacji from zamowienia where dataRealizacji BETWEEN '2013-12-01' AND '2013-12-06' or datarealizacji between '2013-12-15' and '2013-12-20';

lub przy użyciu union

select idZamowienia, datarealizacji from zamowienia where dataRealizacji BETWEEN '2013-12-01' AND '2013-11-06'
union
select idZamowienia, datarealizacji from zamowienia where datarealizacji between '2013-12-15' and '2013-12-20';

--między 1 i 6 grudnia lub między 15 i 20 grudnia 2013
select idZamowienia, dataRealizacji 
from zamowienia 
where dataRealizacji between '2013-12-01' and '2013-12-06'
or
dataRealizacji between '2013-12-15' and '2013-12-20';

bierze tylku rekordy unikalne (nie zdublują się)
gdy używamy union musimy mieć taką samą liczbę kolumn
3. SELECT idzamowienia, datarealizacji
FROM zamowienia
WHERE datarealizacji::varchar LIKE '2013-12-__'

4. SELECT idZamowienia, dataRealizacji
FROM TwojaTabela
WHERE EXTRACT(YEAR FROM dataRealizacji) = 2013
  AND EXTRACT(MONTH FROM dataRealizacji) = 11;
5.
SELECT idZamowienia, dataRealizacji
FROM zamowienia
WHERE EXTRACT(YEAR FROM dataRealizacji) = 2013
  AND (EXTRACT(MONTH FROM dataRealizacji) = 11 OR EXTRACT(MONTH FROM dataRealizacji) = 12);

SELECT idZamowienia, dataRealizacji
FROM zamowienia
WHERE EXTRACT(YEAR FROM dataRealizacji) = 2013
  AND EXTRACT(MONTH FROM dataRealizacji) in ('11', '12');

--date_part

SELECT idZamowienia, dataRealizacji
FROM zamowienia
where
date_part('year', datarealizacj i) in ('2013') and
date_part('month', datarealizacji) in ('11', '12');

6.

SELECT idZamowienia, dataRealizacji
FROM zamowienia
WHERE EXTRACT(DAY FROM dataRealizacji) IN (17, 18, 19);  

--17, 18 lub 19 dnia miesiąca
SELECT idZamowienia, dataRealizacji
FROM zamowienia
where
date_part('day', datarealizacji) in ('17', '18', '19');
7.

SELECT idZamowienia, dataRealizacji
FROM zamowienia
WHERE EXTRACT(WEEK FROM dataRealizacji) IN (46, 47);

================================================================3.2========================================================================


1.
SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nazwa LIKE 'S%';

2.
SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nazwa LIKE 'S%i';

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nazwa LIKE 'S%' AND nazwa LIKE '%i'

3.
SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nazwa LIKE 'S% m%';

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nazwa LIKE 'S%' AND nazwa LIKE '% m%'

4.

SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nazwa LIKE 'A%' OR nazwa LIKE 'B%' OR nazwa LIKE 'C%';

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nazwa ~ '^(A|B|C)'

5.
SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nazwa ILIKE '%orzech%';

6. rozpoczyna się na literę 'S' i zawiera w środku literę 'm',

SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nazwa ~ 'S.*m';

SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nazwa like 'S%m%';

~ - szukasz dopasowania bez wzgledu na wielkosc liter

7.

SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nazwa ILIKE '%maliny%' OR nazwa ILIKE '%truskawki%';

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nazwa ~* '(^| )maliny|truskawki'

8.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! WAŻNE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

nie rozpoczyna się żadną z liter: 'D'-'K', 'S' i 'T',

SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE
  NOT (LEFT(nazwa, 1) BETWEEN 'D' AND 'K' OR LEFT(nazwa, 1) IN ('S', 'T'));

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nazwa !~ '^[D-KST]'


9.

SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nazwa LIKE 'Slod%' OR nazwa LIKE 'Słod%';

10. składa się dokładnie z jednego słowa.

SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nazwa ~ '^[a-zA-Z]+$'; 

SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE nazwa ~ '^\w+$

===============================================================3.3===================================================================
DISTINCT - używamy aby wyeliminować duplikaty
1.
SELECT DISTINCT miejscowosc
FROM Klienci
WHERE LENGTH(miejscowosc) - LENGTH(REPLACE(miejscowosc, ' ', '')) > 1

SELECT DISTINCT miejscowosc
FROM klienci
WHERE miejscowosc LIKE '% %'

2.
select nazwa, telefon
from klienci
where telefon like '___ ___ __ __';


3.
select nazwa, telefon
from klienci
where telefon like '___ ___ ___';

=================================================================3.4===========================================================
1.

SELECT idCzekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE masa BETWEEN 15 AND 24

UNION

SELECT idCzekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE koszt BETWEEN 15 AND 24;


2.

SELECT idCzekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE masa BETWEEN 25 AND 35


EXCEPT

SELECT idCzekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE koszt BETWEEN 0.25 and 0.35;


3.
SELECT idCzekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE (masa BETWEEN 15 AND 24) AND (koszt BETWEEN 0.15 and 0.24)

UNION

SELECT idCzekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE (masa BETWEEN 25 AND 35) AND (koszt BETWEEN 0.25 and 0.35);

4.

SELECT idCzekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE masa BETWEEN 15 AND 24

INTERSECT


SELECT idCzekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE koszt BETWEEN 0.15 and 0.24;

5.

SELECT idCzekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE masa BETWEEN 25 AND 35

EXCEPT

SELECT idCzekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE (koszt NOT BETWEEN 0.15 AND 0.24) AND (koszt NOT BETWEEN 0.29 AND 0.35);

============================================================3.5===================================================================
1. trzeba to w terminalu robic 
SELECT IdKlienta
FROM Klienci
EXCEPT
SELECT IdKlienta
FROM zamowienia;

2. !!!!!!!!!!!!!!!!!!!!!to sprawdzic trzeba na lekcji!!!!!!!!!!!!!!!!!!!! - nie wiem czemu ale na stronie to nie dziala a w terminalu juz tak
SELECT idpudelka
FROM pudelka
EXCEPT
SELECT idzamowienia
FROM zamowienia;

3.
-- Wybierz nazwy klientów, które zawierają "rz" lub "Rz"
SELECT nazwa 
FROM klienci
WHERE nazwa LIKE '%rz%' OR nazwa LIKE '%Rz%'

UNION

-- Wybierz nazwy czekoladek, które zawierają "rz" lub "Rz"
SELECT nazwa
FROM czekoladki
WHERE nazwa LIKE '%rz%' OR nazwa LIKE '%Rz%'

UNION

-- Wybierz nazwy pudełek, które zawierają "rz" lub "Rz"
SELECT nazwa AS wynik
FROM pudelka
WHERE nazwa LIKE '%rz%' OR nazwa LIKE '%Rz%';

4.
select idczekoladki from czekoladki 
except 
select idczekoladki from zawartosc;

=================================================================3.6==========================================================

SELECT * FROM siatkowka.statystyki
1.
select gospodarze[1] + gospodarze[2] + gospodarze[3]
+ coalesce(gospodarze[4], 0)
+ coalesce(gospodarze[5], 0) as "Suma punktów gospodarzy", 

goscie[1] + goscie[2] + goscie[3]
+ coalesce(goscie[4], 0)
+ coalesce(goscie[5], 0) as "Suma punktów gosci"
from statystyki;

2.
SELECT idmeczu,
    gospodarze[1] + gospodarze[2] + gospodarze[3] +
    COALESCE(gospodarze[4], 0) + COALESCE(gospodarze[5], 0) AS "Suma punktów gospodarzy",
    goscie[1] + goscie[2] + goscie[3] +
    COALESCE(goscie[4], 0) + COALESCE(goscie[5], 0) AS "Suma punktów gości"
FROM siatkowka.statystyki
WHERE gospodarze[5] > 15 or goscie[5] > 15;

3.
SELECT
    idmeczu,
    CONCAT(
        (CASE WHEN (gospodarze[1] > goscie[1]) THEN 1 ELSE 0 END +
         CASE WHEN (gospodarze[2] > goscie[2]) THEN 1 ELSE 0 END +
         CASE WHEN (gospodarze[3] > goscie[3]) THEN 1 ELSE 0 END +
         CASE WHEN (gospodarze[4] > goscie[4]) THEN 1 ELSE 0 END +
         CASE WHEN (gospodarze[5] > goscie[5]) THEN 1 ELSE 0 END),
        ':',
        (CASE WHEN (gospodarze[1] < goscie[1]) THEN 1 ELSE 0 END +
         CASE WHEN (gospodarze[2] < goscie[2]) THEN 1 ELSE 0 END +
         CASE WHEN (gospodarze[3] < goscie[3]) THEN 1 ELSE 0 END +
         CASE WHEN (gospodarze[4] < goscie[4]) THEN 1 ELSE 0 END +
         CASE WHEN (gospodarze[5] < goscie[5]) THEN 1 ELSE 0 END)
    ) AS "Wynik"
FROM statystyki;

--identyfikator i wynik meczu w formacie x:y, np. 3:1 (wynik jest pojedynczą kolumną – napisem),
select 
idmeczu,
concat(
(case when (gospodarze[1] > goscie[1]) then 1 else 0 end + 
 case when (gospodarze[2] > goscie[2]) then 1 else 0 end +
 case when (gospodarze[3] > goscie[3]) then 1 else 0 end +
 case when (gospodarze[4] > goscie[4]) then 1 else 0 end +
 case when (gospodarze[5] > goscie[5]) then 1 else 0 end 
),
':',
(case when (goscie[1] > gospodarze[1]) then 1 else 0 end +
 case when (goscie[2] > gospodarze[2]) then 1 else 0 end +
 case when (goscie[3] > gospodarze[3]) then 1 else 0 end +
 case when (goscie[4] > gospodarze[4]) then 1 else 0 end +
 case when (goscie[5] > gospodarze[5]) then 1 else 0 end
)
)
from siatkowka.statystyki;


4.

 identyfikator meczu, sumę punktów zdobytych przez gospodarzy i sumę punktów zdobytych przez gości, dla meczów, w których gospodarze zdobyli ponad 100 punktów,

SELECT idmeczu,
    gospodarze[1] + gospodarze[2] + gospodarze[3] +
    COALESCE(gospodarze[4], 0) + COALESCE(gospodarze[5], 0) AS "Suma punktów gospodarzy",
    goscie[1] + goscie[2] + goscie[3] +
    COALESCE(goscie[4], 0) + COALESCE(goscie[5], 0) AS "Suma punktów gości"
FROM statystyki
WHERE (gospodarze[1] + gospodarze[2] + gospodarze[3] +
    COALESCE(gospodarze[4], 0) + COALESCE(gospodarze[5], 0)) > 100;


5.
SELECT idmeczu, gospodarze[1] as "Pierwszy set gospodarzy",
    gospodarze[1] + gospodarze[2] + gospodarze[3] +
    COALESCE(gospodarze[4], 0) + COALESCE(gospodarze[5], 0) AS "Suma punktów gospodarzy"
FROM statystyki
WHERE sqrt(gospodarze[1]) < log(2,gospodarze[1] + gospodarze[2] + gospodarze[3]
+ coalesce(gospodarze[4], 0)
+ coalesce(gospodarze[5], 0) + goscie[1] + goscie[2] + goscie[3]
+ coalesce(goscie[4], 0)
+ coalesce(goscie[5], 0));


==============================================================3.7==================================================================
na poczatku w pliku napisać set seatch_path siatkowka;
Otworzenie pliku w unixach 
nano lab3zap1.sql

psql -H -U miburda -h lab.kis.agh.edu.pl -p 1600 < lab3zap1.sql > wynik.html
less wynik.html

tworzysz plik w ssh: nano lab3zap1.sql
wklejasz tam jedno polecenie z 3.6
potem to zapisujesz 
wklejasz w ssh komende: psql -H -U miburda -h lab.kis.agh.edu.pl -p 1600 < lab3zap1.sql > wynik.html (tylko podstawiasz tutaj swoje nazwy 
wynik.html to jest jakas nazwa troche nie wiem czy to jest jakis plik czy jakby no nie wiem chyba jakis plik)
i wpisujesz: less wynik.html 
i powinno ci pokazać wynik tego pytania 
jak ci pokazuje że nie znajduje jakigoś folderu to daj w tym pliku co tworzyłeś: set seatch_path siatkowka;
==============================================================3.8==================================================================
psql -U miburda -h lab.kis.agh.edu.pl -p 1600 -a -f lab3zap2.sql -t -A -F ',' -o pytanie.txt
less pytanie.txt


-H : Switches to HTML output mode.
-a : Print all nonempty input lines to standard output as they are read. (This does not apply to lines read interactively.).
-f : Read commands from the file filename, rather than standard input.
-o : Put all query output into file.
-A : Switches to unaligned output mode. (The default output mode is aligned.).
-F : Use separator as the field separator for unaligned output.
-t : Turn off printing of column names and result row count footers, etc.
