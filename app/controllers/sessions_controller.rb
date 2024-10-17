class SessionsController < ApplicationController
  def new
    # Renderiza o formulário de login
  end

  def create
    # Ação para login
    auth_service = AuthService.new
    response = auth_service.login(params[:email], params[:password])

    if response[:success]
      session[:jwt_token] = response[:token]  # Armazenar o token JWT na sessão
      flash[:notice] = "Login realizado com sucesso!"
      redirect_to tasks_path # Redireciona para a página principal
    else
      flash[:alert] = "Erro: #{response[:error]}"
      render :new
    end
  end

  def destroy
    token = session[:jwt_token] # Obtém o token da sessão
    AuthService.new.logout(token) if token.present? # Chama o logout da API
    session.delete(:jwt_token) # Remove o token JWT da sessão
    flash[:notice] = "Logout realizado com sucesso!"
    redirect_to login_path # Redireciona para a página de login
  end
  def signup
    # Renderiza o formulário de registro
  end

  def create_user
    # Ação para registro
    auth_service = AuthService.new
    response = auth_service.signup(params[:email], params[:password], params[:password_confirmation])

    if response[:success]
      flash[:notice] = "Cadastro realizado com sucesso!"
      redirect_to login_path # Redireciona para a página de login após registro
    else
      flash[:alert] = "Erro: #{response[:error]}"
      render :signup # Renderiza novamente o formulário de signup
    end
  end
end
