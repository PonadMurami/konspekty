# Tagi konspektów (`sphinx_tags`)

Ten plik jest **listą kanonicznych tagów** używanych w konspektach (`.rst`) przez dyrektywę:

```rst
.. tags:: tag1, tag2, tag3
```

## Zasady

- **Format**: małe litery, słowa łączone myślnikiem (`-`).
- **Rozdzielanie**: przecinkami (format wymagany przez `sphinx_tags`).
- **Identyfikator vs etykieta**:
  - **Identyfikator** tagu to tekst w backtickach (np. `duch-swiety`) — trzymajmy go w **ASCII** (bez polskich znaków), bo to klucz techniczny (linki/URL-e, kompatybilność narzędzi).
  - **Etykieta** (np. „Duch Święty”) jest tylko dla ludzi — może zawierać polskie znaki.
- **Oś spotkania (najważniejsze!)**: tagujemy tylko to, co jest **osią** spotkania (temat/metoda przewodnia), a nie tło.
  - Jeśli temat pojawia się „przy okazji” (np. jest modlitwa na początku, ale spotkanie nie jest o modlitwie) — **nie dodawaj** tego tagu.
  - Dla metod: dodawaj tag metody tylko wtedy, gdy jest ona **kluczowym narzędziem pracy** na spotkaniu (a nie po prostu „rozmawialiśmy”).
- **Dobór**: zwykle **3–8 tagów** na plik:
  - 1–3 tagi treści (o czym jest spotkanie)
  - 1–3 tagi metody (jak pracujemy)
  - 0–2 tagi typu/charakteru
  - (opcjonalnie) 1 tag pomocniczy
- **Nie tagujemy nazw cykli rekolekcji** (to już wynika ze struktury katalogów w `zrodla/`).

## Treści (o czym)

- `zmartwychwstanie` — Zmartwychwstanie
- `duch-swiety` — Duch Święty
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
- `wola-boza` — Wola Boża
- `decyzje` — Decyzje
- `pragnienia` — Pragnienia
- `poszukiwanie` — Poszukiwanie
- `tozsamosc` — Tożsamość
- `grzech` — Grzech
- `nawrocenie` — Nawrócenie
- `relacje` — Relacje
- `komunikacja` — Komunikacja
- `slowo-boze` — Słowo Boże
- `stary-testament` — Stary Testament
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
- `tradycje-zydowskie` — Tradycje żydowskie


## Metody aktywizujące (jak pracujemy)

- `pytania-do-dzielenia` — Pytania do dzielenia
- `dyskusja` — Dyskusja
- `mapa-mysli` — Mapa myśli
- `praca-przestrzenna` — Praca przestrzenna
- `praca-plastyczna` — Praca plastyczna
- `praca-z-tekstem` — Praca z tekstem
- `praca-z-obrazem` — Praca z obrazem
- `praca-w-grupach` — Praca w grupach
- `praca-z-definicja` — Praca z definicją
- `praca-z-symbolami` — Praca z symbolami
- `praca-z-muzyka` — Praca z muzyką

## Typ / charakter spotkania

- `formacyjne` — Formacyjne
- `ewangelizacyjne` — Ewangelizacyjne
- `integracyjne` — Integracyjne
- `warsztatowe` — Warsztatowe
- `biblijne` — Biblijne
- `modlitewne` — Modlitewne
- `mistagogiczne` — Mistagogiczne
