##############################
#
# Słownik
#
##############################

H = {P,O,E,B,K} <-- schemat relacji przedstawiający jej wszystkie atrybuty

F               <-- zbiór zależności funkcyjnych

F+              <-- domknięcie/dopełnienie zbioru zależności funkcyjnych
                    (wszystkie możliwe zależności jakie można wyprowadzić z F)


##############################
#
# Zadanie 8.1
#
##############################

H = {P,O,E,B,K}
F = {{P,O} → E, {P,E} → O, {P,O} → B, B → K}

------------------------------

Wyznacz wszystkie klucze relacji R:

Wskazówka:
- Klucz jest to taki minimalny zbiór atrybutów, że jego domknięcie jest zbiorem wszystkich atrybutów relacji.
- Nadklucz to taki zbiór atrybutów (niekoniecznie minimalny), że jego domknięcie jest zbiorem wszystkich atrybutów relacji.
- Zbiór wszystkich atrybutów relacji na pewno jest jej nadkluczem bo jest równy H.
- Z powyższych twierdzeń wynika, że klucze relacji to jej minimalne nadklucze.

Sprawdzamy więc domknięcia:

{P}+  = {P}
{P,O}+ = {P,O,E,B,K}
{P,E}+ = {P,E,O,B,K}
{P,B}+  = {P,B,K}

KLUCZE: {P,O} {P,E}

------------------------------

Wyznacz co najmniej 5 nietrywialnych i prostych zależności funkcyjnych należących do F+, ale nie należących do F.

Wskazówki:
- Zależność jest prosta, gdy prawa strona jest pojedynczym atrybutem (jest zbiorem jednoelementowym).
- Zależność trywialna to na przykład: K → K

F+ = {

    {P,O} -> K
    {P,E} -> B
    {P,E} -> K
    {P,O,E} -> B
    {P,O,E} -> K

}

------------------------------

Sprawdź czy F jest minimalny.

Zbiór minimalny to taki, w którym niczego już nie uprościmy i pozwala wyprowadzić
z niego pierwotny zbiór podany w zadaniu.

Zbiór w zadaniu jest minimalny - nie da się niczego usunąć ani uprościć.


##############################
#
# Zadanie 8.2
#
##############################

H = {P,O,E,B,K}
F = {{P,O} → E, {P,E} → O, {P,O} → B, B → K}

Które z poniższych zależności należą do zbioru F+?

P → E            NIE ponieważ {P}+ = {P}
{P,K} → B        NIE ponieważ {P,K}+ = {P,K}
{P,E} → B        TAK ponieważ {P,E}+ = {P,O,E,B,K}
{P,E,O} → K      TAK ponieważ {P,E,O}+ = {P,O,E,B,K}
B → O            NIE ponieważ {B}+ = {B,K}
{P,E} → {K,B}    TAK ponieważ {P,E}+ = {P,O,E,B,K}


##############################
#
# Zadanie 8.3
#
##############################

Wyznacz minimalny zbiór zależności funkcyjnych dla poniższych zbiorów:

8.3.1
F = {C → {A,B}, E → {A,D}, C → D, E → B}
obliczenia:
F = {C → A, C → B, E → A, E → D, C → D, E → B}
F = {C → A, C → B, C → D, E → A, E → B, E → D}

------------------------------

8.3.2
F = {A → B, A → C, {A,B} → D, {A,C} → {B,D}}
obliczenia:
F = {A → B, A → C, {A,B} → D, {A,C} → B, {A,C} → D}
z tego można wnioskować, że:
F = {A → B, A → C, A → D, A → B, A → D}
F = {A → B, A → C, A → D}

------------------------------

8.3.3
F = { A → B, B → C, A → C, C → A, C → B, B → A}
obliczenia:
F = {A → B, B → C, C → B, B → A}
F = {A → B, B → C, C → A}


##############################
#
# Zadanie 8.4
#
##############################

Dana jest relacja R o schemacie H = {A,C,G,N,S,R,T}

    Aktor,
    Czas trwania filmu,
    Gaża,
    Nagroda (dla Aktora, rozważane są tylko Oscary),
    Studio filmowe,
    Rok produkcji,
    Tytuł filmu.

oraz zbiór zależności funkcyjnych:
F = {{S,T} → R, {R,T} → C, {R,T} → S, {A,T} → G, {A,T} → N, {N,R,T} → A}

Która z poniższych dekompozycji jest dekompozycją bezstratną?

------------------------------

1. H1 = {A,G,N,R,T}, H2 = {C,R,S,T}

H1 ^ H2 = {R,T}

Sprawdzamy czy {R,T} → {A,G,N,R,T} ∈ F+  LUB  {R,T} → {C,R,S,T} ∈ F+

{R,T}+ → {C,R,S,T}

{R,T} → {C,R,S,T} ∈ F+

bezstratna

------------------------------

2. H1 = {A,G,N,T}, H2 = {C,R,S,T}

H1 ^ H2 = {T}

Sprawdzamy czy {T} → {A,G,N,R,T} ∈ F+  LUB  {T} → {C,R,S,T} ∈ F+

{T}+ = {T}

stratna

------------------------------

3. H1 = {A,G,N,S,T}, H2 = {C,R,S,T}

H1 ^ H2 = {S,T}

Sprawdzamy czy {S,T} → {A,G,N,R,T} ∈ F+  LUB  {S,T} → {C,R,S,T} ∈ F+

{S,T}+ = {S,T,R,C}

bezstratna

------------------------------

4. H1 = {A,G,S,T}, H2 = {A,N,R,T}, H3 = {C,S,R,T}

F = {{S,T} → R, {R,T} → C, {R,T} → S, {A,T} → G, {A,T} → N, {N,R,T} → A}

   | A | C | G | N | S | R | T
---------------------------------
H1 | v | o | v | o | v | o | v
---------------------------------
H2 | v | o | o | v | o | v | v
---------------------------------
H3 |   | v |   |   | v | v | v

bestratna

------------------------------

5. H1 = {A,G,T}, H2 = {A,N,T}, H3 = {C,S,R,T}

F = {{S,T} → R, {R,T} → C, {R,T} → S, {A,T} → G, {A,T} → N, {N,R,T} → A}

   | A | C | G | N | S | R | T
---------------------------------
H1 | v |   | v | o |   |   | v
---------------------------------
H2 | v |   | o | v |   |   | v
---------------------------------
H3 |   | v |   |   | v | v | v

stratna

------------------------------

6. H1 = {A,G,S,T}, H2 = {A,N,T}, H3 = {C,S,R,T}

F = {{S,T} → R, {R,T} → C, {R,T} → S, {A,T} → G, {A,T} → N, {N,R,T} → A}

   | A | C | G | N | S | R | T
---------------------------------
H1 | v | o | v | o | v | o | v
---------------------------------
H2 | v |   | o | v |   |   | v
---------------------------------
H3 |   | v |   |   | v | v | v

bestratna


##############################
#
# Zadanie 8.5
#
##############################

Dana jest relacja R o schemacie H = {M,P,S,T}

    Moduł zajęć,
    Prowadzący,
    Sala,
    Termin egzaminu

oraz zbiór zależności funkcyjnych F = {{S,T} → M, M → P, P → S}.

Która z poniższych dekompozycji zachowuje wszystkie zależności funkcyjne?

1. H1 = {M,S,T}, H2 = {M,P,S}

Po lewej stronie wszystkich zależności mamy tylko kombinacje maksymalnie
2-elementowe, dlatego też liczymy dopełnienia dla wszystkich możliwych
kombinacji 2-elementowych.

{M}+ = {M,P,S}
{P}+ = {P,S}
{S}+ = {S}
{T}+ = {T}
{S,T}+ = {S,T,M,P}
{M,T}+ = {M,T,P,S}
{P,S}+ = {P,S}
{M,S}+ = {M,S,P}
{M,P}+ = {M,P,S}

Π H1(F) = {M → S, {S,T} → M, {M,T} → S}
Π H1(F) = {M → S, {S,T} → M}

Π H2(F) = {M → S, M → P, P → S, {M,S} → P, {M,P} → S}
Π H2(F) = {M → S, M → P, P → S}
Π H2(F) = {M → P, P → S}

Sprawdzamy czy każdą z zależności F = {{S,T} → M, M → P, P → S} da się wyprowadzić z Π H1(f) u Π H2(f).

Możliwe jest wyprowadzenie wszystkich zależności.

Dekompozycja zachowuje zależności funkcyjne.

------------------------------

2. H1 = {M,S,T}, H2 = {P,S}

{M}+ = {M,P,S}
{P}+ = {P,S}
{S}+ = {S}
{T}+ = {T}
{S,T}+ = {S,T,M,P}
{M,T}+ = {M,T,P,S}
{P,S}+ = {P,S}
{M,S}+ = {M,S,P}
{M,P}+ = {M,P,S}

Π H1(f) = {M → S, {S,T} → M, {M,T} → S}
Π H1(F) = {M → S, {S,T} → M}

Π H2(f) = {P → S}

Sprawdzamy czy każdą z zależności F = {{S,T} → M, M → P, P → S} da się wyprowadzić z Π H1(f) u Π H2(f).

Nie da się wyprowadzić M → P.

Dekompozycja nie zachowuje zależności funkcyjnych.

------------------------------

3. H1 = {M,P,S}, H2 = {S,T}

{M}+ = {M,P,S}
{P}+ = {P,S}
{S}+ = {S}
{T}+ = {T}
{S,T}+ = {S,T,M,P}
{M,T}+ = {M,T,P,S}
{P,S}+ = {P,S}
{M,S}+ = {M,S,P}
{M,P}+ = {M,P,S}

Π H1(f) = {M → P, M → S, P → S, {M,S} → P, {M,P} → S}
Π H1(f) = {M → P, P → S}

Π H2(f) = puste

Sprawdzamy czy każdą z zależności F = {{S,T} → M, M → P, P → S} da się wyprowadzić z Π H1(f) u Π H2(f).

Nie da się wyprowadzić {S,T} → M.

Dekompozycja nie zachowuje zależności funkcyjnych.


##############################
#
# Teoria do zadań z postaci
#
##############################

Warto przeczytać:
https://pl.wikipedia.org/wiki/Postać_normalna_(bazy_danych)
https://www.geeksforgeeks.org/difference-between-2nf-and-3nf-in-dbms/

Atrybut niekluczowy to taki, który nie występuje w żadnym z kluczy relacji.

Kolejne postacie są co raz mocniejszymi ograniczeniami, a więc relacja nie może być
w wyższej postaci jeśli nie jest w niższej.

------------------------------

1NF:
Warunkiem pierwszej postaci normalnej jest to, by każdy atrybut w relacji przyjmował
tylko wartości niepodzielne. Przez wartości niepodzielne rozumiemy takie pojedyncze wartości,
jak używane w atrybutach "numer klienta" czy "nazwisko klienta".

1NF w zadaniach na przedmiocie będzie występować zawsze, żeby dało się pracować z 2NF, 3NF i BCNF.

------------------------------

2NF:
Warunkiem na drugą postać normalną jest to, aby każdy niekluczowy atrybut zależał
w pełni funkcyjnie od całego klucza, tj. nie może istnieć żadna zależność częściowa.

W zadaniach należy więc najpierw określić klucze relacji.

Przykład:
H = {A,B,C,D}
F = {{A,B} → C, C → D}

W tym przypadku zależność C → D nie łamie zasad 2NF. Lewa strona nie jest właściwym podzbiorem klucza, więc to nie jest zależność częściowa. Łatwo sprawdzić, że w zbiorze F+ w tym przypadku nie ma zależności częściowych, więc relacja jest w 2NF. Z powodu C → D nie jest w 3NF. 

------------------------------

3NF:
Relacja jest w 3NF jeśli jest w 2NF oraz dla każdej nietrywialnej zależności X → Y:
- X jest nadkluczem
LUB
- Y zawiera tylko atrybuty z kluczy

3NF nie jest osiągnięte jeśli istnieje zależność X → Y, gdzie X oraz Y są niekluczowe.

------------------------------

BCNF (3.5NF):
Relacja jest w BCNF jeśli jest w 3NF oraz dla każdej nietrywialnej zależności X → Y,
X jest nadkluczem (jego domknięcie jest zbiorem wszystkich atrybutów relacji).


##############################
#
# Zadanie 8.6
#
##############################

Dana jest relacja R o schemacie:

H = {M,P,S,T} (patrz zadanie 8.5)

oraz zbiór zależności funkcyjnych:

F = {{S,T} → M, M → P, P → S}

Zakładając, że R jest w 1NF, wyznacz w jakiej maksymalnej postaci normalnej jest relacja R.

{S,T}+ = {M,P,S,T} = H (klucz)
{M,T}+ = {M,P,S,T} = H (klucz)
{T,P}+ = {M,P,S,T} = H (klucz)

kluczowe - M,P,S,T
niekluczowe - brak

Jest w 2NF ponieważ każdy niekluczowy atrybut zależy funkcyjnie od całego klucza (wszystkie są kluczowe, a więc automatycznie 2NF).

Jest w 3NF bo wszystkie elementy F posiadają po lewej stronie nadklucze lub po prawej atrybuty z kluczy.

Nie jest w BCNF.


##############################
#
# Zadanie 8.7
#
##############################

Dana jest relacja R o schemacie:

H = {G,P,T,W}

oraz zbiór zależności funkcyjnych:

F = {{P,T} → G, P → W, {G,T} → P }

Zakładając, że R jest w 1NF, wyznacz w jakiej maksymalnej postaci normalnej jest relacja R.

{G,T}+ = {G,T,P,W} = H (klucz)
{P,T}+ = {G,T,P,W} = H (klucz)

kluczowe - GPT
niekluczowe - W

Nie jest w 2NF ponieważ nie każdy niekluczowy atrybut zależy funkcyjnie od całego klucza (P → W).
Mówiąc inaczej: w podzbiorze właściwym klucza PT jest zależność P → W.

Nie jest w 3NF bo nie wszystkie elementy F posiadają po lewej stronie nadklucze lub po prawej atrybuty z kluczy (P → W).

Wobec tego jest w 1NF.


##############################
#
# Zadanie 8.8
#
##############################

Dana jest relacja R o schemacie:

H = {C,N,O,P}

oraz zbiór zależności funkcyjnych:

F = {N → P, {N,O} → C }

1. Zakładając, że R jest w 1NF, wyznacz w jakiej maksymalnej postaci normalnej jest relacja R.
2. Sprowadź relację do 3NF.
3. Czy wszystkie relacje w wyniku dekompozycji są w BCNF?

-------------------------------------------

{N,O}+ = {N,O,P,C} = H (klucz)

kluczowe - NO
niekluczowe - PC

Nie jest w 2NF bo N → P (N nie jest kluczem, a P jest niekluczowe).

Powinnismy zastosować minimalizację F, ale w tym zadaniu nie jest
potrzebna ponieważ mamy już postać zminimalizowaną.

Dzielimy H na schematy dla każdej zależności z F. Bierzemy daną zależność i zamieniamy
strzałki na przecinki, np. {N,O} → C zostanie zamienione na {N,O,C}.

Jeżeli jeden schemat jest podzbiorem drugiego to bierzemy większy.
Dodatkowo łączymy ze sobą schematy mające ten sam klucz.

H1 = {N,P}
H2 = {N,O,C}

Przeprowadzając normalizację musimy zadbać o:
- zachowanie zależności funkcyjnych
- bezstratne złączenia

   | C | N | O | P
--------------------
H1 |   | v |   | v            dekompozycja bezstratna, jest OK
--------------------
H2 | v | v | v | o


H1 = {N,P} - klucz N                  H2 = {N,O,C} - klucz NO

{N}+ = {N,P}                          {N,O}+ = {N,O,C}
{N,P}+ = {N,P}

F1 = Π H1(F) = {N → P}                F2 = Π H2(F) = {{N,O} → C}

Sprawdzamy czy każdą z zależności F = {N → P, {N,O} → C }
da się wyprowadzić z Π H1(f) u Π H2(f).

Możliwe jest wyprowadzenie wszystkich zależności.

Dekompozycja zachowuje zależności funkcyjne - jest OK.

Są w BCNF, ponieważ każda lewa strona w zależnościach jest nadkluczem - jej domknięcie
jest zbiorem wszystkich atrybutów relacji.


##############################
#
# Zadanie 8.9
#
##############################

Sprowadź relację z zadania 8.6 do BCNF. Czy istnieje dekompozycja, która zachowuje zależności funkcyjne?

H = {M,P,S,T}

F = {{S,T} → M, M → P, P → S}

Sprowadzanie do BCNF jest dość podobne do 3NF, ale nie dzielimy schematu od razu
po wszystkich zależnościach, ale robimy podziały jeden po drugim.

Najpierw szukamy kluczy.

{S,T}+ = {M,P,S,T} = H (klucz)
{M}+ = {M,P,S}
{P}+ = {P,S}
{S}+ = {S}
{T}+ = {T}

Sprowadzanie do BCNF jest dość podobne do 3NF, ale nie dzielimy schematu od razu
po wszystkich zależnościach, ale robimy to pojedynczo.

Warunkiem BCNF jest wystepowanie po lewych stronach zaleznosci tylko nadkluczy.
W tym przypadku reguła ta jest złamana przez M → P oraz P → S.

Należy dokonać rozkładu ze względu na M → P:

H1 = {M,P}
H2 = {M,S,T} (tworzymy to przez odjęcie od pierwotnego H prawej strony zależności M → P)

F1 = Π H1(F) = {M → P}
F2 = Π H2(F) = {{S,T} → M, M → S}

Rozkładamy H2 ze względu na M → S:

H21 = {M,S}
H22 = {M,T} (od H2 odejmujemy S)

F21 = Π H21(F2) = {M → S}
F22 = Π H22(F2) = zbiór pusty

Sprawdzamy czy każdą z zależności F = {{S,T} → M, M → P, P → S}
da się wyprowadzić z Π H1(F) u Π H21(F) Π H22(F)

Niemożliwe jest wyprowadzenie {S,T} → M oraz P → S.

Dekompozycja nie zachowuje zależności funkcyjnych.

    | M | P | S | T
--------------------
H1  | v | v | o |
--------------------
H21 | v | o | v |          dekompozycja jest bezstratna,
--------------------       ale nie zachowuje zależności funkcyjnych
H32 | v | o | o | v

Aby odpowiedzieć na pytanie czy istnieje dekompozycja, która zachowuje
zależności funkcyjne, należałoby teraz przeprowadzić podział H po P → S.

##############################
#
# Zadanie 8.10
#
##############################

Dana jest relacja R o schemacie:

H = {A,B,C,D}

oraz zbiór zależności funkcyjnych:

F = { {A,B} → C, {A,C} → D }

Sprowadź relację do 3NF.

Podobnie jak w zadaniu 8.9 dzielimy H na schematy dla każdej zależności z F.

H1 = {A,B,C}
H2 = {A,C,D}

F1 = Π H1(F) = {{A,B} → C}
F2 = Π H2(F) = {{A,C} → D}

   | A | B | C | D
--------------------
H1 | v | v | v | o       dekompozycja bezstratna,
--------------------     zachowuje zależności funkcyjne
H2 | v |   | v | v


##############################
#
# Zadanie 8.11
#
##############################

Dana jest relacja R o schemacie:

H = {A,B,C,D,E}

oraz zbiór zależności funkcyjnych:

F = {{A,B} → C, {A,D} → E, C → D, E → B}.

Wyznacz wszystkie klucze relacji R.
Wyznacz co najmniej 5 nietrywialnych i prostych zależności funkcyjnych należących do F+.

{A}+ = {A}
{A,B}+ = {A,B,C,D,E} = H (klucz)
{A,C}+ = {A,C,D,E,B} = H (klucz)
{A,D}+ = {A,D,E,B,C} = H (klucz)
{A,E}+ = {A,E,B,C,D} = H (klucz)

F+ = {{A,B} → D, {A,B} → E, {A,C} → B, {A,C} → D, {A,D} → C, .....}


##############################
#
# Zadanie 8.12
#
##############################

Zadanie identyczne jak 8.4. Odpowiedzi:
1. stratna
2. stratna
3. bezstratna
4. stratna
5. stratna
6. bezstratna


##############################
#
# Zadanie 8.13
#
##############################

Dana jest relacja R o schemacie:

H = {A,B,C,D}

oraz zbiór zależności funkcyjnych:

F = { {A,B} → C, A → D, {C,D} → B }

Zakładając, że R jest w 1NF, wyznacz w jakiej maksymalnej postaci normalnej jest relacja R.

{A,B}+ = {A,B,C,D} = H (klucz)
{A,C}+ = {A,B,C,D} = H (klucz)

kluczowe - ABC
niekluczowe - D

Warunkiem na drugą postać normalną jest to, aby każdy
niekluczowy atrybut zależał funkcyjnie od całego klucza.

Ze względu na A → D, nie jest w 2NF.


##############################
#
# Zadanie 8.14
#
##############################

Dana jest relacja R o schemacie H = {A,B,C,D} oraz zbiór zależności funkcyjnych

F = { {A,B} → C, {A,D} → C }

Zakładając, że R jest w 1NF, wyznacz w jakiej maksymalnej postaci normalnej jest relacja R.

{A,B,D}+ = {A,B,C,D} = H (klucz)

kluczowe - ABD
niekluczowe - C

Warunkiem na drugą postać normalną jest to, aby każdy
niekluczowy atrybut zależał funkcyjnie od całego klucza.

W związku z tym nie jest w 2NF oraz nie jest w 3NF (patrz opisy nad zad. 8.6).
