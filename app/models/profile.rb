class Profile < ActiveRecord::Base
	has_one :user, :dependent => :destroy
	# has_attached_file :picture
    
    def self.image_file=(input_data)
        self.file_name = input_data.original_filename
        self.file_type = input_data.content_type.chomp
        self.size = input_data.size
        self.data = input_data.read
    end
end
