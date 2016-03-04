# -*- coding: utf-8 -*-
$:.unshift File.expand_path(File.join(File.dirname(__FILE__), '../../ext'))
$:.unshift File.expand_path(File.join(File.dirname(__FILE__), '../../lib'))

def path_of(res)
  File.expand_path File.join(File.dirname(__FILE__), '../../test/res', res)
end

require 'ray'

Ray::Shader.use_old!

img = Ray::Image.new [100, 100]

target = Ray::ImageTarget.new
target.image = img
target.draw Ray::Polygon.rectangle([0, 0, 100, 100], Ray::Color.cyan)
target.draw Ray::Text.new("Testing image targets!", :color => Ray::Color.red)
target.update

Ray.game "test", :size => [640, 480] do
  register { add_hook :quit, method(:exit!) }

  scene :test do
    window.icon = img

    self.frames_per_second = 60

    # use deprecated-style shaders to ensure compatibility with old GPUs
    window.shader.compile(:frag => StringIO.new(<<-frag))
#version 110

uniform sampler2D in_Texture;
uniform bool in_TextureEnabled;

varying vec4 var_Color;
varying vec2 var_TexCoord;

void main() {
if (in_TextureEnabled)
gl_FragColor = texture2D(in_Texture, var_TexCoord) * var_Color;
else
gl_FragColor = var_Color;

float gray = dot(gl_FragColor.rgb, vec3(0.299, 0.587, 0.114));
gl_FragColor = vec4(gray, gray, gray, gl_FragColor.a);
}
frag

    @text = text <<eof.chomp, :size => 30, :style => [:italic, :underlined]
Ce qui se conçoit bien s'énonce clairement
Et les mots pour le dire arrivent aisément.
eof

    @poly = Ray::Polygon.rectangle @text.rect, Ray::Color.green

    @sprite = sprite path_of("sprite.png")
    @sprite.origin = @sprite.image.size / 2
    @sprite.color = Ray::Color.new(255, 255, 255, 128)

    always do
      @sprite.pos += [2, 0] if holding? :right
      @sprite.pos -= [2, 0] if holding? :left
      @sprite.pos += [0, 2] if holding? :down
      @sprite.pos -= [0, 2] if holding? :up

      @sprite.angle += 1 if holding? :'6'
      @sprite.angle -= 1 if holding? :'4'

      @sprite.scale *= [1.1, 1.1] if holding? :'8'
      @sprite.scale /= [1.1, 1.1] if holding? :'2'
    end

    on :key_press, key(:q) do
      exit!
    end

    @sprite.shader = Ray::Shader.new

    render do |win|
      win.draw @poly
      win.draw @sprite
      win.draw @text
    end
  end

  scenes << :test
end
