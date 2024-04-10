class Feature < ApplicationRecord

    # self.primary_key = '_id' solucion para usar el id del feature como primario
    validates :mag, presence: true, numericality: { greater_than_or_equal_to: -1.0, less_than_or_equal_to: 10.0 }
    validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180.0, less_than_or_equal_to: 180.0 }
    validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90.0, less_than_or_equal_to: 90.0 }
    has_many :comments,foreign_key:"feature_id",primary_key:"id", dependent: :destroy
end
