require_relative 'bot_client_steps'

def dado_que_quiero_pedir_un_menu
  request = { "id_usuario": 141_733_544, "id_menu": 1 }.to_json
  response = { "id_pedido": 1, "id_menu": 1, "id_usuario": 715_612_264 }.to_json

  configurar_api(:post,
                 obtener_url('/pedidos'),
                 request,
                 201,
                 response)
end

def dado_que_quiero_pedir_un_menu_inexistente
  request = { "id_usuario": 141_733_544, "id_menu": 4 }.to_json
  response = { mensaje: 'Argumentos invalidos' }.to_json

  configurar_api(:post,
                 obtener_url('/pedidos'),
                 request,
                 400,
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
