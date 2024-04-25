5.1 GIT

1. łącznej liczby czekoladek w bazie danych (w tabeli czekoladki),

SELECT count(czekolada) 
FROM czekoladki;

SELECT count(idczekoladki) 
FROM czekoladki;

lub 

SELECT COUNT(*) FROM czekoladki


2. łącznej liczby czekoladek z nadzieniem (na 2 sposoby) - podpowiedź: count(*), count(nazwaKolumny), 

SELECT COUNT(*) AS liczba_czekoladek_z_nadzieniem
FROM czekoladki
WHERE nadzienie IS NOT NULL;


SELECT COUNT(*) FROM czekoladki WHERE nadzienie IS NOT NULL


SELECT COUNT(nadzienie) FROM czekoladki

3.
Nie wiem co ja tu napisalem
SELECT COUNT(nadzienie) AS liczba_czekoladek_z_nadzieniem
FROM czekoladki;

SELECT idpudelka
FROM zawartosc
GROUP BY idpudelka
ORDER BY SUM(sztuk) DESC
LIMIT 1

=================
with tempTable as (
    Select nazwa, sum(sztuk) as suma
    FROM zawartosc INNER JOIN pudelka USING(idpudelka)
    GROUP BY idpudelka, nazwa
)
SELECT * FROM tempTable where suma = (SELECT max(suma) from tempTable);

============================najbardziej dokurwiona odpowiedz-============
select max(nn) from
(select sum(zz.sztuk) nn from
	zawartosc zz 
	group by zz.idpudelka)	

================jeszcze inna opcja[--------------
select p.nazwa,sum(z.sztuk) n from
zawartosc z join pudelka p on p.idpudelka=z.idpudelka
group by p.idpudelka
having sum(z.sztuk)=
(select max(nn) from
	(select sum(zz.sztuk) nn from
	zawartosc zz join pudelka pp on pp.idpudelka=zz.idpudelka
	group by pp.idpudelka) Q);

=====================moje
select max(suma) from
(select idpudelka, sum(sztuk) as suma
from zawartosc
group by idpudelka
order by sum(sztuk) desc)

4. identyfikatorów pudełek i łącznej liczby czekoladek zawartej w każdym z nich,

SELECT idpudelka, SUM(sztuk)
FROM zawartosc
GROUP BY idpudelka

Nie ma znaczenia czy damy p.idpudelka = z.idpudelka czy na odwrót 


5.

SELECT p.idpudelka, COALESCE(bez.liczba, 0)
FROM
    pudelka p
   
    LEFT JOIN (
        SELECT z.idpudelka, SUM(z.sztuk) AS liczba
        FROM zawartosc z JOIN czekoladki c ON z.idczekoladki = c.idczekoladki
        WHERE c.orzechy IS NULL
        GROUP BY z.idpudelka
    ) bez USING (idpudelka)


SELECT distinct p.idpudelka, COALESCE(bez.liczba, 0)
FROM
    pudelka p
    JOIN zawartosc z using (idpudelka)
    LEFT  JOIN czekoladki c using (idczekoladki)
    LEFT JOIN (
        SELECT z.idpudelka, SUM(z.sztuk) AS liczba
        FROM zawartosc z JOIN czekoladki c ON z.idczekoladki = c.idczekoladki
        WHERE c.orzechy IS NULL
        GROUP BY z.idpudelka
    ) bez USING (idpudelka)

6.

SELECT p.idpudelka, COALESCE(ml.liczba, 0)
FROM
    pudelka p
    LEFT JOIN (
        SELECT z.idpudelka, SUM(z.sztuk) AS liczba
        FROM zawartosc z 
        JOIN czekoladki c ON z.idczekoladki = c.idczekoladki
        WHERE c.czekolada = 'mleczna'
        GROUP BY z.idpudelka
    ) ml USING (idpudelka)

5.2 GIT

1.

##########
#
# 5.2.1
#
##########

SELECT p.idpudelka, SUM(cz.masa*z.sztuk) as masa
FROM pudelka p
    INNER JOIN zawartosc z ON p.idpudelka = z.idpudelka
    INNER JOIN czekoladki cz ON cz.idczekoladki = z.idczekoladki
GROUP BY p.idpudelka



2. identyfikatora i masy pudełka o największej masie (przy użyciu LIMIT 1),

SELECT p.idpudelka, SUM(cz.masa*z.sztuk) as masa
FROM pudelka p
    INNER JOIN zawartosc z ON p.idpudelka = z.idpudelka
    INNER JOIN czekoladki cz ON cz.idczekoladki = z.idczekoladki
GROUP BY p.idpudelka
order by masa DESC
limit 1


3. średniej masy pudełka w ofercie cukierni


SELECT AVG(m.masa) FROM (
    SELECT SUM(cz.masa*z.sztuk) as masa
    FROM
        czekoladki cz
        INNER JOIN zawartosc z ON cz.idczekoladki = z.idczekoladki
        INNER JOIN pudelka p ON z.idpudelka = p.idpudelka
    GROUP BY p.idpudelka
) m


SELECT AVG(m.masa) FROM (
    SELECT p.idpudelka, SUM(cz.masa*z.sztuk) as masa
    FROM
        czekoladki cz
        INNER JOIN zawartosc z ON cz.idczekoladki = z.idczekoladki
        INNER JOIN pudelka p ON z.idpudelka = p.idpudelka
    GROUP BY p.idpudelka
) m


##########
#
# 5.2.4
#
##########

SELECT p.idpudelka, (SUM(cz.masa*z.sztuk) / SUM(z.sztuk)) as srednia
FROM
    czekoladki cz
    INNER JOIN zawartosc z ON cz.idczekoladki = z.idczekoladki
    INNER JOIN pudelka p ON z.idpudelka = p.idpudelka
GROUP BY p.idpudelka

5.3 git

1.

SELECT datarealizacji, COUNT(*)
FROM zamowienia
GROUP BY datarealizacji
ORDER BY datarealizacji ASC


GROUP BY: Klauzula GROUP BY jest używana do grupowania wyników według określonej kolumny lub kolumn. W tym zapytaniu grupujemy wyniki według kolumny "DataZamowienia," co oznacza, że wyniki zostaną podzielone na grupy odpowiadające poszczególnym datom zamówień. Następnie funkcja agregująca COUNT(*) oblicza liczbę zamówień w każdej grupie (czyli na każdą datę zamówienia).

ORDER BY: Klauzula ORDER BY jest używana do sortowania wyników. W tym zapytaniu używamy jej, aby posortować wyniki rosnąco według kolumny "DataZamowienia." Dzięki temu dane zostaną przedstawione w kolejności chronologicznej, od najwcześniejszej daty do najpóźniejszej daty zamówienia.

2.

SELECT COUNT(*) AS LiczbaZamowien
FROM Zamowienia;

SELECT COUNT(idzamowienia) FROM zamowienia

3. =============================================================

SELECT SUM(a.sztuk * p.cena)
FROM artykuly a 
JOIN pudelka p on p.idpudelka = a.idpudelka

4. chyba git ale chuj wie

SELECT
    k.idklienta,
    COALESCE(z.z_liczba, 0) as z_liczba,
    COALESCE(s.s_suma, 0) as s_suma
FROM
    klienci k
    LEFT JOIN (
        SELECT idklienta, COUNT(*) as z_liczba
        FROM zamowienia
        GROUP BY idklienta
    ) z ON k.idklienta = z.idklienta
    LEFT JOIN (
        SELECT z.idklienta, SUM(a.sztuk * p.cena) as s_suma
        FROM
            zamowienia z
            JOIN artykuly a USING (idzamowienia)
            JOIN pudelka p USING (idpudelka)
        GROUP BY z.idklienta
    ) s ON k.idklienta = s.idklienta


5.4

1.
SELECT cz.idczekoladki
FROM
    czekoladki cz
    JOIN zawartosc zaw USING(idczekoladki)
GROUP BY cz.idczekoladki
ORDER BY COUNT(*) DESC
LIMIT 1

2.

##########
#
# 5.4.2 - WERSJA HARDCORE BEZ LIMITU, KIEDY WIELE PUDEŁEK MA TEN SAM MAX WYNIK
#
##########

WITH xyz AS (
    SELECT pud.idpudelka, SUM(zaw.sztuk) AS liczba
    FROM
        pudelka pud
        INNER JOIN zawartosc zaw USING(idpudelka)
        INNER JOIN czekoladki cz USING(idczekoladki)
    WHERE cz.orzechy IS NULL
    GROUP BY pud.idpudelka
    ORDER BY liczba DESC
)
SELECT p.idpudelka, SUM(z.sztuk)
FROM
    pudelka p
    INNER JOIN zawartosc z USING (idpudelka)
    INNER JOIN czekoladki czz USING (idczekoladki)
WHERE czz.orzechy IS NULL
GROUP BY p.idpudelka
HAVING SUM(z.sztuk) = (SELECT MAX(xyz.liczba) FROM xyz)

3.

WITH xyz AS (
    SELECT cz.idczekoladki, COUNT(zaw.idczekoladki) AS liczba
    FROM
        czekoladki cz
        LEFT JOIN zawartosc zaw USING(idczekoladki)
    GROUP BY cz.idczekoladki
)
SELECT cz.idczekoladki
FROM
    czekoladki cz
    LEFT JOIN zawartosc zaw USING(idczekoladki)
GROUP BY cz.idczekoladki
HAVING COUNT(zaw.idczekoladki) = (SELECT MIN(xyz.liczba) FROM xyz)

4.

SELECT a.idpudelka
FROM artykuly a
GROUP BY a.idpudelka
ORDER BY COUNT(*) DESC
LIMIT 1


select a.idpudelka
from artykuly a
join zamowienia z using (idzamowienia)
group by a.idpudelka
order by count(z.idzamowienia) DESC
limit 1

)

5.5 GIT

1.

SELECT
    EXTRACT(QUARTER FROM datarealizacji) AS Kwartal,
    COUNT(*) AS LiczbaZamowien
FROM Zamowienia
GROUP BY Kwartal
ORDER BY Kwartal;

2.

SELECT
    EXTRACT(MONTH FROM datarealizacji) AS miesiac,
    COUNT(*) AS LiczbaZamowien
FROM Zamowienia
GROUP BY miesiac
ORDER BY miesiac;

3.
w tym sposobie wyświetlamy numer tygodnia 

SELECT
    EXTRACT(week FROM datarealizacji) AS tydzien,
    COUNT(*) AS LiczbaZamowien
FROM Zamowienia
GROUP BY tydzien
ORDER BY tydzien;

w tym sposobie wyswietlamy date tygodnia 

SELECT
    DATE_TRUNC('week', datarealizacji) AS Tydzien,
    COUNT(*) AS LiczbaZamowien
FROM Zamowienia
GROUP BY Tydzien
ORDER BY Tydzien;


4.


SELECT k.Miejscowosc, COUNT(*) AS LiczbaZamowien
FROM Klienci k
JOIN Zamowienia z ON k.IdKlienta = z.IdKlienta
GROUP BY k.Miejscowosc
ORDER BY k.Miejscowosc;



5.6 GIT

1.

SELECT SUM(cz.masa * z.sztuk) AS LacznaMasaPudelek
FROM Pudelka p
JOIN Zawartosc z ON p.idpudelka = z.idpudelka
JOIN Czekoladki cz ON z.idczekoladki = cz.idczekoladki;

2.

SELECT SUM(p.cena) AS LacznaCenaPudelek
FROM Pudelka p
JOIN Zawartosc z ON p.idpudelka = z.idpudelka;

5.7 git

1.

SELECT SUM(p.cena - cz.koszt * z.sztuk) AS zysk
FROM Pudelka p
JOIN Zawartosc z ON p.idpudelka = z.idpudelka
JOIN Czekoladki cz ON z.idczekoladki = cz.idczekoladki
GROUP BY p.idpudelka

2.
select SUM(a.sztuk * p.cena) as lacznaWartoscZamowien
from zamowienia z
join artykuly a on a.idzamowienia = z.idzamowienia 
join pudelka p on p.idpudelka = a.idpudelka;


3.

SELECT SUM(p.cena - cz.koszt * z.sztuk) AS zysk
FROM Pudelka p
JOIN Zawartosc z ON p.idpudelka = z.idpudelka
JOIN Czekoladki cz ON z.idczekoladki = cz.idczekoladki

5.8 GIT


##########
#
# 5.8 GIT
#
##########

CREATE SEQUENCE lp START 1;

SELECT nextval('lp') as lp, p.idpudelka FROM pudelka p ORDER BY p.idpudelka ASC;

DROP SEQUENCE lp;
