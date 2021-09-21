# frozen_string_literal: true

module Report
  class Spec
    class << self
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

    attr_accessor :key, :title, :subtitle, :menu, :columns, :query_filters, :sql, :index_column

    def initialize(key, repdef)
      @key = key
      @title = Spec.build_title(repdef)
      @subtitle = repdef['subtitle']
      @menu = repdef['menu']
      @index_column = repdef.fetch('index_column', true)
      @columns = Spec.build_columns(repdef['columns'])
      @query_filters = Spec.build_query_filters(repdef['query_filters'])
      @sql = repdef['sql']
    end

    def to_s
      "#{key}: #{title}|#{menu}|#{columns.size} cols|#{query_filters}"
    end

    def menu_entry
      [key, title]
    end
  end
end
