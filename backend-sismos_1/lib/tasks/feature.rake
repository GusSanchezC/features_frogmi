require 'rest_client'
require 'json'
namespace :feature do
    task :execute => :environment do
        url = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson'
        response = RestClient.get(url)
        data = JSON.parse(response.body)
         # Procesar los datos obtenidos
        features = data['features']
        # Haz lo que necesites con los datos, como guardarlos en la base de datos
        # Por ejemplo:
        features.each do |feature|
            _id = feature['id']
            mag = feature['properties']['mag'].to_f
            place = feature['properties']['place']
            time = feature['properties']['time']
            time = Time.at(time / 1000.0).to_datetime
            url = feature['properties']['url'] 
            tsunami = feature['properties']['tsunami'].to_i
            mag_type = feature['properties']['magType']
            title = feature['properties']['title']
            longitude = feature['geometry']['coordinates'][0].round(2)
            latitude = feature['geometry']['coordinates'][1].round(2)
            
            begin
                Feature.create(_id: _id, mag: mag, place: place, time: time, url: url, tsunami: tsunami, mag_type: mag_type, title: title, longitude: longitude, latitude: latitude)
                puts "Datos sísmicos obtenidos y guardados correctamente en la base de datos."
            rescue ActiveRecord::RecordNotUnique => e
                puts "El registro con ID #{_id} ya existe en la base de datos. Omitiendo..."
                next
            end
        end
    end
end
