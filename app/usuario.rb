class Usuario
  attr_reader :nombre, :telefono, :direccion

  def initialize(nombre, telefono, direccion)
    @nombre = nombre
    @telefono = telefono
    @direccion = direccion
  end
end
