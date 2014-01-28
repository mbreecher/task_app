class Customer < ActiveRecord::Base
	#has_one :users
	belongs_to :user, class_name: User, foreign_key: :csm_id
	has_many :tasks, foreign_key: "customer_id"
	validates :name, presence: true, length: {maximum: 50}
	validates :start, presence: true
	validates :csm_id, presence: true
	validates_date :start
	validates_date :fiscal_ye
	validates_date :next_target
	validates_date :next_per_end

	def self.search(search)
		if search
			where 'name LIKE ?', "%#{search}%"
		else
			scoped
		end
	end
	def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |customer|
				csv << customer.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file, csm_id)
		allowed_attr = ["name", "csm_id", "start", "fiscal_ye", "next_per_end", "next_target", "single_source", "note", "xbrl_service"]
		spreadsheet = open_spreadsheet(file)
		header = spreadsheet.row(1)
		(2..spreadsheet.last_row).each do |i|
			row = Hash[[header, spreadsheet.row(i)].transpose]
			check = find_by_id(row["id"])
			if row["id"] == nil || check.csm_id == csm_id	
				customer = find_by_id(row["id"]) || new
				customer.attributes = row.to_hash.select { |k,v| allowed_attr.include? k}
				customer.csm_id = csm_id
				if customer.name != nil && customer.start != nil && customer.csm_id != nil
					customer.save
				end
			end
		end
	end
	def self.open_spreadsheet(file)
		case File.extname(file.original_filename)
			when ".csv" then Roo::Csv.new(file.path)
			#when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
			#when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
		else raise "Unknown file type: #{file.original_filename}"
		end
	end
end
