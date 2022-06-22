require_relative 'bot_client_steps'

def dado_que_me_quiero_registrar_como_repartidor
  configurar_api(:post,
                 obtener_url('/repartidores'),
                 { nombre: 'Juan', dni: '45571468', telefono: '1147239653', id_telegram: '141733544' }.to_json,
                 201,
                 { nombre: 'Juan', dni: '45571468 ', telefono: '1147239653', id_telegram: '141733544' }.to_json)
end

def dado_que_me_quiero_registrar_como_repartidor_con_telefono_invalido
  configurar_api(:post,
                 obtener_url('/repartidores'),
                 { nombre: 'Juan', dni: '45571468', telefono: '1147', id_telegram: '141733544' }.to_json,
                 409,
                 { nombre: 'Juan', dni: '45571468 ', telefono: '1147', id_telegram: '141733544' }.to_json)
end

def cuando_envio(token, mensaje)
  when_i_send_text(token, mensaje)
end

def entonces_estoy_registrado_como_repartidor
  # todo
end

def entonces_no_estoy_registrado_como_repartidor
  # todo
end

def y_recibo_mensaje(token, mensaje)
  then_i_get_text(token, mensaje)
end

def y_recibo_mensaje_repartidor_no_registrado(token)
  mensaje = 'Datos invalidos, ingrese un nombre valido, dni de 8 digitos, telefono de 10 digitos. Ejemplo: /registrarRepartidor Ana C, 45670123, 1234567890'
  then_i_get_text(token, mensaje)
end

def obtener_url(directorio)
  (ENV['API_URL']).to_s + directorio
end
