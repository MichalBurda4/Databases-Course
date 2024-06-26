OPERATOR IN
warunek że dana kolumna będzie w wynikach danego podzapytania	
SELECT * FROM klienci WHERE idklienta IN (SELECT idklienta FROM zamowienia)

OPERATOR NOT IN
Zaprzeczony operator in.	

OPERATOR EXIST 
exists zwraca prawde jeżeli podzapytanie zwróci jakiekolwiek rekordy 	
SELECT k.* FROM klienci k WHERE EXISTS (SELECT z.* FROM zamowienia z WHERE z.idklienta = k.idklienta)


OPERATOR NOT EXIST 
Zaprzeczony operatorn exist 

OPERATOR ANY 

Wszystkie czekoladki z kremem, ktorych koszt jest wyzszy od kosztu
dowolnej czekoladki z truskawkami wystepujacej w pudelku 'alls':

SELECT * FROM czekoladki
WHERE
    nadzienie = 'krem'
    AND koszt > ANY (
                     SELECT cz.koszt
                     FROM czekoladki cz INNER JOIN zawartosc z ON cz.idczekoladki = z.idczekoladki
                     WHERE cz.nadzienie = 'truskawki' AND z.idpudelka = 'alls'
                    )

Protip: Prosze zwrocic uwage, ze operator =ANY() jest odpowiednikiem operatora IN().

Operator any używamy gdy mamy przed nim jakieś porównanie 

OPERATOR ALL

Wszystkie czekoladki z kremem, ktorych koszt jest wyzszy od kosztu
wszystkich czekoladek z truskawkami wystepujacych w pudelku 'alls':

SELECT * FROM czekoladki
WHERE
    nadzienie = 'krem'
    AND koszt > ALL (
                     SELECT cz.koszt
                     FROM czekoladki cz INNER JOIN zawartosc z ON cz.idczekoladki = z.idczekoladki
                     WHERE cz.nadzienie = 'truskawki' AND z.idpudelka = 'alls'
                    )


to samo co any 


============================================================Ćwiczenia====================================================


===============================================================10.1====================================================== 
10.1
SELECT DISTINCT nazwa 
FROM pudelka NATURAL JOIN zawartosc 
WHERE idczekoladki 
  IN (SELECT idczekoladki FROM czekoladki ORDER BY koszt LIMIT 3);
 
To pytanie wypisuje unikalne nazwy pudełek które zawierają czekoladki których są najtańsze (3 najtańsze)


SELECT nazwa 
FROM czekoladki 
WHERE koszt = (SELECT MAX(koszt) FROM czekoladki);


wypisuje nazwe czekoladki której koszt jest jest najdroższy


sELECT nazwa, koszt, (SELECT MAX(koszt) FROM czekoladki) AS MAX FROM czekoladki;
-wypisuje nazwe koszt oraz maksymalny koszt czekoladki 

SELECT p.nazwa, idpudelka 
FROM (SELECT idczekoladki FROM czekoladki ORDER BY koszt LIMIT 3) 
  AS ulubioneczekoladki 
NATURAL JOIN zawartosc 
NATURAL JOIN pudelka p;
wypisuje nazwe idpudelka z tabel pudelka zawartosc oraz z utworzonej tabeli składającej się z 3 wierszy w których znajdują się id czkoladki których koszt jest najteńszy  


===============================================================10.2========================================================
1.
     2.1 SELECT dataRealizacji, idzamowienia
FROM Zamowienia
WHERE idKlienta IN (SELECT idKlienta FROM Klienci WHERE nazwa like '% Antoni');

wersja  2: 
     SELECT dataRealizacji, idzamowienia 
    from zamowienia 
    join klienci k using(idklienta)
    where k.nazwa like '% Antoni'



2.
select dataRealizacji, idzamowienia from zamowienia
where idklienta in (Select idklienta from klienci where ulica like '%/%');

3.
SELECT dataRealizacji, idzamowienia
FROM Zamowienia
where idklienta in (select idklienta from klienci where miejscowosc in ('Kraków'))
and 
EXTRACT(month FROM dataRealizacji) = 11
and 
EXTRACT(year FROM dataRealizacji) = 2013


select dataRealizacji, idzamowienia from zamowienia
where idklienta in (Select idklienta from klienci where miejscowosc like 'Kraków')
and 
extract(month from datarealizacji) = 11
and
extract(year from datarealizacji) = 2013
======================================================================10.3===============================================================================

1.
select k.nazwa, k.ulica, k.miejscowosc from klienci k join zamowienia z on (k.idklienta = z.idklienta) where z.idzamowienia in (select idzamowienia from zamowienia where datarealizacji = '2013-11-12');

select nazwa, ulica, miejscowosc
from klienci where
idklienta in (select idklienta from zamowienia where
			 extract(day from datarealizacji) = 12
			 and
			  extract(month from datarealizacji) = 11
			  and
			  extract(year from datarealizacji) = 2013
			 )
			 
select nazwa, ulica, miejscowosc from klienci where 
idklienta in (select idklienta from zamowienia where datarealizacji = '2013-11-12');

2.
select nazwa, ulica, miejscowosc
from klienci where
idklienta in (select idklienta from zamowienia where
			  extract(month from datarealizacji) = 11
			  and
			  extract(year from datarealizacji) = 2013
			 )
			
select distinct k.nazwa, k.ulica, k.miejscowosc from klienci k
join zamowienia z using (idklienta)
where date_part('month', dataRealizacji) IN ('11') and date_part('year', dataRealizacji) IN ('2013');

3.

select distinct k.nazwa, k.ulica, k.miejscowosc from klienci k
join zamowienia z using (idklienta)
join artykuly a using (idzamowienia)
join pudelka p using (idpudelka)
where
p.idpudelka in (select idpudelka from pudelka where nazwa='Kremowa fantazja' or nazwa='Kolekcja jesienna');

========================to nie dziala ale bylo na lekcji===============================
select k.nazwa, k.ulica, k.miejscowosc from klienci k
join zawartosc z on (k.idklienta = z.idklienta)
join pudelka p on (z.idpudelka = p.idpudelka)
where p.idpudelka in (select idpudelka from pudelka where nazwa='Kremowa fantazja' or nazwa='Kolekcja jesienna');
========================================================================================================

4.
select distinct k.nazwa, k.ulica, k.miejscowosc from klienci k
join zamowienia z using (idklienta)
join artykuly a using (idzamowienia)
join pudelka p using (idpudelka)
where
p.idpudelka in (select idpudelka from pudelka where nazwa='Kremowa fantazja' or nazwa='Kolekcja jesienna')
and 
a.idzamowienia in (select idzamowienia from artykuly where sztuk > 2)



select nazwa, miejscowosc, ulica from klienci where idklienta in (
select idklienta from zamowienia where idzamowienia in (
select idzamowienia from artykuly where sztuk > 2 and idpudelka in (
select idpudelka from pudelka where nazwa in ('Kremowa fantazja', 'Kolekcja jesienna'))));

5.
select distinct k.nazwa, k.miejscowosc, k.ulica
from klienci k 
join zamowienia z using (idklienta)
join artykuly a using (idzamowienia)
join pudelka p using (idpudelka)
join zawartosc za using (idpudelka)
join czekoladki c using (idczekoladki)
where idczekoladki in (
select idczekoladki from czekoladki where
orzechy = 'migdały'
)

select distinct k.nazwa, k.miejscowosc, k.ulica from klienci k 
join zamowienia z using (idklienta)
join artykuly a using (idzamowienia)
join pudelka p using (idpudelka)
where idpudelka in (
select z.idpudelka from zawartosc z
join czekoladki c using(idczekoladki)
where c.orzechy = 'migdały');

6.
select nazwa, miejscowosc, ulica from klienci
where idklienta in (Select idklienta from zamowienia)


select distinct k.nazwa, k.miejscowosc, k.ulica from klienci k 
join zamowienia z using (idklienta)
where idklienta in (Select idklienta from zamowienia)

7.
select nazwa, miejscowosc, ulica from klienci
where idklienta not in (Select idklienta from zamowienia)

tak nie można: (bo chyba po scaleniu jakby coś się psuje troche nie wiem jak to pisemnie wyjaśnić)
select k.nazwa, k.miejscowosc, k.ulica from klienci k 
join zamowienia z using (idklienta)
where idklienta not in (Select idklienta from zamowienia)
================================================================================10.4================================================================

1.
select nazwa, opis, koszt, idczekoladki from czekoladki where idczekoladki in(Select idczekoladki where idczekoladki like 'd09')
2.
select nazwa, opis, cena from pudelka where idpudelka in (Select p.idpudelka from pudelka p join zawartosc z using(idpudelka) 
														  join czekoladki c using(idczekoladki)
														  where c.nazwa like 'Gorzka truskawkowa')
3.
4.

10.4.4 i 10.4.5 na kolanie to takie cos: 10.4.4
Select nazwa opis cena from pudełka where idpudelka in (select idpudelka from 
zawartość where sztuk>=4);

10.4.5
select nazwa opis cena from pudełka where idpudelka in (select idpudelka from 
zawartość where sztuk>=3 and idczekoladki in (select idczekoladki from czekoladki 
where nazwa = Gorzka Teuskawkowa));
5.
6.
select p.nazwa, p.opis, p.cena from pudelka p where p.idpudelka in(
select z.idpudelka from zawartosc z where z.idczekoladki in(
select c.idczekoladki from czekoladki c where c.nadzienie like 'truskawki'));


7. -sprawdzić

select p.nazwa, p.opis, p.cena from pudelka p where p.idpudelka not in(
select z.idpudelka from zawartosc z where z.idczekoladki in(
select c.idczekoladki from czekoladki c where c.czekolada = 'gorzka'));

SELECT nazwa, opis, cena FROM pudelka WHERE idpudelka IN (SELECT z.idpudelka FROM zawartosc z JOIN czekoladki c ON c.idczekoladki = z.idczekoladki WHERE c.czekolada != 'gorzka');

8.
select nazwa, opis, cena from pudelka where idpudelka in(select z.idpudelka from zawartosc z join czekoladki c on c.idczekoladki=z.idczekoladki where c.orzechy is null);

9.
 select distinct p.nazwa, p.opis, p.cena from pudelka p
join zawartosc using (idpudelka)
join czekoladki using (idczekoladki)
where idczekoladki in (select idczekoladki where nadzienie is null);

--lub

SELECT nazwa, opis, cena FROM pudelka WHERE idpudelka IN (SELECT z.idpudelka FROM zawartosc z JOIN czekoladki c ON c.idczekoladki = z.idczekoladki WHERE c.nadzienie is null);

============================================================================10.5====================================================================

1.
select idczekoladki, nazwa from czekoladki
where koszt > any (SELECT koszt from czekoladki where idczekoladki = 'd08'); 
2.
3.

=====================================================================================10.6============================================================

1.
WITH tab1 AS (
    SELECT p.nazwa, count(*) AS ilosc
    FROM pudelka p
        INNER JOIN zawartosc USING(idpudelka)
    GROUP BY p.idpudelka, p.nazwa
    ORDER BY count(*) DESC
)
SELECT * FROM tab1 WHERE ilosc = (SELECT max(ilosc) FROM tab1);
2.
3.
10.6.1
select p.nazwa from pudelka p where p.idpudelka = (select z.idpudelka from zawartosc z 
where z.sztuk =(select max(za.sztuk) from zawartosc za)); 

10.6.2
select p.nazwa from pudelka p where p.idpudelka in (select distinct z.idpudelka 
from zawartosc z where z.sztuk = (select min(za.sztuk) from zawartosc za)); 

10.6.3
select p.nazwa from pudelka p where p.idpudelka in (select distinct z.idpudelka 
from zawartosc z where z.sztuk > (select avg(za.sztuk) from zawartosc za)); 

10.6.4
select p.nazwa from pudelka p where p.idpudelka in (select z.idpudelka from zawartosc z 
where z.sztuk = (select max(za.sztuk) from zawartosc za) or
z.sztuk = (select min(za2.sztuk) from zawartosc za2));
4.

===============================================================================10.7================================================================ git
SELECT ROW_NUMBER() OVER(ORDER BY idczekoladki), idczekoladki 
FROM czekoladki 
ORDER BY idczekoladki;

SELECT
    (SELECT COUNT(*) FROM czekoladki c1 WHERE c1.idczekoladki <= c2.idczekoladki),
    idczekoladki 
FROM czekoladki c2
ORDER BY idczekoladki;
