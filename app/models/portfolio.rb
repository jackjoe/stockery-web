class Portfolio
  include MongoMapper::Document

  many :stocks 

  key :name, String, :required => true, :unique => true
  key :email, String, :required => true, :format => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validate :ensure_same_name, :on => :update
  validates_associated :stocks

  private

    def ensure_same_name
      if !name_was.nil? && name_was != name
        errors.add(:name, "You can't change the name of the portfolio")

        false
      end
    end
end
