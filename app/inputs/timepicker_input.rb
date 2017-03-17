class TimepickerInput < SimpleForm::Inputs::Base
  def input
    input_html_options[:type] = 'date'
    input_html_classes.unshift('selector')
    @builder.text_field(attribute_name, input_html_options)
  end
end
