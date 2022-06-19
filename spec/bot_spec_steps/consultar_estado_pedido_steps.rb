require_relative 'bot_client_steps'

def dado_que_quiero_ver_el_estado_de_mi_pedido
  request = { "id_usuario": 141_733_544, "id_pedido": 1 }.to_json
  response = { "id_pedido": 1, "estado": 'Recibido' }.to_json

  configurar_api(:get,
                 obtener_url('/pedidos'),
                 request,
                 200,
                 response)
end
