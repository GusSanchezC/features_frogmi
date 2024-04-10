class Api::V1::FeatureController < ApplicationController
    def index
        if params[:id].present?
          features = Feature.where("_id LIKE ?",params[:id] + "%")
        else
          features = Feature.all
        end
        if params[:mag_type].present?
          mag_types = params[:mag_type].split(',') # Dividir los valores por comas
          features = features.where(mag_type: mag_types) # Filtrar por los valores de mag_type
        end
        # feature = feature.where(mag_type: params[:mag_type]) if params[:mag_type].present?
        # Definir el número máximo de registros por página
        per_page = params[:per_page].to_i > 0 ? [params[:per_page].to_i, 1000].min : 1000
        #Paginar los resultados
        features_paginated = features.paginate(page: params[:page], per_page: per_page)    
        formatted_features = features_paginated.map do |feature|
          {
            id: feature.id,
            type: 'feature',
            attributes: {
              external_id: feature._id,
              magnitude: feature.mag,
              place: feature.place,
              time: feature.time.strftime('%Y-%m-%dT%H:%M:%S.%LZ'),
              tsunami: feature.tsunami,
              mag_type: feature.mag_type,
              title: feature.title,
              coordinates: {
                longitude: feature.longitude,
                latitude: feature.latitude
              }
            },
            links: {
              external_url: feature.url
            }
          }
        end
    
        # Construir el objeto de paginación
        pagination = {
          current_page: features_paginated.current_page,
          total: features_paginated.total_entries,
          per_page: features_paginated.per_page
        }
    
        # Construir el objeto de respuesta
        response = {
          data: formatted_features,
          pagination: pagination
        }
    
        render json: response
      end
end
