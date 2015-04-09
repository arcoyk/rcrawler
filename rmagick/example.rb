require 'RMagick'

img = Magick::ImageList.new("sample.png")
new_img = img.blur_image(20, 20)
new_img.write("blur.png")