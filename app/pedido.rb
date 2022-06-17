class Pedido
  attr_reader :id, :id_pedido, :id_usuario

  def initialize(id, id_pedido, id_usuario)
    @id = id
    @id_pedido = id_pedido
    @id_usuario = id_usuario
  end
end
