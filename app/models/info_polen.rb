class InfoPolen

  include Mongoid::Document  

  store_in collection: "polen"  
  field :id, type: String
  field :FECHA, type: Integer
  field :ANIO, type: Integer
  field :SEMANA, type: Integer
  field :ESTACIONES, type: String
  field :TIPOS_POLINICOS, type: String
  field :PRECEDENTES, type: String
  field :PREVISION, type: String

end
