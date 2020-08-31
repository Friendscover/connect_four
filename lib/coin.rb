#has attributes name, icon
class Coin
  attr_accessor :name, :icon

  def initialize(name = "coin", icon = "☾")
    @name = name
    @icon = icon
  end
end