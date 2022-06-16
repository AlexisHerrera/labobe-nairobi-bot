require 'spec_helper'
require_relative '../app/menu.rb'

describe 'Menu' do
  it 'debe guardar menu' do
    id = 1
    descripcion = 'Menu familiar'
    precio = 2500.0

    menu = Menu.new(id, descripcion, precio)

    expect(menu.id).to eq id
    expect(menu.descripcion).to eq descripcion
    expect(menu.precio).to eq precio
  end
end
