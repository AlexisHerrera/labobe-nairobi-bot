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

  # rubocop:disable Metrics/AbcSize
  def registro_usuario(nombre, telefono, direccion, id_telegram)
    url = obtener_url('/usuarios')
    parametros = { 'nombre' => nombre, 'telefono' => telefono, 'direccion' => direccion, 'id_telegram' => id_telegram }.to_json
    respuesta = Faraday.post(url, parametros, @header)
    @logger.info "Registro usuario respuesta de la API: #{respuesta.to_hash}"
    raise UsuarioYaRegistrado if respuesta.status == 200

    raise UsuarioInvalido if respuesta.status != 201

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
    Pedido.new(cuerpo_respuesta['id_pedido'], cuerpo_respuesta['id_usuario'], cuerpo_respuesta['id_menu'])
  end
  # rubocop:enable Metrics/AbcSize

  private

  def obtener_url(directorio)
    (ENV['API_URL']).to_s + directorio
  end
end
