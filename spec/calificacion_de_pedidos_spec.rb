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

  it 'cuando envio </calificar npedido, calificacion> a un pedido inexistente debería responder diciendo que no existe el pedido' do
    dado_que_quiero_calificar_un_pedido_inexistente
    cuando_envio(token, '/calificar 9999, 5')
    y_recibo_mensaje(token, 'No se pudo consultar el pedido. Asegurese de que el pedido exista.')

    start_bot(token)
    expect(a_request(:post, "https://api.telegram.org/bot#{token}/sendMessage")).to have_been_made.at_least_once
  end

  it 'cuando envio </calificar npedido, calificacion> con un valor que excede el rango debería responder diciendo que la calificacion es invalida' do
    dado_que_quiero_calificar_una_calificacion_invalida(10)
    cuando_envio(token, '/calificar 1, 10')
    y_recibo_mensaje(token, 'Calificación inválida. Por favor califique con un valor de 1 a 5.')

    start_bot(token)
    expect(a_request(:post, "https://api.telegram.org/bot#{token}/sendMessage")).to have_been_made.at_least_once
  end

  it 'cuando envio </calificar npedido, calificacion> con un valor inferior al rango debería responder diciendo que la calificacion es invalida' do
    dado_que_quiero_calificar_una_calificacion_invalida(0)
    cuando_envio(token, '/calificar 1, 0')
    y_recibo_mensaje(token, 'Calificación inválida. Por favor califique con un valor de 1 a 5.')

    start_bot(token)
    expect(a_request(:post, "https://api.telegram.org/bot#{token}/sendMessage")).to have_been_made.at_least_once
  end
end
