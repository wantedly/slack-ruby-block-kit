# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Slack::BlockKit::Element::RadioButton do
  let(:instance) { described_class.new(**params) }
  let(:action_id) { 'my-action' }
  let(:params) { { action_id: action_id } }

  describe '#as_json' do
    subject(:as_json) { instance.as_json }

    let(:expected_json) do
      {
        type: 'radio_buttons',
        action_id: action_id,
        initial_option: {
          'text': {
            'type': 'plain_text',
            'text': 'some text'
          },
          'value': 'value-0'
        },
        options: [
          {
            'text': {
              'type': 'plain_text',
              'text': 'some text'
            },
            'value': 'value-0'
          },
          {
            'text': {
              'type': 'plain_text',
              'text': 'more text'
            },
            'value': 'value-1',
            'url': 'https://example.com'
          }
        ]
      }
    end

    it 'correctly serializes' do
      instance.initial_option(value: 'value-0', text: 'some text')
      instance.option(value: 'value-1', text: 'more text', url: 'https://example.com')
      expect(as_json).to eq(expected_json)
    end
  end
end
