# frozen_string_literal: true

module Report
  class Spec
    class << self
      def from_h(h)
        new.tap do |s|
          s.key = h['key']
          s.title = h['title'] || h['key'].capitalize
          s.subtitle = h['subtitle']
          s.menu = h['menu']
          s.columns = h['columns'].map { |c| Report::Field.from_h(c) }
          s.parameters = h['parameters'] || []
          s.sql = h['sql']
        end
      end
    end

    attr_accessor :key, :title, :subtitle, :menu, :columns, :parameters, :sql

    def to_s
      "#{key}: #{title}|#{menu}|#{columns.size} cols|#{parameters}"
    end

    def menu_entry
      [key, title]
    end
  end
end
