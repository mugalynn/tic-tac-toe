# make a tic-tac-toe board that two players can play
require 'gosu'

class Play
  def initialize
    @player_x = Gosu::Image.new("tic_tac_toe/x.png")
    @player_o = Gosu::Image.new("tic_tac_toe/o.png")    
  end
  
  def valid (game_state, button)
    if game_state[button-1]==0
      return true
    end  
  end

  def check_for_winner(game_state)
    #check rows
    if (game_state[0] == game_state[1] && game_state[1]== game_state[2]) && game_state[0]!=0
      winner = game_state[0]
    elsif
      (game_state[3] == game_state[4] && game_state[4] == game_state[5]) && game_state[3]!=0
      winner = game_state[3]
    elsif
      (game_state[6] == game_state[7] && game_state[7] == game_state[8]) && game_state[6]!=0
      winner = game_state[6]
    elsif
      (game_state[0] == game_state[3] && game_state[3] == game_state[6]) && game_state[0]!=0
      winner = game_state[0]
    elsif
      (game_state[1] == game_state[4] && game_state[4]== game_state[7]) && game_state[1]!=0
      winner = game_state[1]
    elsif 
      (game_state[2] == game_state[5] && game_state[5] == game_state[8]) && game_state[2]!=0
      winner = game_state[2]
    elsif (game_state[0] == game_state[4] && game_state[4] == game_state[8]) && game_state[0]!=0
      winner = game_state[0]
    elsif(game_state[2] == game_state[4] && game_state[4] == game_state[6]) && game_state[2]!=0
      winner = game_state[2]
      end
  end
  
  def lookup_coords(index)
    zone_hash = { 0=> [0, 0, 138, 147.5],
      1=> [180, 0, 300, 147.5],
      2=> [339.5, 0, 480, 147.5],
      3=> [0, 174, 141.5, 306.75],
      4=> [180, 174, 300, 306.75],
      5=> [339.5, 174, 480, 306.75],
      6 => [0, 333.5, 141.5, 478.5],
      7 => [180, 333.5, 300, 478.5],
      8 => [339.5, 333.5, 480, 478.5]}
      coordinates = [zone_hash[index][0]+(zone_hash[index][2]-zone_hash[index][0])/2, zone_hash[index][1]+(zone_hash[index][3]-zone_hash[index][1])/2]
      #print coordinates
      return coordinates
    end

  def draw(square, index)
    coords = Array.new
    coords = lookup_coords(index)

    if square == "x"
      @player_x.draw_rot(coords[0], coords[1], 0)
    end
    if square == "o"
      @player_o.draw_rot(coords[0], coords[1], 0)
    end
  end
end

class Tic_tac_toe < Gosu::Window
  def initialize
    super 480, 480
    self.caption = "Tic-Tac-Toe Game"
    @areas = {
      :one=> [0, 0, 138, 147.5],
      :two=> [180, 0, 300, 147.5],
      :three=> [339.5, 0, 480, 147.5],
      :four=> [0, 174, 141.5, 306.75],
      :five => [180, 174, 300, 306.75],
      :six => [339.5, 174, 480, 306.75],
      :seven => [0, 333.5, 141.5, 478.5],
      :eight => [180, 333.5, 300, 478.5],
      :nine => [339.5, 333.5, 480, 478.5]}
    @background_image = Gosu::Image.new("tic_tac_toe/game_board.png", :tileable => true)
    @play = Play.new
    @game_state = [0,0,0,0,0,0,0,0,0]
    @turn = 0
    @game_over_win_x = Gosu::Image.from_text(self, 'X is the Winner!', Gosu.default_font_name, 30)
    @game_over_win_o = Gosu::Image.from_text(self, 'O is the Winner!', Gosu.default_font_name, 30)
    @game_over_draw = Gosu::Image.from_text(self, 'This game is a draw!', Gosu.default_font_name, 30)
    
  end

  def game_new
    Tutorial.new.show
  end
  #end
  
  def update
    if Gosu.button_down? Gosu::MsLeft
  
      button = area_clicked(mouse_x, mouse_y)
      if button 
        if @play.valid(@game_state, button)
          game(button)
          if @play.check_for_winner(@game_state)
             @winner=@play.check_for_winner(@game_state)
   #          game_new
          elsif @game_state.include?(0)==false
            @tie="tie"
          else
            @turn+=1
          end
        end
      end
      
    
    end
  end

  def game(button)
    if @turn%2==0
      @game_state[button-1]="x"
    elsif @turn%2==1
      @game_state[button-1]="o"
      end
  end

  


  def area_clicked(mouse_x, mouse_y)
  
    if (mouse_x >= @areas[:one][0] && mouse_x <= @areas[:one][2]) && (mouse_y >= @areas[:one][1] && mouse_y <= @areas[:one][3])    
      return 1
    end

    if (mouse_x >= @areas[:two][0] && mouse_x <= @areas[:two][2]) && (mouse_y >= @areas[:two][1] && mouse_y <= @areas[:two][3])
      return 2
    end

    if (mouse_x >= @areas[:three][0] && mouse_x <= @areas[:three][2]) && (mouse_y >= @areas[:three][1] && mouse_y <= @areas[:three][3])
    return 3
    end

    if (mouse_x >= @areas[:four][0] && mouse_x <= @areas[:four][2]) && (mouse_y >= @areas[:four][1] && mouse_y <= @areas[:four][3])
      return 4
      end

    if (mouse_x >= @areas[:five][0] && mouse_x <= @areas[:five][2]) && (mouse_y >= @areas[:five][1] && mouse_y <= @areas[:five][3])
      return 5
    end

    if (mouse_x >= @areas[:six][0] && mouse_x <= @areas[:six][2]) && (mouse_y >= @areas[:six][1] && mouse_y <= @areas[:six][3])
      return 6
    end
    if (mouse_x >= @areas[:seven][0] && mouse_x <= @areas[:seven][2]) && (mouse_y >= @areas[:seven][1] && mouse_y <= @areas[:seven][3])
      return 7
    end
    if (mouse_x >= @areas[:eight][0] && mouse_x <= @areas[:eight][2]) && (mouse_y >= @areas[:eight][1] && mouse_y <= @areas[:eight][3])
      return 8
    end
    if (mouse_x >= @areas[:nine][0] && mouse_x <= @areas[:nine][2]) && (mouse_y >= @areas[:nine][1] && mouse_y <= @areas[:nine][3])
      return 9
    end

    
  end

  def draw
    @background_image.draw(0, 0, 0)
    @game_state.each_with_index {|square, index| 
      if square == "x" || square == "o" 
        @play.draw(square, index)
      end 
      }
      if @winner=="x"
        @game_over_win_x.draw(10, 10, 0)
      elsif @winner == "o"
        @game_over_win_o.draw(10, 10, 0)
      end
      if @tie=="tie"
         @game_over_draw.draw(10, 10, 0)
      end
    
    
  end

    
  
  def button_down(id)
    if id == Gosu::KB_ESCAPE
        close
    elsif id == Gosu::KB_SPACE
      Tic_tac_toe.new.show
    else
        super
    end
  end
end

Tic_tac_toe.new.show
