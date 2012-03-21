module Sudoku
  class SolutionSet
    class Process
      module Steps
        class DeleteRedundantChoices < Step
          def take!(choice)
            satisfied_constraints = constraints.select { |constraint|
              constraint.satisfied_by?(choice)
            }

            delete_excluded_choices_if do |excluded_choice|
              satisfied_constraints.any? { |satisfied_constraint|
                satisfied_constraint.satisfied_by?(excluded_choice)
              }
            end
          end

          def revert!
            restore_excluded_choices(output)
          end
        end
      end
    end
  end
end

