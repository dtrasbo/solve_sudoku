module Sudoku
  class SolutionSet
    class Process
      module Steps
        class PickChoiceSatisfyingConstraint < Step
          def take!(constraint)
            candidates = excluded_choices.select { |excluded_choice|
              constraint.satisfied_by?(excluded_choice)
            }

            if retry?
              candidates.slice!(0..candidates.index(output))
            end

            candidates.first
          end

          def revert!
          end
        end
      end
    end
  end
end

