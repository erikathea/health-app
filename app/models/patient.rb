class Patient < ActiveRecord::Base
  belongs_to :full_name
  belongs_to :contact_detail
  has_many :lab_records, -> { order 'lab_records.date_conducted DESC' }
  has_many :physicians, through: :lab_records
  validates :ssn, uniqueness: true, presence: true, length: {is:9}
  validates :full_name, presence: true

  def name
    full_name.to_s
  end

  def convert_patient_records(data)
    LabRecord.convert_records(self, data)
    return self
  end

  def as_json(params={})
    #TODO: Improve this by using Jbuilder or ActiveModel Serializer
    super(
      only: [:ssn, :gender, :birth_date, :registration_date, :name],
      include: [
        {full_name: { except: [:created_at, :updated_at, :id] }},
        { lab_records: {
            only: [:name, :date_conducted],
            include: [
              { lab_details: {
                  only: [:name, :value, :normal_range, :unit],
                  methods: :remarks
                }
              },
              { health_facility: { only: [:name] }},
              { physician: {
                  except: [:created_at, :updated_at, :id, :full_name_id, :contact_detail_id],
                  include: [{full_name: { except: [:created_at, :updated_at, :id] }}]
                }
              }
            ]
          }
        }
    ])
  end
end
