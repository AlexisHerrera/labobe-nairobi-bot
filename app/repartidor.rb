class Repartidor
  attr_reader :nombre, :telefono, :dni

  def initialize(nombre, dni, telefono)
    @nombre = nombre
    @telefono = telefono
    @dni = dni
  end
end
