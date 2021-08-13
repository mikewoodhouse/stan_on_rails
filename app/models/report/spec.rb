# frozen_string_literal: true

module Report
  class Spec
    class << self
      def from_h(repdef)
        new.tap do |s|
          s.key = repdef['key']
          s.title = repdef['title'] || repdef['key'].capitalize
          s.subtitle = repdef['subtitle']
          s.menu = repdef['menu']
          s.columns = repdef['columns'].map { |coldef| Report::Field.new(coldef) }
          s.parameters = repdef['parameters'] || []
          s.sql = repdef['sql']
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
