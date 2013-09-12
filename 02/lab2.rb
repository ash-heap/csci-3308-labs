# File: lab2.rb
# Written: 09/11/2013.254 - Michael R. Shannon
#
# Deliverable for Lab 2 of CSCI 3308 - Software Engineering Methods and Tools.
#






### Part 1: Hello World
class HelloWorldClass
    def initialize(name)
        @name = name.capitalize
    end
    def sayHi
        puts "Hello #{@name}!"
    end
end
hello = HelloWorldClass.new("Michael")
hello.sayHi






### Part 2: Strings

# a) Palindromes
def palindrome?(string)
    word_chars = string.downcase.gsub /\W/, ''
    word_chars == word_chars.reverse
end
raise unless palindrome? "A man, a plan, a canal -- Panama"
raise unless palindrome? "Madam, I'm Adam!"
raise if palindrome? "Abracadabra"


# b) Word Count
def count_words(string)
    word_count = {}
    string.downcase.scan(/\b\w+/).each do |word|
        word_count[word] = 0 unless word_count[word] 
        word_count[word] += 1
    end
    word_count
end
raise unless count_words("A man, a plan, a canal -- Panama") == 
    {'a' => 3, 'man' => 1, 'canal' => 1, 'panama' => 1, 'plan' => 1}
raise unless count_words("Doo bee doo bee doo") ==
    {'doo' => 3, 'bee' => 2}






# Part 3: Rock Paper Scissors

# a) rps_game_winner
class WrongNumberOfPlayersError < StandardError ; end
class NoSuchStrategyError < StandardError ; end
def rps_game_winner(game)
    rules = {'r' => 's', 'p' => 'r', 's' => 'p'}
    raise WrongNumberOfPlayersError unless game.length == 2
    moves = game.map { |player| player.last.downcase }
    raise NoSuchStrategyError unless moves.all? { |move| rules[move] }
    (rules[moves.last] == moves.first) && game.last || game.first
end
raise unless rps_game_winner([["Armando", "P"], ["Dave", "S"]]) == ["Dave", "S"]
raise unless rps_game_winner([["Armando", "R"], ["Dave", "P"]]) == ["Dave", "P"]
raise unless rps_game_winner([["Armando", "R"], ["Dave", "S"]]) == ["Armando", "R"]
raise unless rps_game_winner([["Armando", "P"], ["Dave", "P"]]) == ["Armando", "P"]


# b) rps_tournament_winner
def rps_tournament_winner(tournament)
    return rps_game_winner tournament unless tournament.first.first.kind_of? Array
    rps_game_winner [rps_tournament_winner(tournament.first),
                     rps_tournament_winner(tournament.last)]
end
tournament = 
[
    [
        [ ["Armando", "P"], ["Dave", "S"] ],
        [ ["Richard", "R"],  ["Michael", "S"] ],
    ],
    [
        [ ["Allen", "S"], ["Omer", "P"] ],
        [ ["David E.", "R"], ["Richard X.", "P"] ]
    ]
]
raise unless rps_tournament_winner(tournament) == ["Richard", "R"]






# Part 4: Anagrams
def combine_anagrams(words)
    anagrams = {}
    words.each do |word| 
        key = word.downcase.chars.sort.join
        anagrams[key] = [] unless anagrams[key]
        anagrams[key] << word
    end
    anagrams.values
end
input = ['cars', 'for', 'potatoes', 'racs', 'four', 'scar', 'creams', 'scream']
output = [["cars", "racs", "scar"],
          ["four"],
          ["for"],
          ["potatoes"],
          ["creams", "scream"]]
raise unless combine_anagrams(input).map { |v| v.sort}.sort == output.map { |v| v.sort}.sort



