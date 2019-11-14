module Moceansdk
  module Modules
    module Voice

      class Mc
        def self.say(text = nil)
          ins = McObject::Say.new

          unless text.nil?
            ins.text = text
          end

          ins
        end

        def self.play(file = nil)
          ins = McObject::Play.new

          unless file.nil?
            ins.files = file
          end

          ins
        end

        def self.dial(to = nil)
          ins = McObject::Dial.new

          unless to.nil?
            ins.to = to
          end

          ins
        end

        def self.collect(event_url = nil)
          ins = McObject::Collect.new

          unless event_url.nil?
            ins.event_url = event_url
          end

          ins
        end

        def self.sleep(duration = nil)
          ins = McObject::Sleep.new

          unless duration.nil?
            ins.duration = duration
          end

          ins
        end

        def self.record
          McObject::Record.new
        end
      end

    end
  end
end