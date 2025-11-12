# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def seed
    eval File.read(Rails.root.join('db/seeds.rb').to_s) # rubocop:disable Security/Eval

    render plain: 'Seeds created'
  end
end
