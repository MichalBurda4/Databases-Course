Dzięki triggerom możemy dodawać modyfikować i usuwać wiersze

DROP TRIGGER IF EXISTS tr_przedZamowieniem ON kwiaciarnia.zamowienia;

CREATE OR REPLACE FUNCTION kwiaciarnia.fn_przedZamowieniem() --standardowo jak w funkcjach tworzymy funkcje
RETURNS TRIGGER AS ----funkcja standardowo zwraca apstrakcyjny typ trigger
$$ --- delimiter rozpoczynający ciało fucnkji
DECLARE rabat INTEGER; -- zmienne pomocnicze 
DECLARE stanRoznica INTEGER;
BEGIN --rozpoczęcie ciała funkcji

    rabat := kwiaciarnia.rabat(new.idklienta);

    IF rabat > 0 THEN
        new.cena := new.cena - (new.cena * (rabat::decimal / 100::decimal));
    END IF;

    UPDATE kwiaciarnia.kompozycje
    SET stan = stan - 1
    WHERE idkompozycji = new.idkompozycji;

    SELECT (stan - minimum) INTO stanRoznica
    FROM kwiaciarnia.kompozycje
    WHERE idkompozycji = new.idkompozycji;

    IF (stanRoznica < 0) THEN
        INSERT INTO kwiaciarnia.zapotrzebowanie
        (idkompozycji, data)
        VALUES
        (new.idkompozycji, CURRENT_DATE)
        ON CONFLICT (idkompozycji) DO UPDATE SET data = CURRENT_DATE;
    END IF;

    RETURN new; ---- na koncu trigger zawsze zwraca new 

END;
$$ LANGUAGE PLpgSQL;

CREATE TRIGGER tr_przedZamowieniem
BEFORE INSERT ON kwiaciarnia.zamowienia
FOR EACH ROW ---- trigger odpala się dla np 5 razy jeżeli jeden wiersz ma 5 kolumn 
EXECUTE PROCEDURE kwiaciarnia.fn_przedZamowieniem();


FOR EACH STATEMENT - trigger uruchomi funkcję tylko raz 

12.1

1.
2.

##########
#
# 12.1.1
#
##########

DROP TRIGGER IF EXISTS tr_przedZamowieniem ON kwiaciarnia.zamowienia;

CREATE OR REPLACE FUNCTION kwiaciarnia.fn_przedZamowieniem()
RETURNS TRIGGER AS
$$
DECLARE rabat INTEGER;
DECLARE stanRoznica INTEGER;
BEGIN

    rabat := kwiaciarnia.rabat(new.idklienta);

    IF rabat > 0 THEN
        new.cena := new.cena - (new.cena * (rabat::decimal / 100::decimal));
    END IF;

    UPDATE kwiaciarnia.kompozycje
    SET stan = stan - 1
    WHERE idkompozycji = new.idkompozycji;

    SELECT (stan - minimum) INTO stanRoznica
    FROM kwiaciarnia.kompozycje
    WHERE idkompozycji = new.idkompozycji;

    IF (stanRoznica < 0) THEN
        INSERT INTO kwiaciarnia.zapotrzebowanie
        (idkompozycji, data)
        VALUES
        (new.idkompozycji, CURRENT_DATE)
        ON CONFLICT (idkompozycji) DO UPDATE SET data = CURRENT_DATE;
    END IF;

    RETURN new;

END;
$$ LANGUAGE PLpgSQL;

CREATE TRIGGER tr_przedZamowieniem
BEFORE INSERT ON kwiaciarnia.zamowienia
FOR EACH ROW
EXECUTE PROCEDURE kwiaciarnia.fn_przedZamowieniem();

##########
#
# 12.1.2
#
##########

CREATE OR REPLACE FUNCTION kwiaciarnia.fn_poDostawie()
RETURNS TRIGGER AS
$$
BEGIN
    IF new.stan > new.minimum AND old.stan <= old.minimum THEN
        DELETE FROM kwiaciarnia.zapotrzebowanie WHERE idkompozycji = new.idkompozycji;
    END IF;
    
    RETURN new;
END;
$$ LANGUAGE PLpgSQL;

CREATE TRIGGER tr_poDostawie
AFTER UPDATE ON kwiaciarnia.kompozycje
FOR EACH ROW
EXECUTE PROCEDURE kwiaciarnia.fn_poDostawie();

12.2

1.
##########
#
# 12.2.1 - wersja alternatywna, kiedy trigger odpala się PRZED aktualizacją rekordu
#
##########

DROP TRIGGER IF EXISTS tr_przedAktualizacja ON public.pudelka;

CREATE OR REPLACE FUNCTION public.fn_przedAktualizacja()
RETURNS TRIGGER AS
$$
DECLARE koszt_wytw NUMERIC(7,2);
BEGIN
    
    SELECT SUM(cz.koszt * z.sztuk) + 0.9 INTO koszt_wytw
    FROM
        pudelka p
        INNER JOIN zawartosc z ON p.idpudelka = z.idpudelka
        INNER JOIN czekoladki cz ON cz.idczekoladki = z.idczekoladki
    WHERE
        p.idpudelka = new.idpudelka
    GROUP BY p.idpudelka;

    IF new.cena < 1.05*koszt_wytw THEN
        new.cena = 1.05*koszt_wytw; 
    END IF;
   
    RETURN new;

END;
$$ LANGUAGE PLpgSQL;

CREATE TRIGGER tr_przedAktualizacja
BEFORE UPDATE ON pudelka
FOR EACH ROW
EXECUTE PROCEDURE fn_przedAktualizacja();


12.4

GRANT prawa ON obiekt TO uzytkownik;
prawa: select, insert, update, delete, create, all privileges,
obiekt: tabela, schemat, baza danych, widok etc.,
uzytkownik: nazwa uzytkownika, public (wszyscy).
Odbieranie praw:

REVOKE prawa ON obiekt FROM uzytkownik;


12.5 widoki to chyba jakby umożliwia dostęp do jakiegoś większego selecta w łatwy sposób 

1.
##########
#
# 12.5.1
#
##########

CREATE OR REPLACE VIEW zamowieniaWysylka AS
SELECT
    z.idzamowienia, z.datarealizacji,
    k.nazwa, k.ulica, k.miejscowosc, k.kod
FROM
    zamowienia z
    NATURAL JOIN klienci k;

----------------------------------------------

SELECT * FROM zamowieniaWysylka;



usuwanie tabeli - drop table nazwa_tabeli;


CREATE TABLE wazne (
    id SERIAL PRIMARY KEY,
    dane TEXT
);

INSERT INTO wazne ( dane) 
VALUES 
    ('Dane 1'), 
    ( 'Dane 2'), 
    ( 'Dane 3');


CREATE TABLE zapas (
    id SERIAL PRIMARY KEY,
    stary_id int,
    dane TEXT,
    czas TIMESTAMP);

CREATE OR REPLACE FUNCTION on_delete_wazne()
returns trigger as
$$
BEGIN
	INSERT INTO zapas(stary_id, dane, czas)
	values(old.id, old.dane, current_timestamp);
	return old;

END;
$$ language PlpgSQL;

create trigger wazneAfterDelete
after delete on wazne
for each row --- dla każdego wiersza kasowanego
execute function on_delete_wazne();

delete from wazne where id=2;
select * from wazne;
select * from zapas;



-------------------------------------------

create or replace function on_update_wazne() returns trigger as 
$$ begin         
insert into zapas(stary_id, dane, czas)         
values(old.id, old.dane, current_timestamp);         
return old; 
end; 
$$ LANGUAGE plpgsql;


create trigger wazneAfterUpdate 
after update on wazne 
for each row 
execute function on_update_wazne();



------------
------------
MBroś

CREATE OR REPLACE FUNCTION on_update_pilnuj()
    RETURNS TRIGGER AS
$$
BEGIN

    INSERT INTO zapas(stary_id, dane, czas, akcja)
    VALUES (
            OLD.id,
            OLD.dane,
            CURRENT_TIMESTAMP,
            CASE
                WHEN OLD IS NOT NULL AND NEW IS NOT NULL
                    THEN 'ZMIENIONE'
                ELSE 'USUNIĘTE'
            END
           );
    
    RETURN OLD;
END ;
$$
    LANGUAGE plpgsql;

CREATE TRIGGER wazneDeleteUpdate
    AFTER UPDATE OR DELETE
    ON wazne
    FOR EACH ROW
EXECUTE FUNCTION on_update_pilnuj();

