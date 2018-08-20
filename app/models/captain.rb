class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    self.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.talented_seafarers
    # self.includes(boats: :classifications).where(classifications: {name: "Sailboat", "Motorboat"})
  end

  def self.non_sailors
    self.joins(:classifications).where("classification.name = ? and captain_id = ?", "Sailboat", false)
  end
end
