require_relative 'errors/usuario_invalido.rb'
require_relative 'errors/usuario_ya_registrado.rb'
require_relative 'usuario.rb'
require_relative 'menu.rb'
require_relative 'pedido.rb'
require 'semantic_logger'
require 'byebug'
class APIBobe
  def initialize
    @header = {
      'Content-Type' => 'application/json'
    }
    # TODO: Centralizar configuracion de logger en una carpeta loggers/logger_api
    # Como ya esta configurado en bot_client el logger no hace falta hacerlo de vuelta
    @logger = SemanticLogger['APIBobe']
  end

  def registro_usuario(nombre, telefono, direccion, id_telegram)
    respuesta = registrar_usuario(direccion, id_telegram, nombre, telefono)
    raise UsuarioYaRegistrado if es_usuario_registrado(respuesta)

    raise UsuarioInvalido if error_al_registrarse(respuesta)

    cuerpo_respuesta = JSON.parse(respuesta.body)
    Usuario.new(cuerpo_respuesta['nombre'], cuerpo_respuesta['telefono'], cuerpo_respuesta['direccion'])
  end

  def pedir_menus
    url = obtener_url('/menus')
    respuesta = Faraday.get(url)

    raise StandardError if respuesta.status != 200

    @logger.info "Respuesta de pedido de menu de la api: #{respuesta.to_hash}"

    cuerpo_respuesta = JSON.parse(respuesta.body)
    menus = []
    cuerpo_respuesta.each { |menu| menus.push(Menu.new(menu['id'], menu['descripcion'], menu['precio'])) }

    menus
  end

  def hacer_pedido(id_usuario, id_menu)
    url = obtener_url('/pedidos')
    parametros = { 'id_usuario' => id_usuario, 'id_menu' => id_menu }.to_json

    respuesta = Faraday.post(url, parametros, @header)
    @logger.info "Pedido menu respuesta de la API: #{respuesta.to_hash}"

    raise PedidoInvalido if respuesta.status != 201

    cuerpo_respuesta = JSON.parse(respuesta.body)
    Pedido.new(cuerpo_respuesta['id_pedido'], cuerpo_respuesta['estado'])
  end

  def consultar_pedido(id_usuario, id_pedido)
    url = obtener_url('/pedidos')
    parametros = { 'id_usuario' => id_usuario, 'id_pedido' => id_pedido }.to_json

    respuesta = Faraday.get(url, parametros, @header)
    @logger.info "Consultar pedido respuesta de la API: #{respuesta.to_hash}"

    raise PedidoInvalido if respuesta.status != 200

    cuerpo_respuesta = JSON.parse(respuesta.body)
    Pedido.new(cuerpo_respuesta['id_pedido'], cuerpo_respuesta['estado'])
  end

  private

  def error_al_registrarse(respuesta)
    hay_error = respuesta.status != 201
    @logger.info 'Error al registrar al usuario'
    hay_error
  end

  def es_usuario_registrado(respuesta)
    el_usuario_esta_registrado = respuesta.status == 200
    @logger.info 'El usuario ya esta registrado'
    el_usuario_esta_registrado
  end

  def registrar_usuario(direccion, id_telegram, nombre, telefono)
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
