class Api::V1::CommentsController < ApplicationController
    def index
        feature = Feature.find(params[:feature_id])
    
        if feature.nil?
          render json: { error: "No se encontró el sismo con el ID proporcionado" }, status: :not_found
          return
        end
        puts feature
        comments = feature.comments
    
        render json: comments, status: :ok
      end
      def create
        feature = Feature.find(params[:feature_id])
        body = params[:body]
    
        if body.blank?
          render json: { error: "El cuerpo del comentario no puede estar vacío" }, status: :unprocessable_entity
          return
        end
    
        comment = feature.comments.build(feature_id: feature.id ,body: body)
    
        if comment.save
          render json: comment, status: :created
        else
          render json: { error: feature.id }, status: :unprocessable_entity
        end
      end
end
