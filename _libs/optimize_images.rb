site = ARGV[0]

def is_png(file)
  File.extname(file) == '.png'
end
def is_jpg(file)
  File.extname(file) == '.jpg'
end

files = %x[ find . -type f | grep -v '#{site}' ].split("\n").map do |f| 
  f[2,f.length]
end

pngs = files.select{|f| is_png(f)}
jpgs = files.select{|f| is_jpg(f)}

system "optipng #{pngs.join(' ')}"

jpgs.each do |jpg|
  # using -strip will potentially change colors, so don't use
  # -interlace Plane makes it a progressive image
  system "mogrify -interlace Plane -quality 85% #{jpg}"
end