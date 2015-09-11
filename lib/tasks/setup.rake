namespace :setup do
  desc 'load initial data'
  task bootstrap: :environment do
    FullName.create(first_name:'Juan', middle_name:'Amorsolo', last_name: 'de la Cruz')
    FullName.create(first_name:'Juan', middle_name:'Luna', last_name: 'de la Cruz')
    FullName.create(first_name:'Juanito', middle_name:'Amorsolo', last_name: 'de la Cruz')
    FullName.create(first_name:'John', middle_name:'Luna', last_name: 'de la Cruz')
    FullName.create(first_name:'Johnny', middle_name:'Amorsolo', last_name: 'de la Cruz')
    FullName.create(first_name:'Pedro', middle_name:'Poe', last_name: 'Penduko')
    FullName.create(first_name:'Pedro', middle_name:'Poe', last_name: 'Penduko', suffix: 'Jr')
    FullName.create(first_name:'Pedro', middle_name:'Poe', last_name: 'Penduko', suffix: 'Sr')
    FullName.create(first_name:'Pedro', middle_name:'Poe', last_name: 'Penduko', suffix: 'I')
    FullName.create(first_name:'Pedro', middle_name:'Poe', last_name: 'Penduko', suffix: 'II')

    health_facility_contact_detail = ContactDetail.new(address:'Manila City, Philippines', landline: '021234567', fax: '+63 (2) 123 4567')
    health_facility = HealthFacility.create(name: 'Manila Health Facility', contact_detail: health_facility_contact_detail)

    doctor_name = FullName.create(first_name:'Jose', middle_name:'Protasio', last_name: 'Rizal', prefix: 'Dr')
    doctor_contact_detail = ContactDetail.new(address:'Cebu City, Philippines', landline: '021234567', fax: '+63 (2) 123 4567')
    physician = Physician.create(full_name: doctor_name, contact_detail: doctor_contact_detail)

    (0...10).each do |i|
      Patient.create(
        full_name: FullName.find(i+1),
        ssn: "12345678#{i}",
        registration_date: Date.today,
        gender: false, #male
        birth_date: Date.today - (i).years - (i).months
      )
    end

    Patient.all.each do |patient|
      lab_record = LabRecord.create(
        patient: patient,
        health_facility: health_facility,
        physician: physician,
        name: 'Lab Test',
        date_conducted: Date.today
      )

      LabDetail.create(
        lab_record: lab_record,
        name: 'Colour',
        value: 'Pale Yellow'
      )

      LabDetail.create(
        lab_record: lab_record,
        name: 'Appearance',
        value: 'Clear'
      )

      LabDetail.create(
        lab_record: lab_record,
        name: 'Specific Gravity',
        value: '1.016',
        normal_range: '1.010-1.030'
      )

      LabDetail.create(
        lab_record: lab_record,
        name: 'pH',
        value: '9.0',
        normal_range: '4.8-7.4'
      )

      LabDetail.create(
        lab_record: lab_record,
        name: 'White Blood Cell Count',
        value: '25',
        unit: '/uL',
        normal_range: "< 20"
      )
    end

  end

end
