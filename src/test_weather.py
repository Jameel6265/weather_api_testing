import requests
from src import config

def test_get_weather_for_london():

    assert config.API_KEY is not None or config.API_KEY != '',"API_KEY must be set in the environment"

    city = "London"
    url = f'{config.BASE_URL}/weather'
    params = {
        'q':city,
        'appid':config.API_KEY,
        'units': 'metric'
    }

    response = requests.get(url, params=params)

    assert response.status_code == 200,f"Expected 200 but got {response.status_code}"

    data = response.json()
    # print(data)

    assert 'name' in data
    assert 'main' in data
    assert 'weather' in data
    assert data['name'] in data
    