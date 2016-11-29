require "./spec_helper"

describe Crecto do
  describe "Repo" do
    describe "#insert" do
      it "should insert the user" do
        u = User.new
        u.name = "fridge"
        u.things = 123
        u.nope = 12.45432
        u.yep = false
        u.stuff = 9993
        u.some_date = Time.now.at_beginning_of_hour
        
        changeset = Crecto::Repo.insert(u)
        changeset.instance.id.should_not eq(nil)
        changeset.instance.created_at.should_not eq(nil)
        changeset.instance.updated_at.should_not eq(nil)
      end

      it "should use the correct primary key and created_at fields" do
        u = UserDifferentDefaults.new
        u.name = "tedd"

        changeset = Crecto::Repo.insert(u)

        changeset.instance.user_id.should_not eq(nil)
        changeset.instance.xyz.should_not eq(nil)
      end

      it "should return a changeset and set the changeset action" do
        u = UserDifferentDefaults.new
        u.name = "test"

        changeset = Crecto::Repo.insert(u)

        changeset.is_a?(Crecto::Changeset::Changeset).should eq(true)
        changeset.action.should eq(:insert)
      end
    end

    describe "#all" do
      it "should return rows" do
        query = Crecto::Repo::Query
          .where(name: "fridge")
          .where("users.things < 124")
          .order_by("users.name ASC")
          .order_by("users.things DESC")
          .limit(1)
        users = Crecto::Repo.all(User, query)
        users = users.as(Array)
        users.as(Array).size.should be > 0
      end

      it "should accept an array" do
        query = Crecto::Repo::Query
          .where(name: ["fridge", "steve"])

        users = Crecto::Repo.all(User, query)
        users = users.as(Array)
        users.size.should be > 0

        query = Crecto::Repo::Query
          .where(things: [123, 999])

        users = Crecto::Repo.all(User, query)
        users = users.as(Array)
        users.size.should be > 0
      end
    end

    describe "#get" do
      it "should return a user" do
        user = Crecto::Repo.get(User, 1121).as(User)
        user.is_a?(User).should eq(true)
        user.id.should eq(1121)
        user.some_date.should eq(Time.now.at_beginning_of_hour)
      end
    end

    describe "#get_by" do
      it "should return a row" do
        user = Crecto::Repo.get_by(User, name: "fridge", id: 1121).as(User)
        user.id.should eq(1121)
        user.name.should eq("fridge")
      end
    end

    describe "#update" do
      it "should update the model" do
        u = User.new
        u.name = "fridge"
        u.things = 123
        u.nope = 12.45432
        u.yep = false
        u.stuff = 9993
        
        changeset = Crecto::Repo.insert(u)
        u = changeset.instance
        u.name = "new name"
        changeset = Crecto::Repo.update(u)
        
        changeset.instance.name.should eq("new name")
        changeset.valid?.should eq(true)
        changeset.instance.updated_at.as(Time).epoch_ms.should be_close(Time.now.epoch_ms, 2000)
      end

      it "should return a changeset and set the changeset action" do
        u = UserDifferentDefaults.new
        u.name = "test"

        changeset = Crecto::Repo.insert(u)
        u = changeset.instance
        u.name = "changed"

        changeset = Crecto::Repo.update(u)

        changeset.is_a?(Crecto::Changeset::Changeset).should eq(true)
        changeset.action.should eq(:update)
      end
    end

    describe "#delete" do
      it "should delete the model" do
        u = User.new
        u.name = "fridge"
        u.things = 123
        u.nope = 12.45432
        u.yep = false
        u.stuff = 9993
        
        changeset = Crecto::Repo.insert(u)
        u = changeset.instance
        changeset = Crecto::Repo.delete(u)
      end

      it "should return a changeset and set the changeset action" do
        u = UserDifferentDefaults.new
        u.name = "test"

        changeset = Crecto::Repo.insert(u)
        u = changeset.instance

        changeset = Crecto::Repo.delete(u)

        changeset.is_a?(Crecto::Changeset::Changeset).should eq(true)
        changeset.action.should eq(:delete)
      end
    end
  end 
end