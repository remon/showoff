module ShowOff
  module Constants
    API_URL = "https://showoff-rails-react-production.herokuapp.com"
    AUTH_CREATE_URL = API_URL + "/oauth/token"
    AUTH_REVOKE_URL = API_URL + "/oauth/revoke"
    AUTH_REFRESH_URL = API_URL + "/oauth/refresh"
    AUTH_USERS_URL = API_URL + "/api/v1/users"
    AUTH_USERS_URL_CHECK = AUTH_USERS_URL + "/email"
    LOGGED_IN_USER_URL = AUTH_USERS_URL + "/me"
    USER_WIDGETS_URL = LOGGED_IN_USER_URL + "/widgets"
    WIDGETS_URL = API_URL + "/api/v1/widgets"
    WIDGETS_URL_VISIBLE = WIDGETS_URL + "/visible"
  end
end
