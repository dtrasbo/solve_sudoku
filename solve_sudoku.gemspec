Gem::Specification.new do |s|
  s.name    = 'solve_sudoku'
  s.version = '0.1.0'

  s.author = 'David Trasbo'
  s.email  = 'me@dtrasbo.com'

  s.summary     = 'Accepts a Sudoku puzzle (a partially completed grid) and outputs all possible solutions.'
  s.description = 'Accepts a Sudoku puzzle (a partially completed grid) and outputs all possible solutions. The algorithm is based on this article: http://garethrees.org/2007/06/10/zendoku-generation/'
  s.homepage    = 'https://github.com/dtrasbo/solve_sudoku'

  s.files = `git ls-files lib bin puzzles README.md LICENSE`.split($/)
  s.executables << 'solve_sudoku'
end

