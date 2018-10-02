class Project < ActiveRecord::Base
  has_many :boxes, :dependent => :destroy
  
  validates_presence_of :name
  validates_numericality_of :number
  validates_uniqueness_of :number
  validate :start_projected_is_valid_datetime
  validate :end_projected_is_valid_datetime
  validates_numericality_of :box_count
  validates_numericality_of :size
  
  def start_projected_is_valid_datetime
    errors.add(:start_projected, 'must be a valid datetime') if ((DateTime.parse(start_projected.to_s) rescue ArgumentError) == ArgumentError)
  end

  def end_projected_is_valid_datetime
    errors.add(:end_projected, 'must be a valid datetime') if ((DateTime.parse(end_projected.to_s) rescue ArgumentError) == ArgumentError)
  end
  
end
