class WordChainer

    attr_reader :dictionary
    
    def initialize
        @dictionary = File.read("dictionary.txt").split("\n")
    end

end

# code for testing

w = WordChainer.new
p w.dictionary