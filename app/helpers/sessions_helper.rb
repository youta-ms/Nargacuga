module SessionsHelper
  # ログイン時にセッションIDを付与する
  def log_in(user)
    session[:user_id] = user.id
  end

  # 現在ログインしているユーザーのユーザー情報を取得する
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # ユーザーがログインしているかをチェックする
  def logged_in?
    !current_user.nil?
  end

  # ログインしてないユーザーアクセス時、ログイン画面にリダイレクト
  def require_user
    if !logged_in?
      flash[:alert] = "ログインしてください"
      redirect_to login_path
    end
  end

  # ログアウトする (セッション情報を破壊する)
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
