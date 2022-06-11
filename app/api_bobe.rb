class APIBobe
  def initialize
    @header = {
      'Content-Type' => 'application/json',
      'Authorization' => ENV['API_KEY']
    }
  end

  def registro_usuario(nombre, numero, direccion, _key)
    url = obtener_url('/usuarios')
    parametros = { 'nombre' => nombre, 'numero' => numero, 'direccion' => direccion }.to_json
    respuesta = post(url, 201, parametros)
    JSON.parse(respuesta.body)
  end

  private

  def obtener_url(directorio)
    "#{ENV['API_URL']}/#{directorio}"
  end

  def post(url, status_esperado, parametros = nil)
    respuesta = Faraday.post(url, parametros, @header)
    validar(respuesta, status_esperado)
  end

  def validar(respuesta, status_esperado)
    return respuesta if respuesta.status == status_esperado

    # Error de la API
    # respuesta_parseada = JSON.parse(respuesta.body)
    repuesta.status
    # raise ErrorFIUBAK, respuesta_parseada['error']
  end
end
