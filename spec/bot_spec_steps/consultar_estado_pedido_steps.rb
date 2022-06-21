require_relative 'bot_client_steps'

def dado_que_quiero_ver_el_estado_de_mi_pedido
  # parametros = { 'id_pedido' => 1, 'id_usuario' => 141_733_544 }.to_json
  response = { id_pedido: 1, estado: 'Recibido' }.to_json

  configurar_api(:get,
                 'http://webapp:3000/pedidos?id_pedido=1&id_usuario=141733544',
                 nil,
                 200,
                 response)
end

def dado_que_quiero_ver_el_estado_de_un_pedido_inexistente
  # parametros = { 'id_pedido' => 9999, 'id_usuario' => 141_733_544 }.to_json
  response = { error: 'El pedido no existe' }.to_json

  configurar_api(:get,
                 'http://webapp:3000/pedidos?id_pedido=9999&id_usuario=141733544',
                 nil,
                 404,
                 response)
end

def cuando_envio(token, mensaje)
  when_i_send_text(token, mensaje)
end

def y_recibo_mensaje(token, mensaje)
  then_i_get_text(token, mensaje)
end

def obtener_url(directorio)
  (ENV['API_URL']).to_s + directorio
end
