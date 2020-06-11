# frozen_string_literal: true

Dir['./bll/*.rb'].sort.each { |file| require file }
require_relative 'bll/modules/bll'

Dir['./dal/*.rb'].sort.each { |file| require file }
require_relative 'dal/modules/dal'

Dir['./models/*.rb'].sort.each { |file| require file }
require_relative 'models/modules/models'

Dir['./helpers/*.rb'].sort.each { |file| require file }

require_relative 'library'
