class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    self.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.motorboaters
    self.includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:îd) & self.motorboaters.pluck(:id))
    # self.includes(boats: :classifications).where(classifications: {name: "Sailboat", "Motorboat"})
  end

  def self.non_sailors
    self.joins(:boats).where("boat_classification.name = ? and captain_id = ?", "Sailboat", false)
  end
end
