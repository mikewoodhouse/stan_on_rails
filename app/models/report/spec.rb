# frozen_string_literal: true

module Report
  class Spec
    class << self
      def from_h(h)
        new(
          h[:key],
          h[:title] || h[:key].capitalize,
          h[:subtitle],
          h[:menu],
          h[:columns],
          h[:sql]
        )
      end
    end

    attr_reader :key, :title, :subtitle, :menu, :columns, :sql

    def initialize(key, title, subtitle, menu, columns, sql)
      @key = key
      @title = title
      @subtitle = subtitle
      @menu = menu
      puts columns
      @columns = columns.map do |c|
        Report::Field.from_h(c)
      end
      @sql = sql
    end
  end
end
