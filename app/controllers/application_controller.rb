class ApplicationController < ActionController::Base
  include IpUtilities

  before_action :remote_ip

  def remote_ip
    starting = Time.now

    update_ips_table

    ending = Time.now

    # FOR TESTING PURPOSES
    puts "IT TAKES #{ending - starting} SECONDS"
  end
end
