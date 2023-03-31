class ExtendiController < ApplicationController
    before_action :init, only: [:index, :generate, :clear]
    before_action :first_generation, only: [:index, :clear]

    def index
    end

    def generate
        @@world = World.new(@cols, @lines)
        cells = []
       
        params[:cells].to_h.values.each do |col, line|
            cells.push([col.to_i, line.to_i])
        end 
        @@world.load cells
        @grid = @@world.execute
    end

    def clear
    end

    def check_file(file)
        raise ArgumentError unless File.exists?(file) && File.extname(file).include?('txt')
    end 


    private 

    def init 
        file_name = "start.txt"

        begin
            check_file(file_name)

            @file = File.open(file_name)
            @file = @file.readlines()

            @lines = @file.count

            @file.each do |line| 
                @cols = line.split(" ").count 
            end
            
        rescue ArgumentError
            puts "File not exist or invalid format"
        end
    end

    def first_generation
        cells = []
        count_lines = 0

        @file.each do |line| 
            count_col = 1
            line.split(" ").each do |c|
                if c == '*'
                    cells.push([count_col.to_i, count_lines.to_i])
                end 
                count_col += 1
            end

            count_lines += 1
        end

        @cells = cells


        @generation = 1
        @@world = World.new(@cols, @lines, @generation)
        @@world.load @cells
        @grid = @@world.execute
    end 

    
end