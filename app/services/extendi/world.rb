class World
    attr_accessor :grid, :cols, :lines

    def initialize(cols, lines, generation = nil)
        @cols = cols
        @lines = lines
        @grid = load_grid
        @generation = generation
    end

    def load(cells)
        cells.each do |y, x| 
            grid[x][y] = 1 
        end
    end
    
    def neighbors_count(y, x)
        neighbors(y, x).count { |cell| cell == 1 }
    end
    
    def execute
        return grid if @generation == 1 
       
        new_grid = load_grid
        grid.each_with_index do |line, y|
            line.each_with_index do |cell, x|
                count = neighbors_count(y, x)
                new_grid[y][x] = begin
                    if cell.zero?
                        [3].include?(count) ? 1 : 0
                    else
                        [2, 3].include?(count) ? 1 : 0
                    end
                end
            end
        end
        
        @grid = new_grid
    end


    private

    def neighbors(y, x)
        (-1..1).inject [] do |values, py|
        (-1..1).each do |px|
            unless py == 0 and px == 0
            i = y + py
            j = x + px
            i = 0 unless i < lines
            j = 0 unless j < cols
            values << grid[i][j]
            end
        end
        values
        end
    end

    def load_grid
        Array.new(lines) { Array.new(cols,0) }
    end

end
