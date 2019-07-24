require "../spec_helper"

describe SSZ do
  describe "#hash" do
    it "should calc SHA-256" do
      SSZ.hash(Bytes[0]).should eq(Bytes[110, 52, 11, 156, 255, 179, 122, 152, 156, 165, 68, 230, 187, 120, 10, 44, 120, 144, 29, 63, 179, 55, 56, 118, 133, 17, 163, 6, 23, 175, 160, 29])
    end
  end
end
