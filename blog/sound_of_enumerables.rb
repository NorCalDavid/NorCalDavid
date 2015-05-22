sound_of_music_array = ["Do", "Re", "Mi", "Fa", "Sol", "La", "Ti"]
sound_of_music_hash = Hash.new
sound_of_music_hash[:Line1] = "Do, a deer, a female deer"
sound_of_music_hash[:Line2] = "Re, a drop of golden sun"
sound_of_music_hash[:Line3] = "Mi, a name, i call myself"
sound_of_music_hash[:Line4] = "Fa, a long long way to run"
sound_of_music_hash[:Line5] = "So, a needle pulling thread"
sound_of_music_hash[:Line6] = "La, a note to follow So"
sound_of_music_hash[:Line7] = "Ti, a drink with jam and bread"
sound_of_music_hash[:Line8] = "and that brings us back to Do-oh-oh-oh"

#*******************************************************************************
# Method Definitions
#*******************************************************************************

# read a character without pressing enter and without printing to the screen
def read_char
  begin
    # save previous state of stty
    old_state = `stty -g`
    # disable echoing and enable raw (not having to press enter)
    system "stty raw -echo"
    c = STDIN.getc.chr
    # gather next two characters of special keys
    if(c=="\e")
      extra_thread = Thread.new{
        c = c + STDIN.getc.chr
        c = c + STDIN.getc.chr
      }
      # wait just long enough for special keys to get swallowed
      extra_thread.join(0.00001)
      # kill thread so not-so-long special keys don't wait on getc
      extra_thread.kill
    end
  rescue => ex
    puts "#{ex.class}: #{ex.message}"
    puts ex.backtrace
  ensure
    # restore previous state of stty
    system "stty #{old_state}"
  end
  return c
end

#*******************************************************************************
#*******************************************************************************

def print_menu
  system("clear")
  puts("Maria's Lesson Plan".center(50))
  puts("*"*50)
  puts("\n","Array".center(50),"\n")
  puts("1\t\tPractice Notes One at a Time")
  puts("2\t\tPractice Notes (X) Number of Times")
  puts("3\t\tPractice Notes Forever - ** Caution ** Infinite Loop")
  puts("\n", "*"*50)
  puts("\n","Hash".center(50),"\n")
  puts("4\t\tPractice Song One Line at a Time")
  puts("5\t\tPractive Song (x) Number of Times")
  puts("6\t\tPractice It All Together")
  puts("\n", "*"*50)
  puts("\n\nE\t\tExit Lesson Plan")

  userResp1 = " "
  options = ["1", "2", "3", "4", "5", "6", "e", "E"]

  while options.include?(userResp1) == false
    print("Enter 1 -> 5 or E: ")
    userResp1 = gets.chomp.to_s
  end

  return userResp1
end

#*******************************************************************************
#*******************************************************************************

def cycle_array_using_next(array)
  cycle_enum = array.cycle
  system("clear")
  puts("Press Any Key to Cotninue  or  ESC to Exit")
  print("\n", "\n #{cycle_enum.next}") until read_char == "\e"
  puts("\n\n\nWhen you know the notes to sing, you can sing most anything!")
end

#*******************************************************************************
#*******************************************************************************

def cycle_array_n_times(array)
  system("clear")
  userResp_number = " "

  while userResp_number.is_a?(Integer) == false || userResp_number < 1
    print("How Many Times to Practice: ")
    userResp_number = gets.chomp.to_i
  end

  array.cycle(userResp_number) { |i| puts "\n#{i}\n"; sleep(1) }
  puts("\n When you know the notes to sing, you can sing most anything!")
end

#*******************************************************************************
#*******************************************************************************

def cycle_array_forever(array)
  system("clear")
  puts("This is an Infinite Loop Ctrl C to Break Loop")
  array.cycle { |i| puts "\n#{i}\n"; sleep(1) }
  puts("\n When you know the notes to sing, you can sing most anything!")
end

#*******************************************************************************
#*******************************************************************************

def cycle_hash_using_next(hash)
  cycle_enum = hash.values.cycle
  system("clear")
  puts("Press Any Key to Cotninue  or  ESC to Exit")
  print("\n","\n #{cycle_enum.next.center(100)}") until read_char == "\e"
  puts("\n\n\nWhen you know the notes to sing, you can sing most anything!")
end

#*******************************************************************************
#*******************************************************************************

def cycle_hash_n_times(hash)
  system("clear")
  userResp_number = " "

  while userResp_number.is_a?(Integer) == false || userResp_number < 1
    print("How Many Times to Practice: ")
    userResp_number = gets.chomp.to_i
  end

  hash.values.cycle(userResp_number) { |i| puts "\n#{i.center(100)}\n"; sleep(1) }; puts"\n\n"
  puts("When you know the notes to sing,".center(100))
  puts("you can sing most anything!".center(100))
end

#*******************************************************************************
#*******************************************************************************

def put_it_all_together(array, hash)
  system("clear")

  array.cycle(1) { |i| puts "#{i}".center(70), "\n";sleep(1) }; puts "\n\n"; array.cycle(1) { |i| print "#{i}".center(10); }; puts "\n\n"; sleep(1)
  hash.values.cycle(1) { |i| puts "\n#{i.center(70)}\n"; sleep(1) }; puts("\n\n")
  array.cycle(1) { |i| print "#{i}".center(10); sleep(1) }; puts "\n\n"
  hash.values.cycle(1) { |i| puts "\n#{i.center(70)}\n"; sleep(1)}; puts "\n\n"
  puts "\n\n"; array.cycle(1) { |i| print "#{i}".center(10); sleep(1) }; puts "\n\n"
  puts("When you know the notes to sing,".center(70)); puts"\n\n"; puts("you can sing most anything!".center(70))
end

#*******************************************************************************
#*******************************************************************************

userMenuResponse = 0
until userMenuResponse.to_s.upcase == "E"

  userMenuResponse = print_menu

  case userMenuResponse
    when "1"
      cycle_array_using_next(sound_of_music_array)
    when "2"
      cycle_array_n_times(sound_of_music_array)
    when "3"
      cycle_array_forever(sound_of_music_array)
    when "4"
      cycle_hash_using_next(sound_of_music_hash)
    when "5"
      cycle_hash_n_times(sound_of_music_hash)
    when "6"
      put_it_all_together(sound_of_music_array, sound_of_music_hash)
  end
end
