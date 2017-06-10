module RTG
  module Screen
    module_function

    WIDTH = 60

    def main_screen(word)
      diff = word.size - word.uncolorize.size
      puts
      puts ["\t+", "-" * WIDTH, "+"].join
      puts ["\t|", " " * WIDTH, "|"].join
      puts ["\t|", word.center(WIDTH + diff), "|"].join
      puts ["\t|", " " * WIDTH, "|"].join
      puts ["\t+", "-" * WIDTH, "+"].join
      puts
    end

    def print_time_bar(remain_time)
      puts
      puts ["\t+", "-" * Server::TIME_LIMIT, "+"].join
      puts ["\t", (" " * (Server::TIME_LIMIT - remain_time) + "|" * remain_time).chars.each_slice(Server::TIME_LIMIT).map { |l| l.join.colorize(:green) }, ""].join("|")
      puts ["\t+", "-" * Server::TIME_LIMIT, "+"].join
    end

    def wait_screen
      puts
      puts
      puts ["\t+", "-" * WIDTH, "+"].join
      puts ["\t|", " " * WIDTH, "|"].join
      puts ["\t|", "Press the `space` key to start game".center(WIDTH), "|"].join
      puts ["\t|", " " * WIDTH, "|"].join
      puts ["\t+", "-" * WIDTH, "+"].join
      puts
      puts
    end

    def result_screen(type_count, typo_count)
      puts
      puts
      puts ["\t+", "-" * WIDTH, "+"].join
      puts ["\t|", " " * WIDTH, "|"].join
      puts ["\t|", "typing speed : #{type_count}/min".center(WIDTH), "|"].join
      puts ["\t|", " " * WIDTH, "|"].join
      puts ["\t+", "-" * WIDTH, "+"].join
      puts
      puts ["\tQ)uit"]
      puts
    end

    def clean_screen(num)
      _height, width = STDIN.winsize
      num.times do
        puts "\r" + " " * width
      end
      print "\r\e[#{num}A"
    end
  end
end