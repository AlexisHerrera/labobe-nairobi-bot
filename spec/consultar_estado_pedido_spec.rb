require 'spec_helper'
require 'web_mock'

require_relative 'bot_spec_steps/consultar_estado_pedido_steps'

describe 'Consulta estado pedido' do
  token = 'fake_token'

  xit 'cuando envio /consultar npedido debería responder el estado del mismo' do
    dado_que_quiero_ver_el_estado_de_mi_pedido
    cuando_envio(token, '/consultar 1')
    y_recibo_mensaje(token, 'Pedido 1: Recibido')

    start_bot(token)
    expect(a_request(:post, "https://api.telegram.org/bot#{token}/sendMessage")).to have_been_made.at_least_once
  end
end
