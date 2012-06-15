require 'selenium-rack-driver/selenium_web_driver'
require 'nokogiri'
require 'rack/test'

module SeleniumRackDriver

  autoload :Browser, 'selenium-rack-driver/browser'
  autoload :Driver,  'selenium-rack-driver/driver'
  autoload :Element,  'selenium-rack-driver/elements/element'
  autoload :AnchorElement,  'selenium-rack-driver/elements/anchor_element'
  autoload :FormElement,  'selenium-rack-driver/elements/form_element'
  autoload :FormField,  'selenium-rack-driver/elements/form_fields/form_field'
  autoload :TextField,  'selenium-rack-driver/elements/form_fields/text_field'
  autoload :CheckboxField,  'selenium-rack-driver/elements/form_fields/checkbox_field'
  autoload :RadioField,  'selenium-rack-driver/elements/form_fields/radio_field'
  autoload :SubmitField,  'selenium-rack-driver/elements/form_fields/submit_field'
  autoload :FileField,  'selenium-rack-driver/elements/form_fields/file_field'
  autoload :TextAreaField,  'selenium-rack-driver/elements/form_fields/text_area_field'
  autoload :SelectField,  'selenium-rack-driver/elements/form_fields/select_field'
  autoload :OptionField,  'selenium-rack-driver/elements/form_fields/option_field'
  autoload :Button,  'selenium-rack-driver/elements/form_fields/button'

  class << self
    attr_accessor :app
  end

end
