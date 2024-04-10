Funkcje tworzymy w następujący sposób 
CREATE OR REPLACE FUNCTION nazwafunkcji(argument typargumentu) - można przed typem
RETURN typ AS - co fuinkcja będzie zwracać
$$ - delimeter, rozpoczęcie ciała funkcji
DECLARE - dekklrujemy tutaj zmienne pomocnicze
    wynik INTEGER;
BEGIN - rozpoczęcie ciała funkcji
    SELECT SUM(c.masa*z.sztuk) INTO wynik
    FROM
        pudelka p
        JOIN zawartosc z USING (idpudelka)
        JOIN czekoladki c USING (idczekoladki)
    WHERE p.idpudelka = arg1; - robimy to dla pudlka które jest takie jak argument wejściowy

    RETURN wynik; - na końcu zwracamy wynik 
END; - zakończenie ciała funkcji
$$ LANGUAGE PLpgSQL; - delimeter zamykający i dopisujemy w jakim języku pisaliśmy ciało funkcji (na labach pisaliśmy zawsze w tym i w tym pisz)


********
czasem jak coś się spierdoli to trzeba wywalić tę funkcję:
DROP FUNCTION nazwafunkcji;
11.1

1.
CREATE OR REPLACE FUNCTION masaPudelka(in arg1 CHARACTER(4))
RETURNS INTEGER AS
$$
DECLARE 
    wynik INTEGER;
BEGIN
    SELECT SUM(c.masa*z.sztuk) INTO wynik
    FROM
        pudelka p
        JOIN zawartosc z USING (idpudelka)
        JOIN czekoladki c USING (idczekoladki)
    WHERE p.idpudelka = arg1;

    RETURN wynik;
END;
$$ LANGUAGE PLpgSQL;

SELECT masaPudelka('alls');
select idpudelka, masaPudelka(idpudelka) from pudelka;
2.=======================================================================
CREATE OR REPLACE FUNCTION liczbaCzekoladek(in arg1 CHARACTER(4))
RETURNS INTEGER AS
$$
DECLARE 
    wynik INTEGER;
BEGIN
    SELECT SUM(z.sztuk) INTO wynik
    FROM
        pudelka p
        JOIN zawartosc z USING (idpudelka)
    WHERE p.idpudelka = arg1;

    RETURN wynik;
END;
$$ LANGUAGE PLpgSQL;

SELECT liczbaCzekoladek('alls');
11.2
1.
GCza 
create function zysk(idpudelka char(4))
returns NUMERIC(8,2)  as
$$
declare
zysk NUMERIC(8,2) :=0;
begin
select p.cena - 0.9- SUM(c.koszt*z.sztuk) into zysk
from pudelka p
natural join zawartosc z
join czekoladki c on c.idczekoladki = z.idczekoladki
where p.idpudelka=$1
group by p.cena;
return zysk;
end;
$$
language plpgsql;

CREATE OR REPLACE FUNCTION zysk(in arg1 CHARACTER(4))
RETURNS NUMERIC(10,2) AS
$$
DECLARE 
    wynik NUMERIC(10,2);
BEGIN
    SELECT cena - 0.9 - SUM(c.koszt*z.sztuk) INTO wynik
    FROM
        pudelka p
        JOIN zawartosc z USING (idpudelka)
        JOIN czekoladki c USING (idczekoladki)
    WHERE p.idpudelka = arg1 GROUP BY idpudelka, cena;

    RETURN wynik;
END;
$$ LANGUAGE PLpgSQL;

SELECT zysk('alls');
2.===========================================================
select sum(zysk(a.idpudelka)*a.sztuk)
FROM
    zamowienia z
    NATURAL JOIN artykuly a
WHERE
    z.datarealizacji >= '2013-11-11'
    AND z.datarealizacji <= '2013-11-17'
	
	
select sum(zysk(a.idpudelka)*a.sztuk)
FROM
    artykuly a
	join zamowienia z using(idzamowienia)
WHERE
    z.datarealizacji >= '2013-11-11'
    AND z.datarealizacji <= '2013-11-17'


SELECT SUM(zysk(a.idpudelka)*a.sztuk)
FROM  artykuly a 
JOIN zamowienia z using(idzamowienia)
WHERE EXTRACT(YEAR FROM z.dataRealizacji) = 2013
  AND EXTRACT(MONTH FROM z.dataRealizacji) = 11
  AND EXTRACT(DAY FROM z.dataRealizacji) = 17;


11.3

1.


----------Moje ilosc zamowien
CREATE OR REPLACE FUNCTION iloscZamowien(in arg1 INTEGER)
RETURNS INTEGER AS
$$
DECLARE 
    wynik INTEGER;
BEGIN
    SELECT count(z.idzamowienia) INTO wynik
    FROM
        zamowienia z
    WHERE z.idklienta = arg1;

    RETURN wynik;
END;	
$$ LANGUAGE PLpgSQL;

SELECT iloscZamowien(idklienta) from klienci;
--MichBur 
--11.3.1
CREATE OR REPLACE FUNCTION sumaZamowien(in arg1 INTEGER)
RETURNS integer AS --retruns numeric(10,2) as
$$
DECLARE 
    wynik INTEGER; --wynik NUMERIC(10,2)
BEGIN
    SELECT SUM(a.sztuk*p.cena) INTO wynik
    FROM
        zamowienia z
        NATURAL JOIN artykuly a
        NATURAL JOIN pudelka p
    WHERE z.idklienta = arg1;

    RETURN wynik;
END;
$$ LANGUAGE PLpgSQL;

SELECT sumaZamowien(1);
2.----------------------------------------------------------------------
--moim zdaniem tutaj tez powinno byc numeric(10,2) chociaz tutaj to juz troche wyjebane bo zwracamy w sumie albo 4 albo 7 albo 8 albo 0 wiec nie zwracamy ceny 
CREATE OR REPLACE FUNCTION rabat(in arg1 INTEGER)
RETURNS INTEGER AS
$$
DECLARE wynik INTEGER;
DECLARE wartoscZamowien INTEGER;
BEGIN
    SELECT SUM(a.sztuk*p.cena) INTO wartoscZamowien
    FROM
        zamowienia z
        NATURAL JOIN artykuly a
        NATURAL JOIN pudelka p
    WHERE z.idklienta = arg1;

    IF wartoscZamowien BETWEEN 101 AND 200 THEN
        wynik := 4;
    ELSIF wartoscZamowien BETWEEN 201 AND 400 THEN
        wynik := 7;
    ELSIF wartoscZamowien > 400 THEN
        wynik := 8;
    ELSE
        wynik := 0;
    END IF;

    RETURN wynik;
END;
$$ LANGUAGE PLpgSQL;

SELECT rabat(1);





-- PF rabat - alternatywna wersja
CREATE OR REPLACE FUNCTION rabat(idk INTEGER) RETURNS INTEGER AS
$$ DECLARE
    suma NUMERIC(10,2);
BEGIN
    suma := sumaZamowien(idk);
    IF suma > 400 THEN
        RETURN 8;
    ELSIF suma > 200 THEN
        RETURN 7;
    ELSIF suma > 100 THEN
        RETURN 4;
    ELSE
        RETURN 0;
    END IF;
END;
$$ LANGUAGE PLpgSQL;

CREATE OR REPLACE FUNCTION rabat(in arg1 INTEGER)
RETURNS INTEGER AS
$$
DECLARE wynik INTEGER;
DECLARE wartoscZamowien INTEGER;
BEGIN
    SELECT SUM(a.sztuk*p.cena) INTO wartoscZamowien
    FROM
        zamowienia z
        NATURAL JOIN artykuly a
        NATURAL JOIN pudelka p
    WHERE z.idklienta = arg1;

    RETURN 
        CASE
            WHEN wartoscZamowien BETWEEN 101 AND 200 THEN 4
            WHEN wartoscZamowien BETWEEN 201 AND 400 THEN 7
            WHEN wartoscZamowien > 400 THEN 8
            ELSE 0
        END;
END;
$$ LANGUAGE PLpgSQL;

11.4 - funkcja dokona permanentnyh zmian w bazie danych napisz ją tutaj ale nie w pgAdminie
===================funkcja bezargumentowa==============================
##########
#
# 11.4
#
##########

CREATE OR REPLACE FUNCTION podwyzka()
RETURNS void AS --ma nic nie zwracac tylko podwyższamy cene
$$
DECLARE zmiana NUMERIC(7,2);
DECLARE c1 RECORD;
DECLARE c2 RECORD;
BEGIN
    FOR c1 IN SELECT * FROM czekoladki LOOP

        zmiana := case
                  when c1.koszt < 0.20 then 0.03
                  when c1.koszt between 0.20 and 0.29 then 0.04
                  else 0.05 end;

        UPDATE czekoladki
        SET koszt = koszt+zmiana WHERE idczekoladki = c1.idczekoladki;

        FOR c2 IN SELECT * FROM zawartosc WHERE idczekoladki = c1.idczekoladki LOOP

            UPDATE pudelka SET cena = cena + (zmiana*c2.sztuk) WHERE idpudelka = c2.idpudelka;

        END LOOP;

    END LOOP;
END;
$$ LANGUAGE PLpgSQL;

SELECT podwyzka();


11.5  
create or repla ce function obnizka()
returns void as
$$
declare zmiana NUMERIC(7,2);
declare c1 record;
declare c2 record;
begin
 for c1 in select * from czekoladki loop 
	zmiana:= case
		when c1.koszt < 0.22 then 0.03
              	when c1.koszt between 0.23 and 0.32 then 0.04
              	else 0.05 end;
 UPDATE czekoladki
    SET koszt = koszt - zmiana WHERE idczekoladki = c1.idczekoladki;

    FOR c2 IN SELECT * FROM zawartosc WHERE idczekoladki = c1.idczekoladki LOOP

      UPDATE pudelka SET cena = cena - (zmiana*c2.sztuk) WHERE idpudelka = c2.idpudelka;

    END LOOP;

  END LOOP;
END;
$$ LANGUAGE PLpgSQL;

11.6

1. - przykład jak zwrócić całą tabele 

##########
#
# 11.6.1
#
##########

CREATE OR REPLACE FUNCTION listaZamowien(in arg1 INTEGER)
RETURNS TABLE(
    r_idzamowiena INTEGER,
    r_idpudelka CHARACTER(4),
    r_datarealizacji DATE) AS
$$
DECLARE c RECORD;
BEGIN
    RETURN QUERY SELECT z.idzamowienia, a.idpudelka, z.datarealizacji
    FROM
        zamowienia z
        JOIN klienci k USING(idklienta)
        JOIN artykuly a USING(idzamowienia)
    WHERE k.idklienta = arg1;
END;
$$ LANGUAGE PLpgSQL;

SELECT * FROM listaZamowien(1);

2.  Napisz funkcję zwracającą listę klientów z miejscowości, której nazwa podawana jest jako argument wywołania funkcji. Lista powinna zawierać: nazwę klienta i adres. Przetestuj działanie funkcji.

create or replace function listaKlientowMiejscowosci(in arg1 varchar(15))
returns table(
r_nazwa varchar(130),
r_ulica varchar(15),
r_miejscowosc varchar(15)) AS
$$
declare c RECORD;
begin 
return query select k.nazwa, k.ulica, k.miejscowosc
	from klienci k
	where k.miejscowosc = arg1;
end;
$$ language PLpgSQL;


SELECT * from listaKlientowMiejscowosci('Warszawa');


11.7
CREATE OR REPLACE FUNCTION kwiaciarnia.rabat(in arg1 VARCHAR(10))
RETURNS INTEGER AS
$$
DECLARE wynik INTEGER;
DECLARE wartoscZamowien INTEGER;
DECLARE wartoscHistorii INTEGER;
DECLARE wartoscSuma INTEGER;
BEGIN
    SELECT SUM(cena) INTO wartoscZamowien
    FROM
        kwiaciarnia.zamowienia
    WHERE idklienta = arg1;

    SELECT SUM(cena) INTO wartoscHistorii
    FROM
        kwiaciarnia.historia
    WHERE idklienta = arg1 AND termin > CURRENT_DATE - interval '7 days';

    wartoscSuma := COALESCE(wartoscZamowien, 0) + COALESCE(wartoscHistorii, 0);

    IF wartoscSuma BETWEEN 1 AND 100 THEN
        wynik := 5;
    ELSIF wartoscSuma BETWEEN 101 AND 400 THEN
        wynik := 10;
    ELSIF wartoscSuma BETWEEN 401 AND 700 THEN
        wynik := 15;
    ELSIF wartoscSuma > 700 THEN
        wynik := 20;
    ELSE
        wynik := 0;
    END IF;

    RETURN wynik;
END;
$$ LANGUAGE PLpgSQL;

SELECT kwiaciarnia.rabat('msowins');
