# frozen_string_literal: true

module Report
  class QueryFilter

    attr_reader :desc, :default, :display

    def initialize(hdef)
      @desc = hdef['desc']
      @default = hdef['default']
      @display = hdef.key?('display') ? hdef['display'] : true
    end
  end
end
