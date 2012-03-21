require 'sudoku/solution_set/process/steps'
require 'sudoku/solution_set/process/out_of_history'

module Sudoku
  class SolutionSet
    class Process
      STEPS = Hash[[
        :pick_unsatisfied_constraint,
        :pick_choice_satisfying_constraint,
        :move_choice_into_included_set,
        :delete_redundant_choices
      ].collect { |name|
        [
          name,
          Steps.const_get(
            name.to_s.split('_').collect(&:capitalize).join
          )
        ]
      }]

      FALLBACKS = {
        :pick_choice_satisfying_constraint => :pick_choice_satisfying_constraint
      }

      def initialize(solution_set)
        @solution_set = solution_set
        @queue, @history = [], []
      end

      def run!
        loop do
          if @queue.empty?
            queue(STEPS.keys.first)
          else
            if proceed == :solved
              prepare_next_run
              return true
            end
          end
        end
      end

      def queue(step, options={})
        options = { :action => :take }.merge(options)

        if step.is_a?(Symbol)
          step = STEPS[step].new(@solution_set)
        end

        @queue << {
          :action => options[:action],
          :step   => step,
          :input  => options[:input]
        }
      end

      def queue_backtrack(step)
        @history.reverse_each do |item|
          queue(item[:step], :action => :revert)

          if item[:step].class == STEPS[step]
            queue(item[:step])
            return
          end
        end

        raise OutOfHistory, "unable to backtrack to #{step}"
      end

      def proceed
        item = @queue.shift

        case item[:action]
        when :take
          if output = item[:step].take(item[:input])
            @history << item

            if output == :solved
              return :solved
            end

            queue(successor(item[:step]), :input => output)
          else
            queue_backtrack(fallback(item[:step]))
          end
        when :revert
          item[:step].revert
          @history.pop
        end
      end

      def prepare_next_run
        queue_backtrack(:pick_choice_satisfying_constraint)
      end

      def successor(step)
        names = STEPS.keys
        classes = STEPS.values

        if step.class == classes.last
          names.first
        else
          names[classes.index(step.class) + 1]
        end
      end

      def fallback(step)
        FALLBACKS[STEPS.invert[step.class]]
      end
    end
  end
end

