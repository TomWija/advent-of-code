class BingoNumber
  attr_reader :number
  attr_accessor :marked

  def initialize(number, marked = false)
    @number = number
    @marked = marked
  end
end

class BingoBoard
  attr_reader :already_won

  def initialize(rows)
    @rows = rows
    @columns = rows.transpose(&:reverse)
    @already_won = false
  end

  def mark_numbers(x)
    @rows = @rows.each { |row| row.each { |bingo_number| bingo_number.marked = true if bingo_number.number == x } }
  end

  def sum_unmarked
    sum = 0
    @rows.each do |row|
      row.each { |bingo_number| sum += bingo_number.number unless bingo_number.marked }
    end
    sum
  end

  def won?
    @already_won = @rows.any? { |row| row.all?(&:marked) } || @columns.any? { |column| column.all?(&:marked) }
  end
end

class BingoGame
  def initialize(number_sequence, boards)
    @number_sequence = number_sequence.reverse
    @boards = boards
  end

  def play_to_win
    solution = false
    until solution || @number_sequence.length.zero?
      current_number = @number_sequence.pop
      @boards.each do |board|
        board.mark_numbers(current_number)
        solution = current_number * board.sum_unmarked if board.won?
      end
    end
    puts "Winning solution #{solution}"
  end

  def play_to_lose
    solution = false
    winning_boards = 0
    until solution || @number_sequence.length.zero?
      current_number = @number_sequence.pop
      @boards.each do |board|
        board.mark_numbers(current_number)
        winning_boards += 1 if !board.already_won && board.won?
        solution = current_number * board.sum_unmarked if winning_boards == @boards.length && !solution
      end
    end
    puts "Losing solution #{solution}"
  end
end

def build_board(spec)
  BingoBoard.new(spec.map { |row| row.split.map { |number| BingoNumber.new(number.to_i) } })
end

number_sequence = File.readlines('sequence.txt')[0].split(',').map(&:to_i)
boards = File.open('boards.txt')
             .each_line
             .reject { |line| line.start_with?("\n") }
             .each_slice(5)
             .map { |board| build_board(board) }

bingo = BingoGame.new(number_sequence, boards)
bingo.play_to_lose
