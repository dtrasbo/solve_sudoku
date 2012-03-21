module Sudoku
  class SolutionSet
    module Constraints
      class RowMustContainValue
        def initialize(row, value)
          @row, @value = row, value
        end

        def satisfied_by?(choice)
          choice.row == @row && choice.value == @value
        end
      end
    end
  end
end

