module Sudoku
  class SolutionSet
    class Process
      module Steps
        class MoveChoiceIntoIncludedSet < Step
          def take!(choice)
            include_choice(choice)
          end

          def revert!
            exclude_choice(output)
          end
        end
      end
    end
  end
end

