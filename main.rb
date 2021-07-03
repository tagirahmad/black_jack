# frozen_string_literal: true

require_relative 'ui'

def main
  gm = GameInterface.new
  gm.ask_name
  gm.first_steps
end

main
