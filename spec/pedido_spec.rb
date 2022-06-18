require 'spec_helper'
require_relative '../app/pedido.rb'

describe 'Pedido' do
  it 'debe guardar pedido' do
    id_pedido = 1
    estado = 'Recibido'

    pedido = Pedido.new(id_pedido, estado)

    expect(pedido.id_pedido).to eq id_pedido
    expect(pedido.estado).to eq estado
  end
end
