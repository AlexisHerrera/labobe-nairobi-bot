require 'spec_helper'
require 'web_mock'

require_relative 'bot_spec_steps/calificacion_de_pedidos_steps'

describe 'Calificacion pedido' do
  token = 123

  it 'cuando envio </calificar npedido, calificacion> debería responder diciendo que se califico el pedido' do
    dado_que_quiero_calificar_mi_pedido
    cuando_envio(token, '/calificar 1, 5')
    y_recibo_mensaje(token, 'Se ha calificado el pedido.')

    start_bot(token)
    expect(a_request(:post, "https://api.telegram.org/bot#{token}/sendMessage")).to have_been_made.at_least_once
  end
end
