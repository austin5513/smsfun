require "rubygems"
require "selenium-webdriver"
require "pry"

@driver = Selenium::WebDriver.for :chrome
@base_url = "http://www.smsfun.com.au/"
@driver.manage.timeouts.implicit_wait = 15
@wait = Selenium::WebDriver::Wait.new(:timeout => 30)

unless ARGV.length > 1
  puts "Usage: ruby smsfun.rb phone_number text_content"
  exit
end

text_message = []

ARGV.each {|argv| text_message << argv}
# The text content should not contain the phone number
text_message.delete_at(0) 
message_string = text_message.join(' ')

@driver.get(@base_url + "/login.php")
sleep 3
@driver.find_element(:name, "mobile").send_keys("austin5513")
@driver.find_element(:name, "pwd").send_keys("1234qwer")
@driver.find_element(:name, "submit").click
sleep 3
@driver.get(@base_url + "/send-free-sms.php")
@driver.find_element(:name, "to").send_keys(ARGV[0])
@driver.find_element(:name, "message").send_keys(message_string)
@driver.find_element(:name, "submit").click
sleep 3
@driver.find_element(:xpath, "//input[@value='Send Now']").click
@driver.quit
     

  