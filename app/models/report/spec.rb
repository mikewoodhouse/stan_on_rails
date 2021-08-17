# frozen_string_literal: true

module Report
  class Spec
    class << self
      def from_h(repdef)
        new.tap do |s|
          s.key = repdef['key']
          s.title = build_title(repdef)
          s.subtitle = repdef['subtitle']
          s.menu = repdef['menu']
          s.columns = build_columns(repdef['columns'])
          s.query_filters = build_query_filters(repdef['query_filters'])
          s.sql = repdef['sql']
        end
      end

      def build_title(repdef)
        repdef['title'] || repdef['key'].capitalize
      end

      def build_columns(deflist)
        deflist.map { |coldef| Report::Field.new(coldef) }
      end

      def build_query_filters(filter_list)
        return [] unless filter_list

        filter_list.map { |qf| Report::QueryFilter.new(qf) }
      end
    end

    attr_accessor :key, :title, :subtitle, :menu, :columns, :query_filters, :sql

    def to_s
      "#{key}: #{title}|#{menu}|#{columns.size} cols|#{query_filters}"
    end

    def menu_entry
      [key, title]
    end
  end
end
