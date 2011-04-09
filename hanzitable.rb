#!/usr/bin/ruby
# encoding: utf-8

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'rubygems'
require 'prawn'
require 'prawn/security'
require "prawn/layout"

Prawn.debug = true

chars = IO.read("hanzi.txt").gsub(/[ \n]/, "")

p = Prawn::Document.new(:page_size => 'A0', :page_layout => :landscape)

p.font "#{Prawn::BASEDIR}/data/fonts/gkai00mp.ttf"   
p.font_size 20

p.define_grid(:columns => 50, :rows => 70, :gutter => 2)

p.grid.rows.times do |i|
  p.grid.columns.times do |j|
    b = p.grid(i,j)
    p.bounding_box b.top_left, :width => b.width, :height => b.height do
      p.text chars[i * 50 + j]
      p.stroke do
        p.rectangle(p.bounds.top_left, b.width, b.height)
      end
    end
  end
end

p.render_file("hanzi.pdf")

