module Sudoku
  class SolutionSet
    module Constraints
      class CellMustBeFilled
        def initialize(column, row)
          @column, @row = column, row
        end

        def satisfied_by?(choice)
          choice.column == @column && choice.row == @row
        end
      end
    end
  end
end

