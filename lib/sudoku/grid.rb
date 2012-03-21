require 'sudoku/grid/cell'

module Sudoku
  class Grid
    def initialize(string=nil)
      @rows = if string
        string.split($/).collect { |row|
          row.split(',').collect { |value| Cell.new(self, value.to_i) }
        }
      else
        (1..9).collect { |n| [] }
      end
    end

    def []=(column, row, value)
      @rows[row - 1][column - 1] = value
    end

    def cells
      @rows.flatten
    end

    def filled_cells
      cells.select { |c| c.filled? }
    end

    def column(cell)
      row = @rows.find { |r| r.include?(cell) }
      row.index(cell) + 1
    end

    def row(cell)
      row = @rows.find { |r| r.include?(cell) }
      @rows.index(row) + 1
    end

    def to_s
      row_divider = (1..3).collect { "\e[37m---|---|---\e[0m" }.join('|')
      row_divider = "\n#{row_divider}\n"

      row_group_divider = (1..3).collect { '-' * 11 }.join('+')
      row_group_divider = "\n#{row_group_divider}\n"

      [0..2, 3..5, 6..8].collect { |row_group|
        @rows[row_group].collect { |row|
          [0..2, 3..5, 6..8].collect { |col_group|
            col_group.collect { |column|
              " #{row[column] || ' '} "
            }.join("\e[37m|\e[0m")
          }.join('|')
        }.join(row_divider)
      }.join(row_group_divider)
    end
  end
end

