# README

This README would normally document whatever steps are necessary to get the
application up and running.

IpUtilites concern has every method needed for IPs traceability (`app/controllers/concerns/ip_utilities.rb`)



## How to implement into the ApplicationController


```bash
class ApplicationController < ActionController::Base
  include IpUtilities

  before_action :remote_ip

  def remote_ip
    update_ips_table
  end
end

```

## What would you do differently if you had more time?
I'd research about [caching with Rails](https://guides.rubyonrails.org/caching_with_rails.html)
## What is the runtime complexity of each function?
Access to the same time to the CSV file could it be a problem
## How does your code work?
Every time the `ApplicationController` is called (i could implement a filter only to be used for APIs), the feature required, update an IPs table.

Step 1: Read the user IP through the `get_current_ip` method.

Step 2: Save the IP into the `public/ips.csv` file. First column is the IP and second column is the counter

Step 3: Order the IP by the counter field (through the `update_ips_table` method)

Step 4: Update the `public/ips.csv` file (through the `write_ips_table` method)

`top100` method list the first 100 ips sorted by the counter field

`clear` method remove every IP saved in `public/ips.csv` file. THE IDEA IS TO REMOVE THIS FILE THROUGH A CRONJOB AT 00AM

## What other approaches did you decide not to pursue?
As i mentioned before, i'd like to investigate more about caching with Rails. Probably it would help to improve this feature.

## How would you test this?
Manually. I have few experience with unit tests.