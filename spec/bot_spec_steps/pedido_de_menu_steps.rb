require_relative 'bot_client_steps'

def dado_que_quiero_pedir_un_menu
  configurar_api(:post,
                 obtener_url('/pedidos'),
                 { id_menu: 1, id_usuario: 1_144_449_999 },
                 201,
                 { id: 1, id_menu: 1, id_usuario: 1_144_449_999 }.to_json)
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
