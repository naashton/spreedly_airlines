require 'net/http'
require 'json'
# Importing rails to grab credentials needed to make requests to Spreedly
require 'rails'

class Spreedly < Rails::Application
    BASE_URL = 'https://core.spreedly.com/v1/'
    ENV_KEY = Rails.application.credentials.spreedly[:environment_key]
    APP_SECRET = Rails.application.credentials.spreedly[:access_secret]

    # Create a Spreedly gateway
    def create_test_gateway
        body  = {
            "gateway" => {
                "gateway_type" => "test"
            }
        }

        resp = build_request('post', 'gateways.json', {'body' => body})

        puts resp.code
        puts resp.body
    end

    # Get list of created gateways
    def get_created_gateways
        resp = build_request('get', 'gateways.json')

        r_body = JSON.parse(resp.body)
        gateway_token = r_body['gateways'][0]['token']
    end

    # Create a payment method
    def create_payment_method(payment_details)
        gateway_token = self.get_created_gateways
        body = {
            "payment_method" => {
                "credit_card" => {
                    "first_name" => payment_details[:first_name],
                    "last_name" => payment_details[:last_name],
                    "number" => payment_details[:credit_card],
                    "verification_value" => payment_details[:security_code],
                    "month" => payment_details[:expiration_month],
                    "year" => payment_details[:expiration_year],
                }
            }
        }

        resp = build_request('post', "payment_methods.json", {'body' => body})
        # body = JSON.parse(resp.body)
    end

    # Execute a purchase with an existing token
    # @todo: This is essentially the same call as the create payment method with a different body
    def create_purchase_transaction(payment_details)
        gateway_token = self.get_created_gateways

        # Note: Cannot perform type coercion
        amount = payment_details[:amount].to_i
        body = {
            "transaction" => {
                "credit_card" => {
                    "first_name" => payment_details[:first_name],
                    "last_name" => payment_details[:last_name],
                    "number" => payment_details[:credit_card],
                    "verification_value" => payment_details[:security_code],
                    "month" => payment_details[:expiration_month],
                    "year" => payment_details[:expiration_year],
                },
                "amount" => amount,
                "currency_code" => "USD"
            }
        }

        resp = build_request('post', "gateways/#{gateway_token}/purchase.json", {'body' => body})
    end

    # Execute a purchase through the receiver
    def payment_method_distribution(receiver_token, pm_token, amount)
        body = {
            "delivery" => {
                "payment_method_token" => pm_token,
                "url" => "https://spreedly-echo.herokuapp.com",
                "headers" => "Content-Type: application/json",
                "body" => {
                    "amount" => amount,
                    "card_number" => "{{credit_card_number}}"
                }
            }
        }
        resp = build_request('post', "receivers/#{receiver_token}/deliver.json", {'body' => body})
    end

    # Create a receiver for PMD transactions
    def create_receiver
        body = {
            "receiver" => {
                "receiver_type" => "test",
                "hostnames" => "https://spreedly-echo.herokuapp.com",
                "credentials" => [
                    {
                        "name" => "app-id",
                        "value" => 1234,
                        "safe" => true
                    },
                    {
                        "name" => "app-secret",
                        "value" => 5678
                    }
                ]
            }
        }
        resp = build_request('post', "receivers.json", {'body' => body})
        puts resp.body
    end

    # Retrieve the gateway token
    # Note: Multiple gateways are allowed, so a bit more finesse would be appropriate
    def get_receiver_token
        resp = build_request('get', 'receivers.json')
        body = JSON.parse(resp.body)
        token = body['receivers'][0]['token']
    end

    # Verify that the card is valid
    def verify_payment_method(pm_token)
        gateway_token = self.get_created_gateways
        body = {
            "transaction" => {
                "payment_method_token" => pm_token,
            }
        }
        resp = build_request('post', "gateways/#{gateway_token}/verify.json", {"body" => body})
    end

    private
        # build_request method
        # @param string method - http method for the request
        # @param string endpoint - url endpoint for the api
        # @param [mixed] **args - body, header arguments to be passed with the request
        def build_request(method, endpoint, args={})
            uri = URI(BASE_URL + endpoint)
            if method == 'post'
                req = Net::HTTP::Post.new(uri)
            elsif method == 'get'
                req = Net::HTTP::Get.new(uri)
            else
                puts "Error"
            end

            # req.basic_auth(@env_key, @app_secret)
            req.basic_auth(ENV_KEY, APP_SECRET)

            if args.key?("body")
                req.body = args['body'].to_json
            end

            if args.key?("headers")
                puts args['headers']
            end

            req['Content-Type'] = 'application/json'
            http = Net::HTTP.new(uri.host, uri.port)
            http.use_ssl = true
    
            begin
                resp = http.request(req)
            rescue Net::HTTPBadResponse => e
                # Capture error
            end

            return resp
        end
end


# env_key = Rails.application.credentials.spreedly[:environment_key]
# secret_key = Rails.application.credentials.spreedly[:access_secret]
# s = Spreedly.new
# s.create_payment_method
# s.get_created_gateways

# s.create_test_gateway
# s.get_receiver_token
