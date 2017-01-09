require 'open-uri'
require 'rest-client'
require 'nokogiri'

module YacsUpdateService
  SEMESTER = '201701'
  API_URL = 'yacs/api/v5/'
  AUTH_HEADER = { Authorization: 'Token token=xyz' }

  def full_update
    courses = get_courses
    RestClient.put("#{API_URL}/courses/bulk", { courses: courses }, AUTH_HEADER)
    ids = courses.map { |c| c[:id] }
    RestClient.put("#{API_URL}/courses/active", { id: ids.join(',') }, AUTH_HEADER)
  end

  def quick_update
    sections = get_sections
    RestClient.put("#{API_URL}/sections/bulk", { sections: sections }, AUTH_HEADER)
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
