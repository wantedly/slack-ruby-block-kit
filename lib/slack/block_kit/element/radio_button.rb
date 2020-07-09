# frozen_string_literal: true

module Slack
  module BlockKit
    module Element
      # A radio button group that allows a user to choose one item from a list of possible options.
      #
      # Radio buttons are only supported in the following app surfaces: Home tabs Modals
      #
      # https://api.slack.com/reference/block-kit/block-elements#radio
      class RadioButton
        TYPE = 'radio_buttons'

        attr_accessor :options, :confirm

        def initialize(action_id:)
          @action_id = action_id
          @options = []
          @initial_option = nil
          @confirm = nil

          yield(self) if block_given?
        end

        def option(value:, text:, emoji: nil, url: nil)
          @options << Composition::Option.new(
            value: value,
            text: text,
            emoji: emoji,
            url: url
          )

          self
        end

        def initial_option(value:, text:, emoji: nil, url: nil)
          @initial_option = Composition::Option.new(
            value: value,
            text: text,
            emoji: emoji,
            url: url
          )

          @options << @initial_option

          self
        end

        def confirmation_dialog
          @confirm = Composition::ConfirmationDialog.new

          yield(@confirm) if block_given?

          self
        end

        def as_json(*)
          {
            type: TYPE,
            action_id: @action_id,
            options: @options.map(&:as_json),
            initial_option: @initial_option&.as_json,
            confirm: @confirm&.as_json
          }.compact
        end
      end
    end
  end
end
