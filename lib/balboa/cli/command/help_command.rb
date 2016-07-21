# frozen_string_literal: true

require_relative '../../version'

module Balboa
  module CLI
    module Command
      class HelpCommand
        def execute
          $stdout.puts help 
        end

        private

        def help
          [
            "░░░░░▄▄███████████████▄▄░░░░  BALBOA #{Balboa::VERSION}",
            "░░▄██████████████████████▄░░",
            "░█████████▀███████▀████████░",
            "█████████▀▀█▀█░░▀██▄██▄████░  Usage: balboa [command] [options]",
            "░████████▄▄█░▀▀▄▄█░░▀░████░░",
            "░███████▀░░░▄▄▄▄░░░▄▄▄███░░░  Commands:",
            "▀███████░░▄▀▀██▀░░█▄░▄▀███░░    last         Fetch last punch date",
            "░██████▀░░█░██▀▀░░████░██░░░    punch        Punch up to yesterday",
            "████████░▄░░▀▀░░░░▀▄░▀▀█░░░░    help         HERBERT, COME TO MY RESCUE",
            "█▀██████▀░▄░░▄░░░░░░█░░█░░░░",
            "▀▄████▄▀░░░▀▀░░▀░▄░░▀░░░█░░░  Options:",
            "▄██████▀▄░░░░░░░░░██▄▄▄░█░░░    balboa punch -c FILE       Override config from .balboa",
            "███████░█░░░░░░░░█▀▄▄▄█░░█░░    balboa punch -p PASSWORD   Override password from .balboa",
            "░██████░░█░░░░░░░░░▀░░░░░░▀▄",
            "▀▄█████░░░▀▄░░░░░░░░░░░░░░░█  Examples:",
            "░░░███▀░░░░░░▀░░░░▄░░░░░░▄█░    balboa",
            "░░░▄▀░░░░░░░░░▀▄░░░▀▀▀▀▀█▀░░    balboa punch",
            "░▀░░░░░░░░░░░░░░░▀░░░░░░▀▄░░",
            "░░░░░░░░░░░░░░░░░░░░░░░▄░█▀▄  #{quote}"
          ].join("\n")
        end

        def quote
          "`Life's not about how hard of a hit you can give...'"
        end
      end
    end
  end
end
