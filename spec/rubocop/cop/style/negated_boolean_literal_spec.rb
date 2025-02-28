# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Style::NegatedBooleanLiteral, :config do
  it 'registers offense when using !true' do
    expect_offense(<<~RUBY)
      !true
      ^^^^^ Avoid the use of inverted boolean literals
      not true
      ^^^^^^^^ Avoid the use of inverted boolean literals
    RUBY

    expect_correction(<<~RUBY)
      false
      false
    RUBY
  end

  it 'registers offense when using !false' do
    expect_offense(<<~RUBY)
      !false
      ^^^^^^ Avoid the use of inverted boolean literals
      not false
      ^^^^^^^^^ Avoid the use of inverted boolean literals
    RUBY

    expect_correction(<<~RUBY)
      true
      true
    RUBY
  end
end
