class Pedido
  attr_reader :id_pedido, :estado

  def initialize(id_pedido, estado)
    @id_pedido = id_pedido
    @estado = estado
  end
end
