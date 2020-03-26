class TripMenu < Menu
    attr_reader :account
    def initialize(account)
        @menu = <<-TRIP_MENU
        ********  Bike Menu  **********                       
        5. ADD A TRIP
        7. TOTAL DISTANCE OF ALL TRIPS
        9. USER MENU
        ***************************
        TRIP_MENU

        @input = nil
        @account = account
        @my_menu_name = MenuHelpers.Trip 
        @menu_to_return_to = @my_menu_name   
    end

    
    def input=(input)
        data_valid = false;        
        if(input.length == 1)    
            # 5. ADD A TRIP
            # 7. TOTAL DISTANCE OF ALL TRIPS
            # 9. USER MENU    
            valid_choices = ["5", "7", "9"]                        
            if(valid_choices.any?(input))
                @input = input
                data_valid = true
                case input
                when "5"                                                            
                    puts "Add a trip menu"
                when "7"
                    puts "Total distance"
                when "9"
                    puts "User menu"                    
                    @menu_to_return_to = MenuHelpers.User

                end     
            end
        end

        if(data_valid)
            @input = input
        else
            @input = nil
        end 

    end

    def menu_routine()                           
        while(!@input || (@menu_to_return_to == @my_menu_name)) do            
            trips = Trip.all.select{|trip| trip.biker_id == @account.id}.map{|trip| trip.to_s}
            super(trips)            
            self.input=gets.chomp                 
        end  
        @menu_to_return_to      
    end
end