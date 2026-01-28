import sys
import subprocess
import os

# Lista fragmentów tekstów, które chcemy ignorować w logach
IGNORE_PATTERNS = [
    "CSSVariable",
    "Ignoring CSS rule",
    "PropertyValue",
    "CSSStyleDeclaration",
    "The pseudo-class",
    "Syntax Error in Property",
    "Unknown syntax or no value"
]

def main():
    if len(sys.argv) < 4:
        print("Usage: python filter_ebook_convert.py <converter_path> <input_file> <output_file>")
        sys.exit(1)

    converter = sys.argv[1]
    input_file = sys.argv[2]
    output_file = sys.argv[3]

    # Budujemy polecenie
    cmd = [converter, input_file, output_file]

    try:
        # Uruchamiamy proces
        process = subprocess.Popen(
            cmd,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT, # Przekierowujemy stderr do stdout, żeby filtrować wszystko
            text=True,
            encoding='utf-8',
            errors='replace' # Zapobiega wywaleniu się na dziwnych znakach
        )

        # Czytamy wyjście linia po linii
        while True:
            line = process.stdout.readline()
            if not line and process.poll() is not None:
                break
            
            if line:
                # Sprawdzamy czy linia zawiera któryś z ignorowanych wzorców
                should_ignore = False
                for pattern in IGNORE_PATTERNS:
                    if pattern in line:
                        should_ignore = True
                        break
                
                # Jeśli nie ignorujemy, wypisujemy na konsolę
                if not should_ignore:
                    sys.stdout.write(line)
                    sys.stdout.flush()

        # Zwracamy kod wyjścia oryginalnego procesu
        sys.exit(process.returncode)

    except Exception as e:
        print(f"Error running filter script: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
