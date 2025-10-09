import keyboard
import time

def main():
    x = 0
    while x < 10000:
        # Sformatowanie liczby z wiodącymi zerami do 6 cyfr
        formatted_number = "Nigga nr "+str(x)

        # Wysyłanie każdej cyfry osobno
        for digit in formatted_number:
            keyboard.send(digit)  # Wysyłanie pojedynczej cyfry jako klawisza
            time.sleep(0.001)  # Krótka pauza dla efektu

        # Naciśnięcie Enter
        keyboard.send('Enter')
        time.sleep(0.3)

        x += 1  # Inkrementacja `x`

# Dodanie opóźnienia przed startem programu
time.sleep(1)

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\nProgram zatrzymany.")