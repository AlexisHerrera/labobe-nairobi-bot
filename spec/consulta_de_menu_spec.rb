require 'spec_helper'
require 'web_mock'

require_relative 'bot_spec_steps/consulta_de_menu_steps'

describe 'Consulta de menu' do
  token = 'fake_token'

  it 'cuando envio /menu debería responder con los 3 menues posibles' do
    dado_que_quiero_conocer_los_menues
    cuando_envio(token, '/menus')
    y_recibo_mensaje(token, '1-Menu individual ($1000.0), 2-Menu parejas ($1500.0), 3-Menu familiar ($2500.0)')

    start_bot(token)
    expect(a_request(:post, "https://api.telegram.org/bot#{token}/sendMessage")).to have_been_made.at_least_once
  end
end
