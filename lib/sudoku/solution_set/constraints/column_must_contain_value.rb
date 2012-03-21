module Sudoku
  class SolutionSet
    module Constraints
      class ColumnMustContainValue
        def initialize(column, value)
          @column, @value = column, value
        end

        def satisfied_by?(choice)
          choice.column == @column && choice.value == @value
        end
      end
    end
  end
end

