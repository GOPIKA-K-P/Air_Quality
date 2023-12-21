#!/bin/bash

API_KEY="14025e29d0702fccbcc3c1d18df57554"

CITY_NAME="Coimbatore"
get_coordinates() {
    city_name=$1
    coordinates=$(curl -s "http://api.openweathermap.org/data/2.5/weather?q=${city_name}&appid=${API_KEY}" | jq -r '.coord | "\(.lat),\(.lon)"')
    echo "$coordinates"
}

get_air_quality() {
    lat_lon=$1
    air_quality=$(curl -s "http://api.openweathermap.org/data/2.5/air_pollution?lat=${lat_lon}&appid=${API_KEY}")
    echo "$air_quality"
}

coordinates=$(get_coordinates "$CITY_NAME")

if [ -n "$coordinates" ]; then
    air_quality_info=$(get_air_quality "$coordinates")
    aqi=$(echo "$air_quality_info" | jq -r '.list[0].main.aqi')
    echo "Air Quality Index (AQI) for $CITY_NAME: $aqi"
else
    echo "Failed to fetch coordinates for the city."
fi
