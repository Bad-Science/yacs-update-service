require 'rest-client'

module YacsUpdateService
  SEMESTER = '201701'
  API_URL = 'yacs/api/v5/'

  def full_update
    
  end

  def quick_update
    sections = get_sections
    RestClient.put("#{API_URL}/sections/bulk_update")
  end

  private

  def get_sections
    uri = "https://sis.rpi.edu/reg/rocs/YACS_#{SEMESTER}.xml"
    sections = Nokogiri::XML(open(uri)).xpath("//CourseDB/SECTION")
    sections.map do |xml|
      section = xml.to_h.select!{|s| %w(crn num students seats).include?(s)}
      section.map{|k, v| [k == 'students' ? 'seats_taken' : k, v]}.to_h
    end
  end

  def get_courses
    
  end
end