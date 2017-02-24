module Slackistrano
  class CustomMessaging < Messaging::Base
    def icon_url
      'https://s3-us-west-2.amazonaws.com/slack-files2/avatars/2017-02-23/145415856949_68f0cdf3ce1af2fa6442_48.jpg'
    end

    def username
      'Saber'
    end

    # Suppress updating message.
    def payload_for_updating
      payload = super
      payload[:text] = "#{deployer}正在召唤Servent。"
      payload
    end

    # Suppress reverting message.
    def payload_for_reverting
      super
    end

    # Fancy updated message.
    # See https://api.slack.com/docs/message-attachments
    def payload_for_updated
      payload = super
      payload[:text] = 'Servant Saber，遵从召唤而来，我问你，你是我的Master吗?'
      payload
    end

    # Default reverted message.  Alternatively simply do not redefine this
    # method.
    def payload_for_reverted
      super
    end

    # Slightly tweaked failed message.
    # See https://api.slack.com/docs/message-formatting
    def payload_for_failed
      payload = super
      payload[:text] = "#{deployer}: 唔，忘记了时钟快了一小时了，怎么不是 Saber。"
      payload
    end

    # Override the deployer helper to pull the full name from the password file.
    # See https://github.com/phallstrom/slackistrano/blob/master/lib/slackistrano/messaging/helpers.rb
    def deployer
      "MASTER #{ENV['USER'] || ENV['USERNAME']}"
    end
  end
end
