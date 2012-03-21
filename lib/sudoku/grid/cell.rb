module Sudoku
  class Grid
    class Cell
      attr_reader :value

      def initialize(grid, value)
        @grid, @value = grid, value
      end

      def filled?
        !(@value.nil? || @value.zero?)
      end

      def column
        @grid.column(self)
      end

      def row
        @grid.row(self)
      end
    end
  end
end

