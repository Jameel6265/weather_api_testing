import os
from dotenv import load_dotenv

# Load .env if running locally
load_dotenv()

# Use environment variable from Docker/Jenkins
API_KEY = os.getenv('OPENWEATHER_API_KEY')  # <-- must match your Jenkins env variable
BASE_URL = os.getenv('BASE_URL', 'https://api.openweathermap.org/data/2.5')
