require 'spec_helper'
require 'gentle/error_message'

module Gentle
  describe ErrorMessage do
    include Fixtures

    before do
      @xml_content = load_message('error_message')
      @message = ErrorMessage.new(xml: @xml_content)
    end

    it "should be able to generate an XML document" do
      assert_equal normalize(@xml_content), normalize(@message.to_xml)
    end

    it "extracts the identifier from the error message" do
      assert_equal "H123456789", @message.identifier
    end

    it "extracts the object type from the error message" do
      assert_equal "ShipmentOrder", @message.object_type
    end

    it "returns nil for shipment number if it cannot find it" do
      message = ErrorMessage.new(xml: "<ErrorMessage ResultDescription='No shipping number'/>")

      assert_nil message.shipment_number
    end

    def normalize(content)
      content.delete("\n").squeeze(" ")
    end
  end
end
