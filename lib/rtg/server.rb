module RTG
  class Server
    TIME_LIMIT = 60

    def init
      @words = YAML.load_file(File.expand_path("words.yml", __dir__))["method"]
      @words << YAML.load_file(File.expand_path("words.yml", __dir__))["class"]
      @words << YAML.load_file(File.expand_path("words.yml", __dir__))["library"]
      @words.flatten!
      @time = 0
      @type_count = 0
      @typo_count = 0
    end

    def start
      init
      word = get_word
      inputted = []

      Screen.wait_screen
      print "\r\e[9A"

      while input = getkey
        if input == Keyevent::SPACE
          break
        elsif input == Keyevent::ETX
          exit(0)
        end
      end

      Screen.clean_screen(9)

      while @time < TIME_LIMIT
        begin
          Timeout.timeout(1) do
            loop do
              Screen.print_time_bar(TIME_LIMIT - @time)
              Screen.main_screen(inputted.join.colorize(:white) + word.join)
              print "\r\e[11A"

              input = getkey

              if input == Keyevent::ETX
                exit(0)
              elsif input == word.first
                inputted << word.shift
                @type_count += 1

                if word.empty?
                  word = get_word
                  inputted = []
                end
              else
                @typo_count += 1
                print "\a"
              end
            end
          end
        rescue Timeout::Error
          @time += 1
        end
      end

      Screen.clean_screen(11)
      Screen.result_screen(@type_count, @typo_count)

      while input = getkey
        case input
          when /Q/
            break
          when Keyevent::ETX
            exit(0)
        end
      end
    end

    private

    def get_word
      @words.sample.chars
    end
  end
end