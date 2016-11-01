Rails.application.config.middleware.use OmniAuth::Builder do
  provider :weibo, '1219785701', 'c44819c0063b76ba735ebf3436c5bdbd',
  token_params: {redirect_uri: "http://homedawn.cx.com/user/auth/weibo/callback" }
  # provider :qq_connect, 'App Key','App Secret'
  # provider :renren, 'App Key','App Secret'
end