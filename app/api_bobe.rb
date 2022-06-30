require_relative 'errors/usuario_invalido.rb'
require_relative 'errors/usuario_ya_registrado.rb'
require_relative 'usuario.rb'
require_relative 'menu.rb'
require_relative 'pedido.rb'
require 'semantic_logger'
require 'byebug'

# rubocop: disable Metrics/ClassLength
class APIBobe
  def initialize
    @header = {
      'Content-Type' => 'application/json'
    }
    # TODO: Centralizar configuracion de logger en una carpeta loggers/logger_api
    # Como ya esta configurado en bot_client el logger no hace falta hacerlo de vuelta
    @logger = SemanticLogger['APIBobe']
  end

  # TODO: Refactor metodos similares (errores, get/post devolviendo objeto) de forma abstracta
  def registro_usuario(nombre, telefono, direccion, id_telegram)
    respuesta = api_registrar_usuario(direccion, id_telegram, nombre, telefono)
    raise UsuarioYaRegistrado if es_usuario_registrado(respuesta)

    raise UsuarioInvalido if error_al_registrarse(respuesta)

    devolver_usuario_registrado(respuesta)
  end

  def pedir_menus
    respuesta = api_obtener_menus
    # TODO: cambiar este StandardError por otro tipo de error
    raise StandardError if no_se_encuentran_menus(respuesta)

    devolver_menus(respuesta)
  end

  def hacer_pedido(id_usuario, id_menu)
    respuesta = api_realizar_pedido(id_menu, id_usuario)

    raise PedidoInvalido if error_al_realizar_pedido(respuesta)

    devolver_pedido(respuesta)
  end

  def consultar_pedido(id_usuario, id_pedido)
    respuesta = api_consultar_pedido(id_pedido, id_usuario)

    raise PedidoInvalido if pedido_no_encontrado(respuesta)

    raise UsuarioNoCoincide if usuario_no_coincide(respuesta)

    devolver_pedido(respuesta)
  end

  def calificar_pedido(id_pedido, id_usuario, calificacion)
    respuesta = api_calificar_pedido(id_pedido, id_usuario, calificacion)

    raise PedidoInvalido if pedido_no_encontrado(respuesta)
  end

  private

  def api_calificar_pedido(id_pedido, id_usuario, calificacion)
    url = obtener_url('/pedidosCalificados')
    parametros = { id_pedido: id_pedido, id_usuario: id_usuario, calificacion: calificacion }.to_json

    Faraday.patch(url, parametros, @header)
  end

  def pedido_no_encontrado(respuesta)
    respuesta.status == 404
  end

  def usuario_no_coincide(respuesta)
    respuesta.status == 401
  end

  def api_consultar_pedido(id_pedido, id_usuario)
    url = obtener_url('/pedidos')
    parametros = { 'id_pedido' => id_pedido, 'id_usuario' => id_usuario }

    respuesta = Faraday.get(url, parametros, @header)
    @logger.info "Consultar pedido respuesta de la API: #{respuesta.to_hash}"
    respuesta
  end

  def devolver_pedido(respuesta)
    cuerpo_respuesta = JSON.parse(respuesta.body)
    pedido_realizado = Pedido.new(cuerpo_respuesta['id_pedido'], cuerpo_respuesta['estado'])
    # Cuando se hace POST a pedidos, el body es: {id_pedido: int, id_usuario: int, id_menu: int, id_estado: int}
    # Cuando se hace GET a pedidos, el body es:  {estado: string}
    # No es consistente
    @logger.info "La API devuelve el pedido: #{pedido_realizado.id_pedido}, #{pedido_realizado.estado}"
    pedido_realizado
  end

  def error_al_realizar_pedido(respuesta)
    respuesta.status != 201
  end

  def api_realizar_pedido(id_menu, id_usuario)
    url = obtener_url('/pedidos')
    parametros = { 'id_usuario' => id_usuario, 'id_menu' => id_menu }.to_json

    respuesta = Faraday.post(url, parametros, @header)
    @logger.info "Pedido menu respuesta de la API: #{respuesta.to_hash}"
    respuesta
  end

  def devolver_menus(respuesta)
    cuerpo_respuesta = JSON.parse(respuesta.body)
    menus = []
    cuerpo_respuesta.each { |menu| menus.push(Menu.new(menu['id'], menu['descripcion'], menu['precio'])) }
    @logger.info "Se devuelven los menus #{menus}"
    menus
  end

  def no_se_encuentran_menus(respuesta)
    respuesta.status != 200
  end

  def api_obtener_menus
    url = obtener_url('/menus')
    respuesta = Faraday.get(url)
    @logger.info "Respuesta de la API al hacer /menus: #{respuesta.to_hash}"
    respuesta
  end

  def devolver_usuario_registrado(respuesta)
    cuerpo_respuesta = JSON.parse(respuesta.body)
    usuario_registrado = Usuario.new(cuerpo_respuesta['nombre'], cuerpo_respuesta['telefono'], cuerpo_respuesta['direccion'])
    @logger.info "Se registra al usuario #{usuario_registrado.nombre}, #{usuario_registrado.telefono}, #{usuario_registrado.direccion}"
    usuario_registrado
  end

  def error_al_registrarse(respuesta)
    hay_error = respuesta.status != 201
    @logger.info 'Error al registrar al usuario' if hay_error
    hay_error
  end

  def es_usuario_registrado(respuesta)
    el_usuario_esta_registrado = respuesta.status == 200
    @logger.info 'El usuario ya esta registrado' if el_usuario_esta_registrado
    el_usuario_esta_registrado
  end

  def api_registrar_usuario(direccion, id_telegram, nombre, telefono)
    url = obtener_url('/usuarios')
    parametros = { 'nombre' => nombre, 'telefono' => telefono, 'direccion' => direccion, 'id_telegram' => id_telegram }.to_json
    respuesta = Faraday.post(url, parametros, @header)
    @logger.info "Registro usuario respuesta de la API: #{respuesta.to_hash}"
    respuesta
  end

  def obtener_url(directorio)
    (ENV['API_URL']).to_s + directorio
  end
end
# rubocop: enable Metrics/ClassLength
