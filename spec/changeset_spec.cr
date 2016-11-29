require "./spec_helper"

describe Crecto do
  describe "Changeset" do
    describe "#validate_required" do
      it "should not be valid" do
        u = UserRequired.new
        changeset = UserRequired.changeset(u)
        changeset.valid?.should eq(false)
      end

      it "should have some errors" do
        u = UserRequired.new
        changeset = UserRequired.changeset(u)
        changeset.errors.size.should be > 0
        changeset.errors[0].should eq({:field => "name", :message => "is required"})
      end
    end

    describe "#validate_format" do
      it "should not be valid" do
        u = UserFormat.new
        u.name = "123"
        changeset = UserFormat.changeset(u)
        changeset.valid?.should eq(false)
      end

      it "should have some errors" do
        u = UserFormat.new
        u.name = "123"
        changeset = UserFormat.changeset(u)
        changeset.errors.size.should be > 0
        changeset.errors[0].should eq({:field => "name", :message => "is invalid"})
      end
    end

    describe "#validate_inclusion" do
      it "should not be valid" do
        u = UserInclusion.new
        u.name = "fred"
        changeset = UserInclusion.changeset(u)
        changeset.valid?.should eq(false)
      end

      it "should have some errors" do
        u = UserInclusion.new
        u.name = "fred"
        changeset = UserInclusion.changeset(u)
        changeset.errors.size.should be > 0
        changeset.errors[0].should eq({:field => "name", :message => "is invalid"})
      end
    end

    describe "#validate_exclusion" do
      it "should not be valid" do
        u = UserExclusion.new
        u.name = "bill"
        changeset = UserExclusion.changeset(u)
        changeset.valid?.should eq(false)
      end

      it "should have some errors" do
        u = UserExclusion.new
        u.name = "bill"
        changeset = UserExclusion.changeset(u)
        changeset.errors.size.should be > 0
        changeset.errors[0].should eq({:field => "name", :message => "is invalid"})
      end
    end

    describe "#validate_length" do
      it "should not be valid" do
        u = UserLength.new
        u.name = "fridge"
        changeset = UserLength.changeset(u)
        changeset.valid?.should eq(false)
      end

      it "should have some errors" do
        u = UserLength.new
        u.name = "fridge"
        changeset = UserLength.changeset(u)
        changeset.errors.size.should be > 0
        changeset.errors[0].should eq({:field => "name", :message => "is invalid"})
      end
    end

    describe "#validate" do
      it "should not be valid" do
        u = UserGenericValidation.new
        changeset = UserGenericValidation.changeset(u)
        changeset.valid?.should be_false
      end

      it "should have some errors" do
        u = UserGenericValidation.new
        changeset = UserGenericValidation.changeset(u)
        changeset.errors.size.should be > 0
        changeset.errors[0].should eq({:field => "_base", :message => "Password must exist"})
      end

      it "should not have some errors and be valid" do
        u = UserGenericValidation.new
        u.id = 123
        u.password = "awesome"
        changeset = UserGenericValidation.changeset(u)
        changeset.errors.size.should eq(0)
        changeset.valid?.should be_true
      end
    end
  end
end