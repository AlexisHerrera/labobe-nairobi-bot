require_relative 'bot_client_steps'

def dado_que_quiero_calificar_mi_pedido
  request = { id_pedido: 1, id_usuario: '141733544', calificacion: 5 }.to_json

  configurar_api(:patch,
                 'http://webapp:3000/pedidosCalificados',
                 request,
                 200,
                 nil)
end

def dado_que_quiero_calificar_un_pedido_inexistente
  request = { id_pedido: 9999, id_usuario: '141733544', calificacion: 5 }.to_json
  response = { error: 'calificacion pedido' }.to_json

  configurar_api(:patch,
                 'http://webapp:3000/pedidosCalificados',
                 request,
                 404,
                 response)
end

def dado_que_quiero_calificar_una_calificacion_invalida(calificacion)
  request = { id_pedido: 1, id_usuario: '141733544', calificacion: calificacion }.to_json
  response = { error: 'calificacion pedido' }.to_json

  configurar_api(:patch,
                 'http://webapp:3000/pedidosCalificados',
                 request,
                 400,
                 response)
end

def dado_que_quiero_calificar_un_pedido_no_entregado
  request = { id_pedido: 1, id_usuario: '141733544', calificacion: 5 }.to_json
  response = { error: 'calificacion pedido' }.to_json

  configurar_api(:patch,
                 'http://webapp:3000/pedidosCalificados',
                 request,
                 403,
                 response)
end

def dado_que_quiero_calificar_un_pedido_de_otro
  request = { id_pedido: 1, id_usuario: '141733544', calificacion: 5 }.to_json
  response = { error: 'calificacion pedido' }.to_json

  configurar_api(:patch,
                 'http://webapp:3000/pedidosCalificados',
                 request,
                 409,
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
