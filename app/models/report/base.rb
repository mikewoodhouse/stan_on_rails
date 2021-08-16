# frozen_string_literal: true

module Report
  class Base
    attr_accessor :key, :title, :subtitle, :columns, :params, :query_filters, :sql

    class << self
      def from_spec(spec)
        new.tap do |r|
          r.key = spec.key
          r.title = spec.title
          r.subtitle = spec.subtitle
          r.columns = spec.columns
          r.query_filters = spec.query_filters
          r.sql = spec.sql
        end
      end
    end

    def execute(params = {})
      @params = params
      query_binds = query_filters.map { |qf| params[qf.desc] || qf.default }
      @rows = ActiveRecord::Base.connection.exec_query(@sql, @title, query_binds)
    end

    def to_h
      {
        'key' => @key,
        'title' => parameterize(@title),
        'subtitle' => @subtitle,
        'columns' => @columns.map(&:to_h),
        'data' => @rows.to_a,
        'params' => @params,
        'filters' => @query_filters
      }
    end

    def parameterize(template)
      regexp = /\{.+\}/
      param = template[regexp]
      return template unless param

      param_name = param.gsub(/[{}]/, '')
      template.gsub(param, @params[param_name])
    end
  end
end
