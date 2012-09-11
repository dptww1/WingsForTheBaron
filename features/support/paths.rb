module NavigationHelpers
  def path_to(page_name)
    case page_name

    when "the list of games"
      games_path

    else
      raise "Oops! paths.rb doesn't define a path to #{page_name}!"
    end
  end
end

World(NavigationHelpers)
