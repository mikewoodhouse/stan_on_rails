# frozen_string_literal: true

module Report
  class Spec
    class << self
      def from_h(h)
        puts "from_h: #{h.inspect}"
        new.tap do |s|
          s.key = h[:key]
          s.title = h[:title] || h[:key].capitalize
          s.subtitle = h[:subtitle]
          s.menu = h[:menu]
          s.columns = h[:columns].map do |c|
            Report::Field.from_h(c)
          end
          s.parameters = h[:parameters]
          s.sql = h[:sql]
        end
      end
    end

    attr_accessor :key, :title, :subtitle, :menu, :columns, :parameters, :sql

    def to_s
      inspect
    end

  end
end
