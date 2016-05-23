require_relative '../lib/challenges/parens.rb'

describe Parens do
  describe '.evaluate' do
    it "returns small valid sets" do
      expect(Parens.evaluate("()")).to eq("()")
    end

    it "returns nil on invalid sets" do
      expect(Parens.evaluate(")(")).to eq(nil)
    end

    it "returns a valid substring" do
      expect(Parens.evaluate("()(")).to eq(nil)
    end

    it "returns nil on a balanced but invalid set" do
      expect(Parens.evaluate("()))))((((()")).to eq(nil)
    end

    pending "returns a good string, even if it's complicated." do
      expect(Parens.evaluate("(((())())))))))")).
        to eq("(((())()))")
    end
  end
end
