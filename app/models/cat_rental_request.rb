# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string(255)      default("PENDING"), not null
#

class CatRentalRequest < ActiveRecord::Base

  validates :cat_id, :start_date, :end_date, :status, :presence => true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED),
      message: "%{value} is not a valid status" }

  validate :overlapping_approved_requests

  belongs_to :cat


  def overlapping_requests
    unless missing_information?
      cats = CatRentalRequest.where("cat_id = ?", self.cat_id)
      overlaps = cats.select do |rental|
        rental.end_date >= self.start_date || rental.start_date <= self.end_date
      end
    end
  end

  def missing_information?
    self.start_date.nil? || self.end_date.nil? || self.cat_id.nil?
  end

  def overlapping_approved_requests
    unless missing_information?
      return true if self.status == "DENIED"
      if overlapping_requests.select { |request| request.status == "APPROVED" &&
          request.id != self.id}.length > 0
        errors.add(:status, "You can't approve this request, must deny")
      end
      true
    end
  end

  def overlapping_pending_requests
    overlapping_requests.select { |request| request.status == "PENDING"}

  end

  def pending?
    self.status == "PENDING"
  end

  def approve!
    success = true
    CatRentalRequest.transaction do

      self.status = 'APPROVED'
      success = self.save
      self.overlapping_pending_requests.each do |request|
        next if request.id == self.id
         success = request.deny!
      end
    end
    success
  end

  def deny!
    self.status = "DENIED"
    self.save
  end

end
