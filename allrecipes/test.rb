require 'RMagick'
include Magick

image = ImageList.new("test.png")
image2 = Image.new(image.columns, image.rows)

(0..image.columns).each do |x|
    (0..image.rows).each do |y|
        pixel = image3.pixel_color(x, y)
        pixel.blue = 0
	    image2.pixel_color(x, y, pixel)
    end
end