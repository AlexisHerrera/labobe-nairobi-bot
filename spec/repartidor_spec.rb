require 'spec_helper'
require_relative '../app/repartidor.rb'

describe 'Repartidor' do
  it 'debe guardar repartidor' do
    nombre = 'Ying Hu'
    dni = '46651489'
    telefono = '1234567890'

    repartidor = Repartidor.new(nombre, telefono, dni)

    expect(repartidor.nombre).to eq nombre
    expect(repartidor.dni).to eq dni
    expect(repartidor.telefono).to eq telefono
  end
end
