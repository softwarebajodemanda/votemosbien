class MapsController < ApplicationController
  def show
    @value_x = params[:x]&.to_i || Random.new.rand(20)
    @value_y = params[:y]&.to_i || Random.new.rand(20)
    @parties = []
    Party.all.each do |party|
      if (answer = party.answer) && answer.completed?
        @parties << OpenStruct.new(
            thumb_url: helpers.thumb_url(party.logo),
            x: answer.value_x * 5,
            y: answer.value_y * 5,
            party_url: helpers.url_for(party)
          )
      end
    end

    @svg = ApplicationController.new.render_to_string partial:"maps/graph", 
          locals: {x: @value_x * 5, y: @value_y * 5, parties: @parties}

    respond_to do |format|
      format.html
      format.png do
        # file = Rails.root.join('public', 'maps', "map_#{@value_x}_#{@value_y}.png")
        # unless File.exist?(file)
        #   require "mini_magick"
        #   image = MiniMagick::Image.read @svg
        #   image.combine_options do |b|
        #     b.resize "480x480"
        #   end
        #   image.format("png", 1)
        #   image.write(file)
        # end
        # send_file file, disposition: 'inline'
      end
    end
  end
end
