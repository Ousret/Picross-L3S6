# Preuve de Concept : Animation Sprite avec GL
$:.unshift File.expand_path(File.dirname(__FILE__) + "/../../lib")
$:.unshift File.expand_path(File.dirname(__FILE__) + "/../../ext")

require 'ray'

def path_of(res)
  File.expand_path File.join(File.dirname(__FILE__), '../../test/res', res)
end

# Initialisation d'une fenêtre avec openGL
Ray.game "L3 SPI Picross" do
  register { add_hook :quit, method(:exit!) }

  scene :sprite do
    @sprite = sprite path_of("5AQ0v03t.png")
    @sprite.sheet_size = [13, 21] # Dimention du Sprite
    # Faut trouver une moyen d'auto detecter les colonnes/lignes

    always do
      if animations.empty?
        if holding? :down
          animations << sprite_animation(:from => [0, 0], :to => [4, 0],
                                         :duration => 0.3).start(@sprite)
          animations << translation(:of => [0, 32], :duration => 0.3).start(@sprite)
        elsif holding? :left
          animations << sprite_animation(:from => [0, 1], :to => [4, 1],
                                         :duration => 0.3).start(@sprite)
          animations << translation(:of => [-32, 0], :duration => 0.3).start(@sprite)
        elsif holding? :right
          animations << sprite_animation(:from => [0, 2], :to => [4, 2],
                                         :duration => 0.3).start(@sprite)
          animations << translation(:of => [32, 0], :duration => 0.3).start(@sprite)
        elsif holding? :up
          animations << sprite_animation(:from => [0, 3], :to => [4, 3],
                                         :duration => 0.3).start(@sprite)
          animations << translation(:of => [0, -32], :duration => 0.3).start(@sprite)
        end
      end
    end

    render { |win| win.draw @sprite }
  end

  scenes << :sprite
end
