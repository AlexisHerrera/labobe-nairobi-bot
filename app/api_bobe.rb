class APIBobe
  def initialize
    @header = {
      'Content-Type' => 'application/json'
    }
  end

  def registro_usuario(nombre, numero, direccion)
    url = obtener_url('/usuarios')
    parametros = { 'nombre' => nombre, 'numero' => numero, 'direccion' => direccion }.to_json
    respuesta = Faraday.post(url, parametros, @header)
    JSON.parse(respuesta.body)
  end

  private

  def obtener_url(directorio)
    'https://labobe-nairobi-test.herokuapp.com' + directorio
  end
end
