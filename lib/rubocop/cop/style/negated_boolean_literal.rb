# frozen_string_literal: true

module RuboCop
  module Cop
    module Style
      # Checks for uses of negated boolean literals, changing them to their
      # simpler semantic equivalent.
      #
      # @example
      #   # bad
      #   !false
      #   not false
      #
      #   !true
      #   not true
      #
      #   # good
      #   true
      #   true
      #
      #   false
      #   false
      class NegatedBooleanLiteral < Base
        extend AutoCorrector

        MSG = 'Avoid the use of inverted boolean literals'
        RESTRICT_ON_SEND = %i[!].freeze

        # @!method negated_boolean_literal?(node)
        def_node_matcher :negated_boolean_literal?, '(send (${true false}) :!)'

        def on_send(node)
          return unless negated_boolean_literal?(node)
          add_offense(node) do |corrector|
            corrector.replace(
              # Here we flip !true->false and !false->true
              node,
              (expression == :false).to_s,
            )
          end
        end
      end
    end
  end
end
