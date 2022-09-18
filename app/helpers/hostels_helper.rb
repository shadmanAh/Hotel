module HostelsHelper
  def enrollment_button(hostel)
    link_to "Enrollment", new_hostel_enrollment_path(hostel.id), class: 'btn btn-success btn-sm'
  end
end
