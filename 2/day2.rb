class RPSRound

  def initialize(opponent_move, my_move)
    @opponent_move = opponent_move
    @my_move = my_move
    # outcome scores parameterized by [opponent_move][my_move]
    @outcome_scores = {
      "A"=> {"X"=> 3, "Y"=> 6, "Z"=> 0},
      "B"=> {"X"=> 0, "Y"=> 3, "Z"=> 6},
      "C"=> {"X"=> 6, "Y"=> 0, "Z"=> 3} 
    }

    @shape_scores = {
      "X"=> 1,
      "Y"=> 2,
      "Z"=> 3
    }
  end

  def score()
    @outcome_scores[@opponent_move][@my_move] + @shape_scores[@my_move]
  end 
end


guide = IO.readlines(ARGV[0])
rounds = []
guide.each do |line|
  moves = line.split
  round = RPSRound.new(moves[0], moves[1])
  rounds.append(round)
end

scores = []
rounds.each do |round|
  scores.append(round.score)
end

total = 0
scores.each do |score|
  total += score
end

puts total


##################################
########### Solution 2 ###########
##################################

class RPSRoundCorrect 

  def initialize(opponent_move, outcome)
    @opponent_move = opponent_move
    @outcome = outcome
    @outcome_scores = {
      "X" => 0,
      "Y" => 3,
      "Z" => 6
    }
    # my move parametarized by [opponent_move]
    @shape_scores = {
      "A" => { # opponent rock
        "X" => 3, # loss, chose scissors
        "Y" => 1, # tie, chose rock
        "Z" => 2 # win, chose paper
      },
      "B" => { # opponent Paper
        "X" => 1, # loss, chose rock
        "Y" => 2, # tie, chose paper
        "Z" => 3 # win, chose scissors
      },
      "C" => { # opponent Scissors
        "X" => 2, # loss, chose paper
        "Y" => 3, # tie, chose scissors
        "Z" => 1 # win, chose rock
      }
    }
  end

  def score() 
    @outcome_scores[@outcome] + @shape_scores[@opponent_move][@outcome]
  end
end

rounds = []
guide.each do |line|
  moves = line.split
  round = RPSRoundCorrect.new(moves[0], moves[1])
  rounds.append(round)
end

scores = []
rounds.each do |round|
  scores.append(round.score)
end


total = 0
scores.each do |score|
  total += score
end

puts "total:"
puts total

