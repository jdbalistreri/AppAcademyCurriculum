class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status,
            presence: true
  validates :status, inclusion:
            { in: %w(PENDING APPROVED DENIED),
              message: "Illegal status"}
  validate :no_overlapping_approved
  validate :cat_exists

  belongs_to :cat
  after_initialize :set_status

  def set_status
    self.status ||= "PENDING"
  end

  def overlapping_requests
    overlapping = <<-SQL, {start_date: start_date, end_date: end_date, id: id, cat_id: cat_id}
        NOT ((cat_rental_requests.start_date > :end_date)
      OR
        (cat_rental_requests.end_date < :start_date))
      AND
        cat_rental_requests.id != :id
      AND
        cat_rental_requests.cat_id = :cat_id
    SQL

    CatRentalRequest.where(overlapping)
  end

  def overlapping_approved_requests
    approved = <<-SQL
      cat_rental_requests.status = 'APPROVED'
    SQL

    overlapping_requests.where(approved)
  end

  private
    def no_overlapping_approved
      return unless status == "APPROVED"
      unless overlapping_approved_requests.empty?
        errors[:base] << "Cannot overlap with an approved request"
      end
    end

    def cat_exists
      errors[:base] << "Cat doesn't exist" unless Cat.exists?(cat_id)
    end

end
