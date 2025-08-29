import requests
import sys
import re

url = "https://uselessfacts.jsph.pl/random.json?language=en"

try:
    response = requests.get(url, timeout=3)
    data = response.json()
    fact = data.get("text", "No fact returned")

    # Bersihkan karakter non-ASCII & batasi panjang
    fact = re.sub(r'[^\x20-\x7E]', '', fact)[:200]

    # Tulis output dengan newline eksplisit dan flush stdout
    sys.stdout.write(f'Reply-Message := "Fact: {fact}"\n')
    sys.stdout.write('Auth-Type := Accept\n')
    sys.stdout.flush()

except Exception as e:
    sys.stdout.write(f'Reply-Message := "API error: {e}"\n')
    sys.stdout.write('Auth-Type := Reject\n')
    sys.stdout.flush()