module Moceansdk
  module Modules
    module Voice

      class Mccc
        def self.say(text = nil)
          ins = McccObject::Say.new

          unless text.nil?
            ins.text = text
          end

          ins
        end

        def self.play(file = nil)
          ins = McccObject::Play.new

          unless file.nil?
            ins.files = file
          end

          ins
        end

        def self.dial(to = nil)
          ins = McccObject::Dial.new

          unless to.nil?
            ins.to = to
          end

          ins
        end

        def self.collect(event_url = nil)
          ins = McccObject::Collect.new

          unless event_url.nil?
            ins.event_url = event_url
          end

          ins
        end

        def self.sleep(duration = nil)
          ins = McccObject::Sleep.new

          unless duration.nil?
            ins.duration = duration
          end

          ins
        end

        def self.record
          McccObject::Record.new
        end
      end

    end
  end
end