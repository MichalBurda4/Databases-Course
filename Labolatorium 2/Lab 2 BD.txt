SELECT * FROM czekoladki; - pokazuje całą tabele

Select * from czekoladki order by czekolada; - posortuje po czekoladzie najpierw białe potem ciemne bo wiadomo białe lepsze niż ciemne
Select * from czekoladki order by czekolada asc; - to samo co wyżej

Select * from czekoladki order by czekolada desc; - odwrotna kolejność niż to wyżej

asc - rosnąco
desc - malejąco

Operator IS - sprawdza czy cos jest czymś np NULL IS NULL zwróci true
działa tutaj też is not

select (100 * 0.2)::int; - kastowanie na inta jakby nie dać tych nawiasów to by skastowła to 0.2 na inta i by dało wynik 0 a nie 20 bo 0.2 skastowane na inta daje 0 

select power(2,3); - podnosi 2 do potęgi 3 

zadanie 2.1 GIT
1.select nazwa, ulica, miejscowosc from klienci order by nazwa;
2.select * from klienci order by miejscowosc desc, nazwa asc;
3.
SELECT * FROM klienci
WHERE miejscowosc IN ('Kraków', 'Warszawa')
ORDER BY
  miejscowosc DESC,
  nazwa asc;


  SELECT * FROM klienci
WHERE miejscowosc = 'Kraków' OR miejscowosc = 'Warszawa'
ORDER BY
  miejscowosc DESC,
  nazwa asc;
4.
select * from klienci 
order by
miejscowosc desc;

5.
select * from klienci 
where miejscowosc like 'Krak%'
order by 
klienci asc;

select * from klienci 
where miejscowosc = 'Kraków'
order by nazwa asc;

zadanie 2.2
1. select * from czekoladki where masa > 20;

select nazwa, masa from czekoladki
where masa > 20;

2. select * from czekoladki where masa > 20 and koszt > 0.25;

select nazwa, masa, koszt from czekoladki 
where masa > 20 AND koszt > 0.25;

3.
SELECT *, koszt * 100 AS koszt_w_groszach
FROM czekoladki
WHERE masa > 20 AND koszt > 0.25;

select nazwa, masa, koszt * 100 AS koszt_W_GROSZACH from czekoladki 
where masa > 20 AND koszt > 0.25

4.
SELECT nazwa, czekolada, nadzienie, orzechy
FROM czekoladki
WHERE (czekolada = 'mleczna' AND (nadzienie = 'maliny' OR nadzienie = 'truskawki')) 
   OR orzechy = 'orzechy laskowe'
   AND czekolada != 'gorzka';


SELECT nazwa, czekolada, nadzienie, orzechy
FROM czekoladki
WHERE (czekolada = 'mleczna' AND (nadzienie = 'maliny' OR nadzienie = 'truskawki')) 
OR (orzechy = 'laskowe' AND czekolada != 'gorzka'); 

SELECT nazwa, czekolada, nadzienie, orzechy
FROM czekoladki
WHERE (czekolada = 'mleczna' AND (nadzienie in ('maliny', 'truskawki'))) 
OR (orzechy = 'laskowe' AND czekolada != 'gorzka'); 



5.
select nazwa, koszt  from czekoladki where 
koszt >0.25;

6.
select nazwa, czekolada from czekoladki where (czekolada = 'biała' or czekolada = 'mleczna');

zadanie 2.3 GIT
1.select 124 * 7 + 45;
2.select power(2, 20); lub select 2^20;
3.select sqrt(3);
4.select pi();

zadanie 2.4 GIT
1.SELECT * FROM czekoladki WHERE masa BETWEEN 15 AND 24;
2.SELECT * FROM czekoladki WHERE koszt BETWEEN 0.25 AND 0.35;
3.select * from czekoladki where masa between 25 and 35 or koszt BETWEEN 0.25 AND 0.35;

zadanie 2.5 GIT
1. select idCzekoladki, nazwa, czekolada, orzechy, nadzienie from czekoladki WHERE orzechy IS NOT NULL;
2. select idCzekoladki, nazwa, czekolada, orzechy, nadzienie from czekoladki WHERE orzechy IS NULL;
3. select idCzekoladki, nazwa, czekolada, orzechy, nadzienie from czekoladki WHERE orzechy IS  not NULL or nadzienie is not null; 
4.
SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE (czekolada = 'mleczna' OR czekolada = 'biała') 
  AND orzechy IS NULL;

SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE (czekolada in ('mleczna', 'biała')) 
  AND orzechy IS NULL;
5.
SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
WHERE czekolada NOT IN ('mleczna', 'biała')
  AND (orzechy IS NOT NULL OR nadzienie IS NOT NULL);
6.
SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
where nadzienie is not null;
7.
SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
where nadzienie is null;

8.
SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
where nadzienie is null and orzechy is null;

9.
SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie
FROM czekoladki
where nadzienie is null and (czekolada = 'mleczna' or czekolada = 'biała');

zadanie 2.6
1. select * from czekoladki 
where
masa BETWEEN 15 AND 24 or koszt BETWEEN 0.15 AND 0.24;

2. select * from czekoladki 
where
(masa BETWEEN 15 AND 24 and koszt BETWEEN 0.15 AND 0.24) or (masa between 25 and 35 and koszt between 0.25 and 0.35);
3. select * from czekoladki where masa between 15 and 24 and koszt between 0.15 and 0.24;
4. takie jak 5 tylko prostrze
5. select * from czekoladki where masa between 25 and 35 and  not (koszt between 0.15 and 0.25 or koszt between 0.25 and 0.35);


zadanie 2.7 
\a - jakby nie wyrównuje tabeli rzeczy nie są wyświetlane w formie tabeli tylko jedno obok drugiego

Polecenie \f w PostgreSQL jest używane do ustawiania lub wyświetlania aktualnej szerokości kolumny np \f 20

Polecenie \H w psql (interaktywnym kliencie PostgreSQL) jest używane do włączania lub wyłączania w trybie "HTML format mode". Tryb ten pozwala na wyświetlanie wyników zapytania w formacie HTML, co może być przydatne, gdy chcesz generować wyniki zapytań w formie, która jest przyjazna dla przeglądarek internetowych lub innych narzędzi do przetwarzania HTML.

\o - przekierowuje wyniki do pliku wynik.html np \o [nazwa_pliku]


zadanie 2.8
1.
SELECT idczekoladki, nazwa, opis
FROM czekoladki;

i w psql
\i zapytanie1.sql



psql -d nazwa_bazy_danych -U nazwa_uzytkownika -a -f zapytanie1.sql
psql -d schemat_cukiernia.sql -U miburda -a -f zapytanie1.sql

2.

psql -d nazwa_bazy_danych -U nazwa_uzytkownika -a -f zapytanie1.sql -o zapytanie1.html
psql -d schemat_cukiernia.sql -U miburda -a -f zapytanie1.sql -o zapytanie1.html
