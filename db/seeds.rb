forums = ['Ruby ve Ailesi', 'Programlama Genel', 'Genel Konular', 'Otomobil Kulübü', 'Tasarım Genel', 'HTML&CSS']

forums.each do |forum|
  f = Forum.new
  f.name = forum
  f.save
  puts "- #{forum} forumu oluşturuldu."
end