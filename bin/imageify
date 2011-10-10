#!/usr/bin/env ruby
# (c) 25 June 2006 Andre Arko and Phil Hagelberg
# Written by pairing at 30,000 feet in the air

require 'RMagick'
include Magick

raise ArgumentError, "usage: imageify.rb <text file> <image file>" if ARGV.size != 2

class Canvas
  def initialize(text, image)
    @text = text.gsub(/\n/, ";").squeeze(" ")
    ratio = (image.columns / image.rows.to_f) * 2 # letters are not square!

    @rows = (Math::sqrt(@text.size/ratio))
    @columns = (@rows * ratio).ceil
    @rows = @rows.ceil

    @resized = image.scale(@columns, @rows)
  end

  def render
    @output = %{<html><body style="background-color: black;"><code><nobr>\n}
    @resized.get_pixels(0, 0, @columns, @rows).each_with_index do |pixel, i|
      break if @text[i].nil?
      @output << %{<span style="color: ##{pixel.to_hex};">#{@text[i].chr}</span>}
      @output << "</nobr><br /><nobr>\n" if ((i+1) % @columns == 0)
    end
    @output << "</nobr></code></body></html>"
  end
end

class ::Magick::Pixel
  def to_hex
    [:red, :green, :blue].map { |colour| "%X" % (self.send(colour) / 256) }.join ""
  end
end

puts Canvas.new(File.read(ARGV[0]), image = ImageList.new(ARGV[1])[0]).render
