class Profile < ActiveRecord::Base
	has_one :user
	# has_attached_file :picture
    
	has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	
    def self.image_file=(input_data)
        self.file_name = input_data.original_filename
        self.file_type = input_data.content_type.chomp
        self.size = input_data.size
        self.data = input_data.read
    end
end
