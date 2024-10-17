# app/services/auth_service.rb
require 'httparty'

class AuthService
  include HTTParty
  base_uri 'http://localhost:3000'

  def signup(email, password, password_confirmation)
    response = self.class.post('/signup', body: {
      user: {
        email: email,
        password: password,
        password_confirmation: password_confirmation
      }
    }.to_json, headers: { 'Content-Type' => 'application/json' })

    if response.code == 201 # Verifica se o cadastro foi bem-sucedido
      { success: true, user_data: response.parsed_response['data'] }
    else
      { success: false, error: response.parsed_response['status']['message'] }
    end
  end

  def login(email, password)
    response = self.class.post('/login', body: {
      user: {
        email: email,
        password: password
      }
    }.to_json, headers: { 'Content-Type' => 'application/json' })

    if response.code == 200
      jwt_token = response.headers['Authorization'].split(' ').last
      { success: true, token: jwt_token, user_data: response.parsed_response['data'] }
    else
      { success: false, error: response.parsed_response['status']['message'] }
    end
  end


  def logout(token)
    self.class.delete('/logout', headers: { 'Authorization' => "Bearer #{token}" })
  end

  def current_user(token)
    self.class.get('/current_user', headers: { 'Authorization' => "Bearer #{token}" })
  end
end
