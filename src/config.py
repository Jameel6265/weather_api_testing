import os

from dotenv import load_dotenv


load_dotenv()

API_KEY = os.getenv('API_KEY')
BASE_URL =os.getenv('BASE_URL','https://api.openweathermap.org/data/2.5')