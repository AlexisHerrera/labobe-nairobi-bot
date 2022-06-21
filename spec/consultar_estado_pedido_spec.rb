require 'spec_helper'
require 'web_mock'

require_relative 'bot_spec_steps/consultar_estado_pedido_steps'

describe 'Consulta estado pedido' do
  token = 123

  it 'cuando envio </consultar npedido> debería responder el estado del mismo' do
    dado_que_quiero_ver_el_estado_de_mi_pedido
    cuando_envio(token, '/consultar 1')
    y_recibo_mensaje(token, 'Pedido 1: Recibido')

    start_bot(token)
    expect(a_request(:post, "https://api.telegram.org/bot#{token}/sendMessage")).to have_been_made.at_least_once
  end

  it 'cuando envio </consultar npedido> a un pedido inexistente debe responder con un error' do
    dado_que_quiero_ver_el_estado_de_un_pedido_inexistente
    cuando_envio(token, '/consultar 9999')
    y_recibo_mensaje(token, 'No se pudo consultar el pedido. Asegurese de que el pedido exista.')

    start_bot(token)
    expect(a_request(:post, "https://api.telegram.org/bot#{token}/sendMessage")).to have_been_made.at_least_once
  end
end
