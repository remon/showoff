module ShowOff
  class Widget
    attr_accessor :token

    def initialize(token = nil)
      @token = token
      @auth = "Bearer #{@token}"
      @http = ShowOff::Http
    end

    def set_token(token)
      @token = token
      @auth = "Bearer #{@token}"
    end

    def show(id)
      params = {
        client_id: $client_id,
        client_secret: $client_secret,
      }

      @http.get(ShowOff::Constants::WIDGETS_URL + "/#{id}", @auth)
    end

    def list_visible(q = "")
      params = {
        client_id: $client_id,
        client_secret: $client_secret,
        term: q,
      }
      @http.get(ShowOff::Constants::WIDGETS_URL_VISIBLE, @auth, params)
    end

    ###
    # list all logged in user widgets (access tokens are required)
    # should returns all widgets  or session is expired if access are wrong or expired
    ###
    def logged_in_user_widgets(q = "")
      params = {
        client_id: $client_id,
        client_secret: $client_secret,
        term: q,
      }
      @http.get(ShowOff::Constants::USER_WIDGETS_URL, @auth, params)
    end

    def make_widget(widget_params)
      @http.post(ShowOff::Constants::WIDGETS_URL, @auth, widget_params)
    end

    def update(id, params)
      widget_params = {
        widget: params,
      }

      @http.put(ShowOff::Constants::WIDGETS_URL + "/#{id}", @auth, widget_params)
    end

    def delete(id)
      @http.delete(ShowOff::Constants::WIDGETS_URL + "/#{id}", @auth)
    end
  end
end
