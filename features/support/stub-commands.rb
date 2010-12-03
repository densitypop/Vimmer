# redefine ` to stub the curl and git commands
module Kernel
  alias_method :real_backtick, :`
  def `(command)
    case command
    when /^curl (.+)/
      if $1 =~ /\.git\b|not-found/
        '404'
      else
        '200'
      end 

    when /^git (.+)/
      git_arguments = $1
      # git clone <url> (<dir>)
      if git_arguments =~ /^clone \S+ (.+)/
        require 'fileutils'
        FileUtils.mkdir_p $1 
      else
        puts 'delegating to git'
        real_backtick "git #{git_arguments}"
      end
    
    else
      real_backtick command
    end
  end
end

