module PaypalService
  module DataTypes
    Endpoint = EntityUtils.define_builder([:endpoint_name, one_of: [:live, :sandbox]])
    APICredentials = EntityUtils.define_builder(
      [:username, :mandatory, :string],
      [:password, :mandatory, :string],
      [:signature, :mandatory, :string],
      [:app_id, :mandatory, :string])

    FailureResponse = EntityUtils.define_builder(
      [:success, const_value: false],
      [:error_code, :string],
      [:error_msg, :string])


    module_function

    def create_endpoint(opts); Endpoint.call(opts) end
    def create_api_credentials(opts); APICredentials.call(opts) end
    def create_failure_response(opts); FailureResponse.call(opts) end

    module Merchant
      SetupBillingAgreement = EntityUtils.define_builder(
        [:method, const_value: :setup_billing_agreement],
        [:description, :mandatory, :string],
        [:success, :mandatory, :string],
        [:cancel, :mandatory, :string])

      SetupBillingAgreementResponse = EntityUtils.define_builder(
        [:success, const_value: true],
        [:token, :mandatory, :string],
        [:redirect_url, :mandatory, :string],
        [:username_to, :mandatory, :string])

      CreateBillingAgreement = EntityUtils.define_builder(
        [:method, const_value: :create_billing_agreement],
        [:token, :mandatory, :string])

      CreateBillingAgreementResponse = EntityUtils.define_builder(
        [:success, const_value: true],
        [:billing_agreement_id, :mandatory, :string])

      DoReferenceTransaction = EntityUtils.define_builder(
        [:method, const_value: :do_reference_transaction],
        [:receiver_username, :mandatory, :string],
        [:billing_agreement_id, :mandatory, :string],
        [:order_total, :mandatory, :string], # Use . as separator, e.g. 1.15
        [:currency, :mandatory, :string])

      DoReferenceTransactionResponse = EntityUtils.define_builder(
        [:success, const_value: true],
        [:billing_agreement_id, :mandatory, :string],
        [:transaction_id, :mandatory, :string],
        [:gross_amount, :mandatory, :string],
        [:gross_currency, :mandatory, :string],
        [:fee_amount, :mandatory, :string],
        [:fee_currency, :mandatory, :string],
        [:username_to, :mandatory, :string])

      GetExpressCheckoutDetails = EntityUtils.define_builder(
        [:method, const_value: :get_express_checkout_details],
        [:token, :mandatory, :string])

      GetExpressCheckoutDetailsResponse = EntityUtils.define_builder(
        [:success, const_value: true],
        [:token, :mandatory, :string],
        [:checkout_status, :mandatory, :string],
        [:billing_agreement_accepted],
        [:payer, :string],
        [:order_total, :mandatory, :string],
        [:order_currency, :mandatory, :string]) # :bool in another branch now


      module_function

      def create_setup_billing_agreement(opts); SetupBillingAgreement.call(opts) end
      def create_setup_billing_agreement_response(opts); SetupBillingAgreementResponse.call(opts) end

      def create_create_billing_agreement(opts); CreateBillingAgreement.call(opts) end
      def create_create_billing_agreement_response(opts); CreateBillingAgreementResponse.call(opts) end

      def create_do_reference_transaction(opts); DoReferenceTransaction.call(opts) end
      def create_do_reference_transaction_response(opts); DoReferenceTransactionResponse.call(opts) end

      def create_get_express_checkout_details(opts); GetExpressCheckoutDetails.call(opts) end
      def create_get_express_checkout_details_response(opts); GetExpressCheckoutDetailsResponse.call(opts) end

    end

    module Permissions
      RequestPermissions = EntityUtils.define_builder(
        [:method, const_value: :request_permissions],
        [:scope, const_value:
          [
            "EXPRESS_CHECKOUT",
            "AUTH_CAPTURE",
            "REFUND",
            "TRANSACTION_DETAILS",
            "EXPRESS_CHECKOUT",
            "RECURRING_PAYMENTS",
            "SETTLEMENT_REPORTING",
            "RECURRING_PAYMENT_REPORT"
          ]
        ],
        [:callback, :mandatory, :string])

      RequestPermissionsResponse = EntityUtils.define_builder(
        [:success, const_value: true],
        [:username_to, :mandatory, :string],
        [:request_token, :mandatory, :string],
        [:redirect_url, :mandatory, :string])


      module_function

      def create_req_perm(opts); RequestPermissions.call(opts) end
      def create_req_perm_response(opts); RequestPermissionsResponse.call(opts) end

    end
  end
end
