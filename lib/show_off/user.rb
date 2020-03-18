module ShowOff
  class User
    attr_accessor :token

    def initialize(token = nil)
      @token = token
      @auth = "Bearer #{@token}"
    end

    def set_token(token)
      @token = token
      @auth = "Bearer #{@token}"
    end

    ####
    # Should return the user own profile data
    ####

    def profile
      begin
        res = RestClient.get(ShowOff::Constants::LOGGED_IN_USER_URL, { :Authorization => @auth })
        body = JSON.parse(res.body)
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body)
      end
    end

    ####
    # Should return user data based on user_id
    ####
    def show(id)
      begin
        res = RestClient.get(ShowOff::Constants::AUTH_USERS_URL + "/#{id}", { :Authorization => @auth })
        body = JSON.parse(res.body)
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body)
      end
    end

    ####
    # check email method is used to check email availability
    # return boolean (true , false)
    ####

    def check_email(email)
      params = {
        email: email,
        client_id: $client_id,
        client_secret: $client_secret,
      }

      begin
        res = RestClient.get(ShowOff::Constants::AUTH_USERS_URL_CHECK, params: params)
        body = JSON.parse(res.body)
        return body["data"]["available"]
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body)
      end
    end

    ####
    # SignUp method used to create a new user
    # return user data
    #TODO:  change it to return the user data or errors only
    ####
    def sign_up(args)
      params = args.merge(
        client_id: $client_id,
        client_secret: $client_secret,
      )

      begin
        res = RestClient.post(ShowOff::Constants::AUTH_USERS_URL, params.to_json, { content_type: :json, accept: :json })
        body = JSON.parse(res.body)
        user_data = body["data"]
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response)
      end
    end
  end
end
