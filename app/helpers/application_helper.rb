module ApplicationHelper
  include Pagy::Frontend

  def crud_label(key)
    case key
      when 'create'
        "<i class='bi bi-plus-square'></i>".html_safe
      when 'update'
        "<i class='bi bi-pencil-fill'></i>".html_safe
      when 'destroy'
        "<i class='bi bi-trash-fill'></i>".html_safe
    end
  end


  def model_label(model)
    case model
      when 'Hostel'
        "<i class='bi bi-building'></i>".html_safe
      when 'Room'
        "<i class='bi bi-door-open-fill'></i>".html_safe
    end
  end
end
