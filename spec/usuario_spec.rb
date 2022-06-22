require 'spec_helper'
require_relative '../app/repartidor.rb'

describe 'Usuario' do
  it 'debe guardar usuario' do
    nombre = 'Ying Hu'
    direccion = 'Avenida Paseo Colon 850'
    telefono = '1234567890'

    usuario = Usuario.new(nombre, telefono, direccion)

    expect(usuario.nombre).to eq nombre
    expect(usuario.direccion).to eq direccion
    expect(usuario.telefono).to eq telefono
  end
end
