require_relative 'bot_client_steps'

def dado_que_quiero_pedir_un_menu
  request = { "id_usuario": 141_733_544, "id_menu": 1 }.to_json
  response = { "id_pedido": 1, "id_menu": 1, "id_usuario": 715_612_264 }.to_json
  stub_request(:post, obtener_url('/pedidos')) .with(
    body: request
  ).to_return(status: 201, body: response, headers: {})
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
