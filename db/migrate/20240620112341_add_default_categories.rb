class AddDefaultCategories < ActiveRecord::Migration[7.1]
  def up
    categories = ['3D', 'Education', 'Audio', 'Design', 'Drawing & Painting', 'Photography', 'Gaming', 'Fitness & Health', 'Software development']
    categories.each do |category|
      Category.create(name: category)
    end
  end

  def down
    Category.delete_all
  end
end
