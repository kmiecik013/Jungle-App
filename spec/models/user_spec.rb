require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it "can save correctly with all required information entered" do 
      @user = User.create(
        first_name: "John",
        last_name: "Rambo",
        email: "johnrambo@testmail.com",
        password: "password",
        password_confirmation: "password"
      )

    expect(@user).to be_valid
    end

    it "is invalid if a first name is not entered" do 
      @user = User.create(
        first_name: nil,
        last_name: "Rambo",
        email: "johnrambo@testmail.com",
        password: "password",
        password_confirmation: "password"
      )

    expect(@user).not_to be_valid
    expect(@user.errors.full_messages).to eq(["First name can't be blank"])
    end

    it "is invalid if a last name is not entered" do 
      @user = User.create(
        first_name: "John",
        last_name: nil,
        email: "johnrambo@testmail.com",
        password: "password",
        password_confirmation: "password"
      )

    expect(@user).not_to be_valid
    expect(@user.errors.full_messages).to eq(["Last name can't be blank"])
    end

    it "is invalid if an email is not entered" do 
      @user = User.create(
        first_name: "John",
        last_name: "Rambo",
        email: nil,
        password: "password",
        password_confirmation: "password"
      )
    expect(@user).not_to be_valid
    expect(@user.errors.full_messages).to eq(["Email can't be blank"])
    end

    it "is invalid if an email already exists" do 
      @user1 = User.create(
        first_name: "John",
        last_name: "Rambo",
        email: "johnrambo@testmail.com",
        password: "password",
        password_confirmation: "password"
      )
      @user2 = User.create(
        first_name: "John",
        last_name: "Rambo",
        email: "johnrambo@testmail.com",
        password: "password",
        password_confirmation: "password"
      )
    expect(@user2).not_to be_valid
    end

    it "returns invalid if the password does not meet minimum length requirements" do 
      @user = User.create(
        first_name: "John",
        last_name: "Rambo",
        email: "johnrambo@testmail.com",
        password: "pass",
        password_confirmation: "pass"
      )
    expect(@user).not_to be_valid
    end
  end


  describe '.authenticate_with_credentials' do
      # examples for this class method here 
    it "should be valid when correct information is entered" do
      @user = User.create(
        first_name: "John",
        last_name: "Rambo",
        email: "johnrambo@testmail.com",
        password: "password",
        password_confirmation: "password"
      )
      loginInfo = User.authenticate_with_credentials(@user.email, @user.password)
      expect(loginInfo.id).to eq(@user.id)
    end

    it "should still authenticate with extra whitespace in thier email address" do
      @user = User.create(
        first_name: "John",
        last_name: "Rambo",
        email: "johnrambo@testmail.com",
        password: "password",
        password_confirmation: "password"
      )
      loginInfo = User.authenticate_with_credentials("   johnrambo@testmail.com", @user.password)
      expect(loginInfo.id).to eq(@user.id)
    end

    it "should still authenticate when mixed cases are used for the email address" do
      @user = User.create(
        first_name: "John",
        last_name: "Rambo",
        email: "johnrambo@testmail.com",
        password: "password",
        password_confirmation: "password"
      )

      loginInfo = User.authenticate_with_credentials("joHnrAmbo@tEstmail.com", @user.password)
      expect(loginInfo).not_to be(nil)
    end

  end

end