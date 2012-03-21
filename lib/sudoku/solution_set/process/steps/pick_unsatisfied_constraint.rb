module Sudoku
  class SolutionSet
    class Process
      module Steps
        class PickUnsatisfiedConstraint < Step
          def take!(input=nil)
            candidates = constraints.select { |constraint|
              included_choices.none? { |included_choice|
                constraint.satisfied_by?(included_choice)
              }
            }

            if candidates.any?
              candidates.min_by { |constraint|
                excluded_choices.select { |excluded_choice|
                  constraint.satisfied_by?(excluded_choice)
                }.size
              }
            else
              :solved
            end
          end

          def revert!
          end
        end
      end
    end
  end
end

