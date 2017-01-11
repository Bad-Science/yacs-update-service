require 'rest-client'

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
end
