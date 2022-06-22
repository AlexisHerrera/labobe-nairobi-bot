class Repartidor
  attr_reader :nombre, :telefono, :dni

  def initialize(nombre, telefono, dni)
    @nombre = nombre
    @telefono = telefono
    @dni = dni
  end
end
