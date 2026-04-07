# TODO: Выпилить database_cleaner под корень по окончании и проверить, насколько работают механизмы Rails 5.1
# Подсказка: test.rb -> config.use_transactional_fixtures = true

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before do
    DatabaseCleaner.start
  end

  config.append_after do
    DatabaseCleaner.clean
  end
end
