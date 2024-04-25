--Różne polecenia:
--stworzenie bazy danych - postgresqlpwd
--login na phpPgAdmin: s415707 lub s+415707 ale raczej to 1 

--znak zachęty w psql =>
--psql – oficjalny terminalowy klient pozwalający na połączenie z bazą danych PostgreSQL

psql -U miburda -h lab.kis.agh.edu.pl -p 1600 

SELECT idklienta, miejscowosc FROM klienci;

SELECT * FROM klienci;  całość cały bloczek - kolejność ma znaczenie 

SELECT * FROM klienci WHERE idklienta > 35 AND idklienta < 44; - pokaże id klientów od 36 numeru do 43

SELECT * FROM klienci WHERE (idklienta > 35 AND idklienta < 44) OR idklienta = 18;

SELECT * FROM klienci WHERE idklienta BETWEEN 25 AND 30; - przedział domknięty

SELECT * FROM klienci WHERE miejscowosc IN ('Kraków', 'Gdańsk', 'Siedlce');

SELECT * FROM klienci WHERE miejscowosc LIKE 'K%'; - wszystkie na k

SELECT * FROM klienci WHERE miejscowosc LIKE 'K_____'; - 6 liter i na K

SELECT * FROM klienci WHERE miejscowosc LIKE 'K\_'; - będzie wyszkane konkretnie K_

SELECT * FROM klienci WHERE miejscowosc NOT IN ('Kraków', 'Gdańsk', 'Siedlce'); - wszystkie poza Tak samo z NOT BETWEEN

SELECT * FROM siatkowka.mecze;

--Można pisać małymi SELECT FROM IN itd ale lepiej duzymi

--\l	wyświetla listę baz danych

--\dt	wyświetla listę tabel w bieżącej BD

--\d nazwa_tabeli	wyświetla strukturę tabeli

--\?	wyświetla pomoc odnośnie poleceń psql

--\h	wyświetla pomoc odnośnie SQL

--\q	kończy pracę z psql

--\i nazwa_pliku	wykonuje skrypt

--\dn	wyświetla nazwy schematów

set search_path to siatkowka; - korzystamy teraz z bazy siatkowka

--konto szelowe to unixy 

--zadanie 1.3 
5 select * from czekoladki where czekolada in 'mleczna';

SELECT * FROM klienci WHERE ulica LIKE 'A%'; - wielkosc liter ma znaczenia 

Wszystkie:

select * from czekoladki where czekolada LIKE 'mleczna';
select * FROM czekoladki 
where 
czekolada Like 'mleczna'
and 
orzechy like 'laskowe';

SELECT * from czekoladki where
czekolada IN ('mleczna', 'gorzka');

SELECT * from czekoladki where 
masa > 25;

select * from klienci;

select * from klienci where
miejscowosc in ('Gdańsk', 'Kraków', 'Warszawa');

select * from klienci where 
miejscowosc not like 'Gdańsk';

select * from klienci where
ulica like 'Akacjowa%';
