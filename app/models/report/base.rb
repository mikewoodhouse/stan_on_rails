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
        'subtitle' => parameterize(@subtitle),
        'columns' => @columns.map(&:to_h),
        'data' => @rows.to_a,
        'params' => @params,
        'filters' => @query_filters
      }
    end

    def param_value_for(target)
      param_name = target.gsub(/[{}]/, '')
      @params[param_name] || query_filters.find{|qf| qf.desc == param_name}.default
    end

    def parameterize(template)
      regexp = /\{[^}]+\}/
      template.gsub(regexp) {|target| param_value_for(target)}
    end
  end
end
