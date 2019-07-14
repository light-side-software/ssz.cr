require "../spec_helper"

describe SSZ do
  describe SSZ::Serializable do
    describe Point do
      p = Point.new(13, 62)

      it "should return true" do
        Point.ssz_variable?.should be_false
        p.ssz_variable?.should be_false
      end

      it "should return false" do
        Point.ssz_fixed?.should be_true
        p.ssz_fixed?.should be_true
      end

      it "should return size" do
        p.ssz_size.should eq(8)
      end

      it "should serialize Point" do
        bytes = p.ssz_encode
        bytes.should eq(Bytes[13, 0, 0, 0, 62, 0, 0, 0])

        io = IO::Memory.new(bytes)
        Point.ssz_decode(io).should eq(p)
        io.pos.should eq(8)
        Point.ssz_decode(bytes).should eq(p)
      end
    end
  end
end