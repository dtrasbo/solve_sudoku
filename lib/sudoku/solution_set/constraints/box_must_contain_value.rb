module Sudoku
  class SolutionSet
    module Constraints
      class BoxMustContainValue
        def initialize(box_x, box_y, value)
          @box_x, @box_y, @value = box_x, box_y, value
        end

        def satisfied_by?(choice)
          choice.column.between?(@box_x * 3 - 2, @box_x * 3) &&
            choice.row.between?(@box_y * 3 - 2, @box_y * 3) &&
            choice.value == @value
        end
      end
    end
  end
end

