Kaminari.configure do |config|
    config.default_per_page = 30
    config.max_per_page     = 100
    config.window           = 0  
    config.outer_window     = 2
  end