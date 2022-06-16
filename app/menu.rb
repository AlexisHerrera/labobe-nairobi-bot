class Menu
  attr_reader :id, :descripcion, :precio

  def initialize(id, descripcion, precio)
    @id = id
    @descripcion = descripcion
    @precio = precio
  end
end
