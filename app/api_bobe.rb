require_relative 'errors/usuario_invalido.rb'
require_relative 'usuario.rb'

class APIBobe
  def initialize
    @header = {
      'Content-Type' => 'application/json'
    }
  end

  def registro_usuario(nombre, telefono, direccion)
    url = obtener_url('/usuarios')
    parametros = { 'nombre' => nombre, 'telefono' => telefono, 'direccion' => direccion }.to_json
    respuesta = Faraday.post(url, parametros, @header)
    raise UsuarioInvalido if respuesta.status != 201

    cuerpo_respuesta = JSON.parse(respuesta.body)
    Usuario.new(cuerpo_respuesta['nombre'], cuerpo_respuesta['telefono'], cuerpo_respuesta['direccion'])
  end

  private

  def obtener_url(directorio)
    (ENV['API_URL']).to_s + directorio
  end
end
