require_relative 'bot_client_steps'

def dado_que_quiero_conocer_los_menues
  configurar_api(:get,
                 obtener_url('/menus'),
                 {}.to_json,
                 200,
                 [{ id: 1, descripcion: 'Menu Individual', precio: 1000.0 },
                  { id: 2, descripcion: 'Menu Parejas', precio: 1500.0 },
                  { id: 3, descripcion: 'Menu Familiar', precio: 2500.0 }].to_json)
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
