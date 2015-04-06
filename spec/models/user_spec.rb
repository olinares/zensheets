require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'some_conversion_method' do
    it 'converts' do
      worksheet = JSON.parse(File.read(File.join(Rails.root, "spec/google_hash.json")))
      expected = {
        headers: ["First Name", "Last Name", "Job"

        ],
        rows: [
          {"First Name" => "oscar", "Last Name" => "linares", "Job" => "Padawan"},
          {"First Name" => "blair", "Last Name" => "anderson", "Job" => "Jedi"}

        ],
      }

      output = User.new.some_conversion_method(worksheet)
      expect(output).to eq expected
    end
  end
end
