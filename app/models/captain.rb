class Captain < ActiveRecord::Base
  has_many :boats

  private

  def self.catamaran_operators
    self.joins(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    self.joins(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboaters
    self.joins(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seamen
    self.where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
  end

  def self.non_sailors
    self.where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
