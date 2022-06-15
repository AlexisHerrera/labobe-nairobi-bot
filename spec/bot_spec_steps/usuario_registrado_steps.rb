require_relative 'bot_client_steps'

# TODO: Inconsistencias mensaje de respuesta API
def dado_que_me_quiero_registrar_ya_registrado(nombre, telefono, direccion)
  configurar_api(:post,
                 obtener_url('/usuarios'),
                 { nombre: nombre, telefono: telefono, direccion: direccion, id_telegram: '141733544' }.to_json,
                 200,
                 { mensaje: 'UsuarioRegistrado' }.to_json)
end
