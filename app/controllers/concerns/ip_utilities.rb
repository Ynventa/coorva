require "csv"

module IpUtilities
  extend ActiveSupport::Concern

  def get_current_ip
    if request.remote_ip == '::1'
      # Hard coded remote address
      return "123.45.67.#{rand(10..15)}"
    else
      return request.remote_ip
    end
  end

  def read_ips_table
    # if exists, gets the ips
    filename = "#{Rails.root}/public/ips.csv"
    csv_text = ""
    if File.exist?(filename)
      csv_text = File.read(filename) 
    end

    return CSV.parse(csv_text)
  end

  def write_ips_table(ips)
    # update de CVS file
    filename = "#{Rails.root}/public/ips.csv"
    CSV.open(filename, "wb") do |csv|
      ips.each do |ip|
        csv << [ip[0], ip[1]]
      end
    end
  end

  # THE IDEA IS TO REMOVE THIS FILE THROUGH A CRONJOB AT 00AM
  def clear
    filename = "#{Rails.root}/public/ips.csv"
    File.delete(filename) if File.exist?(filename)
  end  

  def update_ips_table
    ip = get_current_ip
    ips = read_ips_table

    # update the ip counter
    if(ips.map{|v| v[0]}.include?(ip))
      ips = ips.map{|v| v[0] == ip ? [v[0], v[1].to_i+1] : v}
    else
      ips << [ip, 0]
    end

    # sort the ips by counter number. For saving, 200 is the limit. This helps to consider counting less frequent IPS
    ips = ips.sort{|a, b| b[1].to_i <=> a[1].to_i }[0..199]

    
    write_ips_table(ips)
  end

  def top100
    ips = read_ips_table
    return ips[0..99]
  end

end