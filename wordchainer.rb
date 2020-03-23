require 'set'

class WordChainer

    attr_reader :dictionary
    
    def initialize
        input = File.read("dictionary.txt").split("\n")
        @dictionary = Set.new(input)
        @current_words = Set.new()
        @all_seen_words = Hash.new()
    end

    def adjacent_words(word)
        result = []
        @dictionary.each do |word2|
            if word.length ==  word2.length
                count = 0
                (0...word.length).each do |idx|
                    if word[idx] == word2[idx]
                        count += 1
                    end
                end
                if count == word.length - 1
                    result << word2
                end
            end  
        end
        result
    end

    def run(source, target=nil)
        @current_words << source
        @all_seen_words[source] = nil
        while @current_words.length > 0
            self.explore_current_words
        end
        # print @all_seen_words
        print self.build_path(target)
    end

    def explore_current_words
        new_current_words = []
        @current_words.each do |current_word|
            adjacent_words(current_word).each do |adjacent_word|
                unless @all_seen_words.has_key?(adjacent_word)
                    new_current_words << adjacent_word
                    @all_seen_words[adjacent_word] = current_word
                end
            end
        end
        @current_words = new_current_words
    end

    def build_path(target)
        return ["end"] if @all_seen_words[target] == nil
        path = []
        path << @all_seen_words[target]
        path + build_path(@all_seen_words[target])
    end

end

# code for testing

# w = WordChainer.new
# w.run("market", "lesser")