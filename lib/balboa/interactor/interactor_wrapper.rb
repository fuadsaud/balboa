# frozen_string_literal: true

module Balboa
  module Interactor
    class InteractorWrapper
      def initialize(interactor)
        @interactor = interactor
      end
      
      def punch(date)
        @interactor.punch(date)
      end

      def last
        @interactor.last
      end
    end
  end
end
