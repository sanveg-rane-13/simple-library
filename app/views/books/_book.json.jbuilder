json.extract! book, :id, :isbn, :title, :author, :subject, :is_special, :summary, :image_front_cover, :edition, :published, :language, :created_at, :updated_at
json.url book_url(book, format: :json)
