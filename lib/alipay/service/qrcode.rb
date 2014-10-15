require 'open-uri'
module Alipay
  module Service
    module QrCode
      MANAGE_REQUIRED_OPTIONS = %w( service partner _input_charset timestamp method )
      BIZ_DATA_REQUIRED_OPTIONS = %w( )

      def self.manage_url(options)
        options = {
          'service' => 'alipay.mobile.qrcode.manage',
          'partner' => Alipay.pid,
          '_input_charset' => 'utf-8',
          'timestamp' => Time.now.strftime('%Y-%m-%d %H:%M:%S')
        }.merge(Utils.stringify_keys(options))

        # TODO BIZ_DATA

        Alipay::Service.check_required_options(req_data_options, MANAGE_REQUIRED_OPTIONS)
      end

      def self.query_string(options)
        # TODO
      end
    end
  end
end
