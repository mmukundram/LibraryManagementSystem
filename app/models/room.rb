class Room < ApplicationRecord
  attr_accessor :sizetext, :status
  validates :building, :size, presence: true
  validates :number, presence: true, numericality: {only_integer: true}, uniqueness: true

  def self.search (params)
    if params[:number].present?
      if params[:building].present?
        if params[:size].present?
          where("number = ? and building LIKE ? and size = ?", params[:number], params[:building], params[:size])
        else
          where("number = ? and building LIKE ?", params[:number], params[:building])
        end
      else
        if params[:size].present?
          where("number = ? and size = ?", params[:number], params[:size])
        else
          where("number = ?", params[:number])
        end
      end
    else
      if params[:building].present?
        if params[:size].present?
          where("building LIKE ? and size = ?", params[:building], params[:size])
        else
          where("building LIKE ?", params[:building])
        end
      else
        where("size = ?", params[:size])
      end
    end
  end
end
