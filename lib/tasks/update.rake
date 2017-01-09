require 'yacs-update-service'

namespace :update do
  task :quick do
    YacsUpdateService.quick_update
  end

  take :full do
    YacsUpdateService.full_update
  end
end
