app_dir = File.expand_path("../..", __FILE__)
shared_dir = "#{app_dir}/shared"
working_directory app_dir

worker_processes 2
timeout 15
preload_app true

# Set up socket location
listen "/tmp/unicorn.sock", :backlog => 64
listen(3000, backlog: 64)

# Logging
stderr_path "#{shared_dir}/log/unicorn.stderr.log"
stdout_path "#{shared_dir}/log/unicorn.stdout.log"

# Set master PID location
pid "#{shared_dir}/pids/unicorn.pid"

# Garbage collection settings.
GC.respond_to?(:copy_on_write_friendly=) &&
  GC.copy_on_write_friendly = true

# If using ActiveRecord, disconnect (from the database) before forking.
before_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!
end

# After forking, restore your ActiveRecord connection.
after_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.establish_connection
end
