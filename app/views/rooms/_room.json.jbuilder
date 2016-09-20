json.extract! room, :id, :number, :building, :size, :created_at, :updated_at
json.url room_url(room, format: :json)