require 'spec_helper'

describe "Game of Life" do
  context "Working out neighbours" do
    context "a cell located at position 1,1" do
      it "has a neighbour at 0,0" do
        neighbours_of(1,1).should include([0,0])
      end

      it "has a neighbour at 0,1" do
        neighbours_of(1,1).should include([0,1])
      end

      it "has a neighbour at 0,2" do
        neighbours_of(1,1).should include([0,2])
      end
      
      it "has a neighbour at 1,0" do
        neighbours_of(1,1).should include([1,0])
      end
      
      it "has a neighbour at 1,2" do
        neighbours_of(1,1).should include([1,2])
      end

      it "has a neighbour at 2,0" do
        neighbours_of(1,1).should include([2,0])
      end

      it "has a neighbour at 2,1" do
        neighbours_of(1,1).should include([2,1])
      end

      it "has a neighbour at 2,2" do
        neighbours_of(1,1).should include([2,2])
      end
    end

    context "a cell located at 1,2" do
      it "has neighbours located in the 8 cells surrounding it" do
        neighbours_of(1,2).should == [[0,1],[0,2],[0,3],[1,1],[1,3],[2,1],[2,2],[2,3]]
      end
    end
  end

  context "Counting shared neighbours" do
    context "with a cell at 1,1" do
      def counts(cell)
        counts = neighbour_counts([[1,1]])
        counts[cell]
      end

      it "0,0 is counted once" do
        counts([0,0]).should == 1
      end

      it "0,1 is counted once" do
        counts([0,1]).should == 1
      end
    end

    context "with cells at 1,0 and 1,2" do
      it "0,1 is counted twice" do
        all_life = [[1,0],[1,2]]
        counts = neighbour_counts(all_life)
        counts[[0,1]].should == 2
      end

      it "1,1 is counted twice" do
        all_life = [[1,0],[1,2]]
        counts = neighbour_counts(all_life)
        counts[[1,1]].should == 2
      end

      it "2,1 is counted twice" do
        all_life = [[1,0],[1,2]]
        counts = neighbour_counts(all_life)
        counts[[2,1]].should == 2
      end
    end
  end

  context "The Rules" do
    context "Given a living cell" do
      it "with fewer than two living neighbours dies" do
        alive_next_generation(1).should be_false
      end

      it "with two living neighbours lives" do
        alive_next_generation(2).should be_true
      end

      it "with three living neighbours lives" do
        alive_next_generation(3).should be_true
      end

      it "with four living neighbours dies" do
        alive_next_generation(4).should be_false
      end
    end

    context "Given a dead cell" do
      it "with exactly three living neighbours becomes alive" do
        alive_next_generation(3, false).should be_true
      end

      it "with two living neighbours stays dead" do
        alive_next_generation(2, false).should be_false
      end
    end
  end
  
  context "Evolving life" do
    it "a single living cell does not survive to the next generation" do
      evolve([[1,1]]).should be_empty
    end
  end
end
