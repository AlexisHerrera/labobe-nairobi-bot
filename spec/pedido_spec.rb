require 'spec_helper'
require_relative '../app/pedido.rb'

describe 'Pedido' do
  it 'debe guardar pedido' do
    id = 1
    id_pedido = 1
    id_usuario = 1_144_449_999

    pedido = Pedido.new(id, id_pedido, id_usuario)

    expect(pedido.id).to eq id
    expect(pedido.id_pedido).to eq id_pedido
    expect(pedido.id_usuario).to eq id_usuario
  end
end
