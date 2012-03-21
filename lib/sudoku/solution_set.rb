require 'sudoku/grid'
require 'sudoku/solution_set/process'
require 'sudoku/solution_set/constraints'
require 'sudoku/solution_set/choice'

module Sudoku
  class SolutionSet
    attr_reader :constraints, :included_choices

    def initialize(puzzle)
      @puzzle = Grid.new(puzzle)
      @process = Process.new(self)

      initialize_constraints
      initialize_excluded_choices
      initialize_included_choices
      delete_redundant_choices
    end

    def each
      loop do
        if @process.run!
          yield to_grid
        else
          return
        end
      end
    end

    def excluded_choices
      @excluded_choices.sort_by! { |choice|
        [choice.column, choice.row, choice.value]
      }
    end

    def include_choice(choice)
      @excluded_choices.delete(choice)
      @included_choices << choice
      choice
    end

    def exclude_choice(choice)
      @included_choices.delete(choice)
      @excluded_choices << choice
      choice
    end

    def delete_excluded_choices_if
      deleted_choices = []

      @excluded_choices.delete_if do |excluded_choice|
        if yield excluded_choice
          deleted_choices << excluded_choice
          true
        end
      end

      deleted_choices
    end

    def restore_excluded_choices(choices)
      choices.each do |choice|
        @excluded_choices << choice
      end
    end

    def to_grid
      grid = Grid.new

      @included_choices.each do |choice|
        grid[choice.column, choice.row] = choice.value
      end

      grid
    end

    private

    def initialize_constraints
      @constraints = []

      (1..9).each do |column|
        (1..9).each do |row|
          @constraints << Constraints::CellMustBeFilled.new(column, row)
        end
      end

      (1..9).each do |column|
        (1..9).each do |value|
          @constraints << Constraints::ColumnMustContainValue.new(column, value)
        end
      end

      (1..9).each do |row|
        (1..9).each do |value|
          @constraints << Constraints::RowMustContainValue.new(row, value)
        end
      end

      (1..3).each do |box_x|
        (1..3).each do |box_y|
          (1..9).each do |value|
            @constraints << Constraints::BoxMustContainValue.new(box_x, box_y, value)
          end
        end
      end
    end

    def initialize_excluded_choices
      @excluded_choices = []

      (1..9).each do |column|
        (1..9).each do |row|
          (1..9).each do |value|
            @excluded_choices << Choice.new(column, row, value)
          end
        end
      end
    end

    def initialize_included_choices
      @included_choices = []

      @puzzle.filled_cells.each do |cell|
        include_choice(@excluded_choices.find { |choice|
          choice.column == cell.column &&
            choice.row == cell.row &&
            choice.value == cell.value
        })
      end
    end

    def delete_redundant_choices
      satisfied_constraints = @constraints.select { |constraint|
        @included_choices.any? { |excluded_choice|
          constraint.satisfied_by?(excluded_choice)
        }
      }

      @excluded_choices.delete_if do |excluded_choice|
        satisfied_constraints.any? { |sc|
          sc.satisfied_by?(excluded_choice)
        }
      end
    end
  end
end

