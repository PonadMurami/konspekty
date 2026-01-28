# Tagi konspektów (`sphinx_tags`)

Ten plik jest **listą kanonicznych tagów** używanych w konspektach (`.rst`) przez dyrektywę:

```rst
.. tags:: tag1, tag2, tag3
```

## Zasady

- **Format**: małe litery, słowa łączone podkreśleniem (`_`).
- **Rozdzielanie**: przecinkami (format wymagany przez `sphinx_tags`).
- **Identyfikator vs etykieta**:
  - **Identyfikator** tagu to tekst w backtickach (np. `duch_swiety`) — trzymajmy go w **ASCII** (bez polskich znaków), bo to klucz techniczny (linki/URL-e, kompatybilność narzędzi).
  - **Etykieta** (np. „Duch Święty”) jest tylko dla ludzi — może zawierać polskie znaki.
- **Oś spotkania (najważniejsze!)**: tagujemy tylko to, co jest **osią** spotkania (temat/metoda przewodnia), a nie tło.
  - Jeśli temat pojawia się „przy okazji” (np. jest modlitwa na początku, ale spotkanie nie jest o modlitwie) — **nie dodawaj** tego tagu.
  - Dla metod: dodawaj tag metody tylko wtedy, gdy jest ona **kluczowym narzędziem pracy** na spotkaniu (a nie po prostu „rozmawialiśmy”).
- **Dobór**: zwykle **3–8 tagów** na plik:
  - 1–3 tagi treści (o czym jest spotkanie)
  - 1–3 tagi metody (jak pracujemy)
  - 0–2 tagi typu/charakteru
  - (opcjonalnie) 1 tag pomocniczy typu `dla_animatora`
- **Nie tagujemy nazw cykli rekolekcji** (to już wynika ze struktury katalogów w `zrodla/`).

## Treści (o czym)

- `zmartwychwstanie` — Zmartwychwstanie
- `duch_swiety` — Duch Święty
- `kosciol` — Kościół
- `wspolnota` — Wspólnota
- `jednosc` — Jedność
- `milosc` — Miłość
- `sluzba` — Służba
- `wolnosc` — Wolność
- `odpowiedzialnosc` — Odpowiedzialność
- `powolanie` — Powołanie
- `poslanie` — Posłanie
- `rozeznawanie` — Rozeznawanie
- `wola_boza` — Wola Boża
- `decyzje` — Decyzje
- `pragnienia` — Pragnienia
- `poszukiwanie` — Poszukiwanie
- `tozsamosc` — Tożsamość
- `grzech` — Grzech
- `nawrocenie` — Nawrócenie
- `relacje` — Relacje
- `komunikacja` — Komunikacja
- `slowo_boze` — Słowo Boże
- `stary_testament` — Stary Testament
- `modlitwa` — Modlitwa
- `duchowosc` — Duchowość
- `eucharystia` — Eucharystia
- `dojrzalosc` — Dojrzałość
- `nadzieja` — Nadzieja
- `krolestwo_boze` — Królestwo Boże
- `prawda` — Prawda
- `krzyz` — Krzyż
- `czas` — Czas
- `otwartosc` — Otwartość
- `tradycje_zydowskie` — Tradycje żydowskie


## Metody aktywizujące (jak pracujemy)

- `pytania_do_dzielenia` — Pytania do dzielenia
- `dyskusja` — Dyskusja
- `mapa_mysli` — Mapa myśli
- `praca_przestrzenna` — Praca przestrzenna
- `praca_plastyczna` — Praca plastyczna
- `praca_z_tekstem` — Praca z tekstem
- `praca_z_obrazem` — Praca z obrazem
- `praca_w_grupach` — Praca w grupach
- `praca_z_definicja` — Praca z definicją
- `praca_z_symbolami` — Praca z symbolami
- `praca_z_muzyka` — Praca z muzyką

## Typ / charakter spotkania

- `formacyjne` — Formacyjne
- `ewangelizacyjne` — Ewangelizacyjne
- `integracyjne` — Integracyjne
- `warsztatowe` — Warsztatowe
- `biblijne` — Biblijne
- `modlitewne` — Modlitewne
- `mistagogiczne` — Mistagogiczne
