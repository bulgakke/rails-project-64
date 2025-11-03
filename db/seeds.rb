%w[Music IT Movies News].each do |category_name|
  Category.find_or_create_by!(name: category_name)
end
