# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"
require "base64"

class LogStash::Filters::SplitEventTest < LogStash::Filters::Base

  config_name "splitEvent"
  milestone 2

  config :field, :validate => :string, :default => "message"

  public
  def register

  end

  def filter(event)
    return unless filter?(event)

    original_value = event[@field]
    #uts original_value
    if original_value.to_s.empty?
        #puts "No Such Field or No Data!!"
        return
    else
        #event.remove("NewField")
        event_new = LogStash::Event.new()

        event_new["info"] = original_value
        #event_new["myField"]="JustChecking"
        if @field == "Request"
                event_new["type"] = "Request"
        elsif @field == "Response"
                event_new["type"] = "Response"
        end
        #TODO Validate
        event_new["Id"] = event["Id"]
        #event_new.remove("NewField")
        #event_new["NewField"] = 1
        #event_new["message"].update(event["ReqRes"])
        #puts event_new["message"]
        yield event_new
        #event.remove("NewField")
    end
  end
end
