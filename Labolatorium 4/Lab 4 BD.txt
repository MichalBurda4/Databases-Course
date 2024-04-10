===============================================================Wstęp Przydatne komendy 4=======================================================================
select * from t1 cross join t2; - iloczyn kartezjański czyli łączenie wszystkiego ze wszystkim 

select * from t1 inner join t2 on t1.num = t2.num; - jest to część wspólna num czyli np łączym 1 z tabeli t1 i 1 z tabeli t2 

select * from inner join t2 using (num); - wyświetli tylko raz num a nie dwa razy lepiej to wyglada 
to samo co wzej to select * from t1 NATURAL INNER JOIN t2; - wyświetla tylko raz num ale jakby nie podajemy po czym łączymy wiec moze wyswietlic tez cos innego niz num jest to podatne na błędy 	

select * from t1 full join t2 on t1.num = t2.num - wyswietla wszystko 

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
filmik 4 18min

select * from t1 left join t2 on t1.num = t2.num and t2.value = 'xxx'; - pobiera tez te inne 


select * from t1 left join t2 on t1.num = t2.num where t2.value = 'xxx'; - pobiera tylko ten zgodny 


PODZAPYTANIA!!!!!!!!!!!

przykład 1

select * from klienci where idklienta in (select idklienta from zamowienai) - pobiera id klienta tylko tych których podzapytanie zostanie spełnione, w tym in (select idklienta from zamowienai) musi być tylko jedna kolumna jak bedzie wiecej to sie spierdoli moze byc zaliasowania (nazwana AS)


przykład 2

with z as (
	select idklienta from zamowienia 
)
select * from klienci where idklienta in (select * from z); - generujemy przy pomocy with gotowe podzapytania które potem mozemy wykorzystać
z zachowuje sie jak tabela a nie jak zapytanie 


==============================================================Ćwiczenia 4=============================================================================

4.1  
zostały złożone przez klienta, który ma na imię Antoni

set search_path to cukiernia;
W którym zapytaniu występuje iloczyn kartezjański?

loczyn kartezjański występuje w zapytaniach, które nie zawierają klauzuli WHERE lub nie wykorzystują operatora JOIN do określenia warunków łączenia wierszy z różnych tabel. W iloczynie kartezjańskim wszystkie wiersze z jednej tabeli łączą się z wszystkimi wierszami z drugiej tabeli, tworząc wynikową tabelę, która może być bardzo duża, jeśli tabelki mają wiele rekordów.

W Twoich zapytaniach:

SELECT k.nazwa FROM klienci k; - To nie ma łączenia z inną tabelą, więc nie występuje iloczyn kartezjański. Wynikiem jest lista wszystkich nazw klientów.

SELECT k.nazwa, z.idzamowienia FROM klienci k, zamowienia z; - To jest przykładem iloczynu kartezjańskiego, ponieważ nie ma klauzuli WHERE lub operatora JOIN, który określałby warunki łączenia wierszy z obu tabel. Wynikiem będzie kombinacja każdej nazwy klienta z każdym numerem zamówienia, co nie jest prawidłowym łączeniem danych.

SELECT k.nazwa, z.idzamowienia FROM klienci k, zamowienia z WHERE z.idklienta = k.idklienta; - To jest poprawne zapytanie, które wykorzystuje klauzulę WHERE do łączenia tabel na podstawie warunku, więc nie występuje iloczyn kartezjański.

SELECT k.nazwa, z.idzamowienia FROM klienci k NATURAL JOIN zamowienia z; - NATURAL JOIN jest oparte na kolumnach o tych samych nazwach w obu tabelach, więc to nie jest iloczyn kartezjański, ale wynik zależy od struktury tabel.

SELECT k.nazwa, z.idzamowienia FROM klienci k JOIN zamowienia z ON z.idklienta = k.idklienta; - To jest poprawne łączenie tabel z wykorzystaniem klauzuli JOIN, więc nie występuje iloczyn kartezjański.

SELECT k.nazwa, z.idzamowienia FROM klienci k JOIN zamowienia z USING (idklienta); - To również jest poprawne łączenie tabel z wykorzystaniem klauzuli JOIN i operatora USING, więc nie występuje iloczyn kartezjański.

Które zapytanie dostarcza bezwartościowych danych?
Zazwyczaj jest to zapytanie cross join bo na chuh nam to zazwyczaj bedą to zapytania z iloczynem kartezjańskim 

SELECT k.nazwa, z.idzamowienia FROM klienci k, zamowienia z; - To jest przykładem iloczynu kartezjańskiego, ponieważ nie ma klauzuli WHERE lub operatora JOIN, który określałby warunki łączenia wierszy z obu tabel. Wynikiem będzie kombinacja każdej nazwy klienta z każdym numerem zamówienia, co nie jest prawidłowym łączeniem danych.


1.


SELECT k.nazwa FROM klienci k;

2.
SELECT k.nazwa, z.idzamowienia FROM klienci k, zamowienia z;

3.
SELECT k.nazwa, z.idzamowienia FROM klienci k, zamowienia z  
WHERE z.idklienta = k.idklienta;

4.
SELECT k.nazwa, z.idzamowienia FROM klienci k NATURAL JOIN zamowienia z;


5.
SELECT k.nazwa, z.idzamowienia FROM klienci k JOIN zamowienia z
ON z.idklienta=k.idklienta;

6.
SELECT k.nazwa, z.idzamowienia FROM klienci k JOIN zamowienia z
USING (idklienta);
4.2=========================================================================================

1. (data realizacji, idzamowienia)
zostały złożone przez klienta, który ma na imię Antoni


select z.datarealizacji, z.idzamowienia, k.nazwa
from zamowienia z
join klienci k 
on z.idklienta = k.idklienta
WHERE k.nazwa LIKE '%Antoni'

2. zostały złożone przez klientów z mieszkań (zwróć uwagę na pole ulica),

select z.datarealizacji, z.idzamowienia, k.ulica
from zamowienia z
join klienci k 
on z.idklienta = k.idklienta
where k.ulica like '%/%'

3. zostały złożone przez klienta z Krakowa do realizacji w listopadzie 2013 roku.

select z.datarealizacji, z.idzamowienia, k.miejscowosc
from zamowienia z
join klienci k 
on z.idklienta = k.idklienta
WHERE k.miejscowosc = 'Krakaków'
  AND EXTRACT(YEAR FROM z.datarealizacji) = 2013
  AND EXTRACT(MONTH FROM z.datarealizacji) = 11


4.3 klientów (idklienta, nazwa, ulica, miejscowość)

1. złożyli zamówienia z datą realizacji nie starszą niż sprzed piętnastu lat,

SELECT DISTINCT k.idklienta, k.nazwa, k.ulica, k.miejscowosc
FROM klienci k 
JOIN zamowienia z ON k.idklienta = z.idklienta
WHERE z.datarealizacji >= NOW() - INTERVAL '15 YEARS'

2. zamówili pudełko Kremowa fantazja lub Kolekcja jesienna,

SELECT DISTINCT k.idklienta, k.nazwa, k.ulica, k.miejscowosc
FROM
    klienci k
    JOIN zamowienia z ON k.idklienta = z.idklienta
    JOIN artykuly a ON z.idzamowienia = a.idzamowienia
    JOIN pudelka p ON a.idpudelka = p.idpudelka
WHERE
    p.nazwa IN ('Kremowa fantazja', 'Kolekcja jesienna')

3. złożyli przynajmniej jedno zamówienie,

SELECT distinct k.nazwa, k.ulica, k.miejscowosc
FROM klienci k
join zamowienia z on k.idklienta = z.idklienta;

lub 
select distinct k.idklienta, k.nazwa, k.ulica, k.miejscowosc
from klienci k
join zamowienia z on k.idklienta = z.idklienta
where z.idklienta is not null

4. ===============Nie wiem czy to dobrze============ nie złożyli żadnych zamówień,


SELECT distinct k.idklienta, k.nazwa, k.ulica, k.miejscowosc
FROM klienci k
left join zamowienia z 
on k.idklienta = z.idklienta
WHERE z.idklienta IS NULL

SELECT k.* FROM klienci k LEFT JOIN zamowienia z ON k.idklienta = z.idklienta WHERE z.idzamowienia IS NULL

5. ★ złożyli zamówienia z datą realizacji w listopadzie 2013,

SELECT distinct k.idklienta, k.nazwa, k.ulica, k.miejscowosc
FROM klienci k
JOIN zamowienia z ON k.idklienta = z.idklienta
where extract(month from z.datarealizacji) = 11

6.
★ zamówili co najmniej 2 sztuki pudełek Kremowa fantazja lub Kolekcja jesienna w ramach jednego zamówienia,

SELECT DISTINCT k.idklienta, k.nazwa, k.ulica, k.miejscowosc
FROM
    klienci k 
    JOIN zamowienia z ON k.idklienta = z.idklienta
    JOIN artykuly a on z.idzamowienia = a.idzamowienia
    JOIN pudelka p ON a.idpudelka = p.idpudelka
WHERE
    a.sztuk >= 2
    AND (p.nazwa = 'Kremowa fantazja' OR p.nazwa = 'Kolekcja jesienna')

SELECT DISTINCT k.idklienta, k.nazwa, k.ulica, k.miejscowosc
FROM
    klienci k 
    JOIN zamowienia z ON k.idklienta = z.idklienta
    JOIN artykuly a on z.idzamowienia = a.idzamowienia
    JOIN pudelka p ON a.idpudelka = p.idpudelka
WHERE
    a.sztuk >= 2
    AND p.nazwa in ('Kremowa fantazja', 'Kolekcja jesienna')

7.
SELECT k.nazwa, k.ulica, k.miejscowosc
FROM klienci k
JOIN zamowienia z ON k.idklienta = z.idklienta
join artykuly a on z.idklienta = a.idzamowienia
join pudelka p on a.idpudelka = p.idpudelka 
join zawartosc za on p.idpudelka = za.idpudelka
join czekoladki c on za.idczekoladki = c.idczekoladki
where 
c.orzechy = 'migdały';

4.4 (nazwa pudełka, nazwa czekoladki, liczba sztuk):

1.
SELECT p.nazwa as pudelko, c.nazwa as czekoladka, z.sztuk
FROM
    pudelka p
    JOIN zawartosc z ON p.idpudelka = z.idpudelka
    JOIN czekoladki c ON z.idczekoladki = c.idczekoladki
	
2.
SELECT p.nazwa as pudelko, c.nazwa as czekoladka, z.sztuk
FROM
    pudelka p
    JOIN zawartosc z ON p.idpudelka = z.idpudelka
    JOIN czekoladki c ON z.idczekoladki = c.idczekoladki
WHERE p.idpudelka = 'heav'

3
SELECT p.nazwa as pudelko, c.nazwa as czekoladka, z.sztuk
FROM
    pudelka p
    JOIN zawartosc z ON p.idpudelka = z.idpudelka
    JOIN czekoladki c ON z.idczekoladki = c.idczekoladki
WHERE p.nazwa LIKE '%Kolekcja%''

4.5 (idpudelka, nazwa, opis, cena)

1.
SELECT p.idpudelka, p.nazwa, p.opis, p.cena
FROM
    pudelka p
    INNER JOIN zawartosc z ON p.idpudelka = z.idpudelka
    JOIN czekoladki cz ON z.idczekoladki = cz.idczekoladki
WHERE cz.idczekoladki = 'd09'

!!!!!!!!!!!!!!!!!Ale wystarczyłoby tak:
SELECT p.idpudelka, p.nazwa, p.opis, p.cena
FROM
    pudelka p
    INNER JOIN zawartosc z ON p.idpudelka = z.idpudelka
WHERE z.idczekoladki = 'd09'

2 zawierają przynajmniej jedną czekoladkę, której nazwa zaczyna się na S, 

SELECT distinct p.idpudelka, p.nazwa, p.opis, p.cena
FROM 
pudelka p
join zawartosc z on p.idpudelka = z.idpudelka	
JOIN czekoladki cz ON z.idczekoladki = cz.idczekoladki
WHERE cz.Nazwa LIKE 'S%'

!!!SELECT DISTINCT

3. zawierają przynajmniej 4 sztuki czekoladek jednego gatunku (o takim samym kluczu głównym),

SELECT DISTINCT p.idpudelka, p.nazwa, p.opis, p.cena
FROM
    pudelka p
    JOIN zawartosc z ON p.idpudelka = z.idpudelka
WHERE z.sztuk >= 4

4. zawierają czekoladki z nadzieniem truskawkowym,

SELECT distinct p.idpudelka, p.nazwa, p.opis, p.cena
FROM pudelka p
join zawartosc z on p.idpudelka = z.idpudelka	 	
JOIN czekoladki cz ON z.idczekoladki = cz.idczekoladki
WHERE cz.nadzienie = 'truskawki';

5. nie zawierają czekoladek w gorzkiej czekoladzie,



SELECT p.idpudelka, p.nazwa, p.opis, p.cena FROM pudelka p
EXCEPT
SELECT p.idpudelka, p.nazwa, p.opis, p.cena
FROM
    pudelka p
    JOIN zawartosc z ON p.idpudelka = z.idpudelka
    JOIN czekoladki c ON c.idczekoladki = z.idczekoladki
WHERE c.czekolada = 'gorzka'



6. ★ zawierają co najmniej 3 sztuki czekoladki Gorzka truskawkowa,

SELECT DISTINCT p.idpudelka, p.nazwa, p.opis, p.cena
FROM
    pudelka p
    INNER JOIN zawartosc z ON p.idpudelka = z.idpudelka
    INNER JOIN czekoladki c ON z.idczekoladki = c.idczekoladki
WHERE c.nazwa = 'Gorzka truskawkowa' AND z.sztuk >= 3

7.
##########
#
# 4.5.7 - wersja NIEPRAWIDŁOWA z LEFT JOINEM
#
##########

Wyjaśnienie:

Tzw. "LEFT JOIN z NULLEM" jest bardzo wygodną i skuteczną metodą weryfikacji, że "coś" nie istnieje. Z logicznego punktu widzenia jego działanie zmienia się kiedy pomiędzy tabelą, z której chcemy pobrać dane a LEFT JOINEM, istnieje jeszcze jedno złączenie, do którego zawsze dojdzie. Z takim przypadkiem mamy do czynienia niżej. Złączenie pudelka-zawartosc zawsze połączy wszystkie rekordy z obu tych tabel i tak naprawdę, bez względu na LEFT JOINA, już na tym etapie pobrane zostaną wszystkie czekoladki we wszystkich pudełkach. Następnie LEFT JOIN z NULLEM przefiltruje ten zbiór, pobierając z niego czekoladki bez orzechów (czyli do złączenia nie dojdzie). Jeśli jakieś pudełko zawiera jakiekolwiek czekoladki bez orzechów to pojawi się w wyniku.


SELECT DISTINCT p.nazwa, p.opis
FROM
    pudelka p
    LEFT JOIN zawartosc z ON p.idpudelka = z.idpudelka
    LEFT JOIN czekoladki cz ON (
        z.idczekoladki = cz.idczekoladki
        AND cz.orzechy IS NOT NULL
    )
WHERE cz.idczekoladki IS NULL

##########
#
# 4.5.7 - wersja PRAWIDŁOWA z LEFT JOINEM
#
##########

Wyjaśnienie:

Rozwiązaniem powyższego problemu jest takie przekształcenie zapytania, aby LEFT JOIN z NULLEM przylegał bezpośrednio do tabeli pudelka. Należy złożyć podzapytanie, które pobierze id pudełek, w których występują jakiekolwiek czekoladki z orzechami i za pomocą LEFT JOINA pozbyć się tych pudełek z wyniku.


SELECT p.nazwa, p.opis
FROM
    pudelka p
    LEFT JOIN (
        SELECT z.idpudelka
        FROM
            zawartosc z
            INNER JOIN czekoladki cz ON z.idczekoladki = cz.idczekoladki
        WHERE cz.orzechy IS NOT NULL
    ) j ON p.idpudelka = j.idpudelka
WHERE j.idpudelka IS NULL

##########
#
# 4.5.7 - wersja z EXCEPT
#
##########

SELECT p.idpudelka, p.nazwa, p.opis, p.cena FROM pudelka p

EXCEPT

SELECT DISTINCT p.idpudelka, p.nazwa, p.opis, p.cena
FROM
    pudelka p
    INNER JOIN zawartosc z ON p.idpudelka=z.idpudelka
    INNER JOIN czekoladki c ON c.idczekoladki=z.idczekoladki
WHERE c.orzechy IS NOT NULL;

8.

SELECT p.idpudelka, p.nazwa, p.opis, p.cena
FROM
    pudelka p
    INNER JOIN zawartosc z ON p.idpudelka = z.idpudelka
    INNER JOIN czekoladki c ON z.idczekoladki = c.idczekoladki
WHERE c.nazwa = 'Gorzka truskawkowa'

9.
SELECT DISTINCT p.idpudelka, p.nazwa, p.opis, p.cena
FROM
    pudelka p
    INNER JOIN zawartosc z ON p.idpudelka = z.idpudelka
    INNER JOIN czekoladki c ON z.idczekoladki = c.idczekoladki
WHERE c.nadzienie IS NULL

4.6
##########
#
# 4.6.1
#
##########

SELECT cz.idczekoladki, cz.nazwa FROM czekoladki cz
WHERE koszt > (SELECT koszt FROM czekoladki WHERE idczekoladki = 'd08')



SELECT idczekoladki, nazwa FROM czekoladki 
WHERE koszt > (SELECT koszt FROM czekoladki WHERE idczekoladki in ('d08'))




##########
#
# 4.6.2 - wersja bez WITH
#
##########

Kto (identyfikator klienta, nazwa klienta) złożył zamówienie na dowolne pudełko, które zamawiała Górka Alicja.



SELECT kk.nazwa
FROM
    klienci kk
    INNER JOIN zamowienia zz ON kk.idklienta = zz.idklienta
    INNER JOIN artykuly aa ON zz.idzamowienia = aa.idzamowienia
    INNER JOIN (
        SELECT a.idpudelka
        FROM
            klienci k
            INNER JOIN zamowienia z ON k.idklienta = z.idklienta
            INNER JOIN artykuly a ON z.idzamowienia = a.idzamowienia
        WHERE k.nazwa = 'Górka Alicja'
    ) gorka ON aa.idpudelka = gorka.idpudelka
WHERE kk.nazwa <> 'Górka Alicja'
GROUP BY kk.nazwa
ORDER BY kk.nazwa ASC

##########
#
# 4.6.2 - wersja z WITH
#
##########

WITH gorka AS (
        SELECT a.idpudelka
        FROM
            klienci k
            INNER JOIN zamowienia z ON k.idklienta = z.idklienta
            INNER JOIN artykuly a ON z.idzamowienia = a.idzamowienia
        WHERE k.nazwa = 'Górka Alicja'
)
SELECT kk.nazwa
FROM
    klienci kk
    INNER JOIN zamowienia zz ON kk.idklienta = zz.idklienta
    INNER JOIN artykuly aa ON zz.idzamowienia = aa.idzamowienia
    INNER JOIN gorka ON aa.idpudelka = gorka.idpudelka
WHERE kk.nazwa <> 'Górka Alicja'
GROUP BY kk.nazwa
ORDER BY kk.nazwa ASC  

##########
#
# 4.6.3
#
##########

WITH kat AS (
        SELECT a.idpudelka
        FROM
            klienci k
            INNER JOIN zamowienia z ON k.idklienta = z.idklienta
            INNER JOIN artykuly a ON z.idzamowienia = a.idzamowienia
        WHERE k.miejscowosc = 'Katowice'
)
SELECT kk.nazwa, kk.ulica, kk.miejscowosc
FROM
    klienci kk
    INNER JOIN zamowienia zz ON kk.idklienta = zz.idklienta
    INNER JOIN artykuly aa ON zz.idzamowienia = aa.idzamowienia
    INNER JOIN kat ON aa.idpudelka = kat.idpudelka
WHERE kk.miejscowosc <> 'Katowice'
GROUP BY kk.nazwa, kk.ulica, kk.miejscowosc
ORDER BY kk.nazwa ASC
