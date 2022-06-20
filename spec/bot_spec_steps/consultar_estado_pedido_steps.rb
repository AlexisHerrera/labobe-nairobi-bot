require_relative 'bot_client_steps'

def dado_que_quiero_ver_el_estado_de_mi_pedido
  response = { id_pedido: 1, estado: 'Recibido' }.to_json

  configurar_api(:get,
                 obtener_url('/pedidos') + '?id=1',
                 nil,
                 200,
                 response)
end

def cuando_envio(token, mensaje)
  when_i_send_text(token, mensaje)
end

def y_recibo_mensaje(token, mensaje)
  then_i_get_text(token, mensaje)
end
