require_relative 'bot_client_steps'

def dado_que_me_quiero_registrar
  configurar_api(:post,
                 obtener_url('/usuarios'),
                 { nombre: 'Juan', telefono: '1144449999', direccion: 'paseo colon 850', id_telegram: '141733544' }.to_json,
                 201,
                 { nombre: 'Juan', telefono: '1144449999', direccion: 'paseo colon 850' }.to_json)
end

def dado_que_me_quiero_registrar_mal(nombre, telefono, direccion)
  configurar_api(:post,
                 obtener_url('/usuarios'),
                 { nombre: nombre, telefono: telefono, direccion: direccion, id_telegram: '141733544' }.to_json,
                 400,
                 { mensaje: 'Argumentos invalidos' }.to_json)
end

def dado_que_me_quiero_registrar_sin_telefono(nombre, direccion)
  configurar_api(:post,
                 obtener_url('/usuarios'),
                 { nombre: nombre, direccion: direccion }.to_json,
                 400,
                 { mensaje: 'Argumentos invalidos' }.to_json)
end

def cuando_envio(token, mensaje)
  when_i_send_text(token, mensaje)
end

def entonces_estoy_registrado
  # todo
end

def entonces_no_estoy_registrado
  # todo
end

def y_recibo_mensaje(token, mensaje)
  then_i_get_text(token, mensaje)
end

def obtener_url(directorio)
  (ENV['API_URL']).to_s + directorio
end
