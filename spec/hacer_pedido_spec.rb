require 'spec_helper'
require 'web_mock'

require_relative 'bot_spec_steps/hacer_pedido_steps'

describe 'Hacer pedido de menu' do
  token = 'fake_token'

  it 'cuando pido un menu existente me responde con un codigo de pedido' do
    dado_que_quiero_pedir_un_menu
    cuando_envio(token, '/pedir 1')
    y_recibo_mensaje(token, 'Su pedido ha sido registrado: N° 1.')

    start_bot(token)
    expect(a_request(:post, "https://api.telegram.org/bot#{token}/sendMessage")).to have_been_made.at_least_once
  end
end
