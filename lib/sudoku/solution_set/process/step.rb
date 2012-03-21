module Sudoku
  class SolutionSet
    class Process
      class Step
        attr_reader :output

        def initialize(solution_set)
          @solution_set = solution_set
        end

        def take(input=nil)
          @input ||= input
          @output = take!(*[@input].compact)
        end

        def take!(*args)
          raise NotImplementedError, "#{self.class}#take! not implemented"
        end

        def revert
          revert!
        end

        def revert!
          raise NotImplementedError, "#{self.class}#revert! not implemented"
        end

        def retry?
          @output
        end

        def constraints
          @solution_set.constraints
        end

        def excluded_choices
          @solution_set.excluded_choices
        end

        def included_choices
          @solution_set.included_choices
        end

        def include_choice(choice)
          @solution_set.include_choice(choice)
        end

        def exclude_choice(choice)
          @solution_set.exclude_choice(choice)
        end

        def restore_excluded_choices(choices)
          @solution_set.restore_excluded_choices(choices)
        end

        def delete_excluded_choices_if(&block)
          @solution_set.delete_excluded_choices_if(&block)
        end
      end
    end
  end
end

