require_relative 'errors/usuario_invalido.rb'
require_relative 'usuario.rb'
require 'semantic_logger'

class APIBobe
  def initialize
    @header = {
      'Content-Type' => 'application/json'
    }
    # Logger para la API desde el bot
    # Todo: Centralizar logger para que no dependa de bot_client. Como ya lo inicializo no hizo falta.
    @logger = SemanticLogger['APIBobe']
  end

  def registro_usuario(nombre, telefono, direccion)
    url = obtener_url('/usuarios')
    parametros = { 'nombre' => nombre, 'telefono' => telefono, 'direccion' => direccion }.to_json
    respuesta = Faraday.post(url, parametros, @header)
    if respuesta.status != 201
      @logger.info "Error al registrar usuario: #{nombre}, #{telefono}, #{direccion} "
      raise UsuarioInvalido
    end

    cuerpo_respuesta = JSON.parse(respuesta.body)
    @logger.info "Registro de usuario exitoso: #{nombre}, #{telefono}, #{direccion} "
    Usuario.new(cuerpo_respuesta['nombre'], cuerpo_respuesta['telefono'], cuerpo_respuesta['direccion'])
  end

  private

  def obtener_url(directorio)
    (ENV['API_URL']).to_s + directorio
  end
end
