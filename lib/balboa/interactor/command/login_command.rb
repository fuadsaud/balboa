# frozen_string_literal: true

require 'capybara/dsl'

module Balboa
  module Interactor
    module Command
      class LoginCommand
        include Capybara::DSL

        def initialize(options)
          @options = options
        end

        def execute
          visit_sign_in_path

          fill_form

          confirm
        end

        private

        def visit_sign_in_path
          visit('/users/sign_in')
        end

        def fill_form
          fill_in 'E-mail', with: @options['email']
          fill_in 'Password', with: @options['password']
        end

        def confirm
          click_button 'Sign in'
        end
      end
    end
  end
end
