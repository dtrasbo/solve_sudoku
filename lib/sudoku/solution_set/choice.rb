module Sudoku
  class SolutionSet
    class Choice
      attr_reader :column, :row, :value

      def initialize(column, row, value)
        @column, @row, @value = column, row, value
      end
    end
  end
end

