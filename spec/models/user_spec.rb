require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'nicknameとemail、passwordとpassword_confirmation、first_nameとlast_name、
       first_name_katakanaとlast_name_katakana、birthdayが存在すれば登録できること' do
      expect(@user).to be_valid
    end

    it 'nicknameが空では登録できないこと' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空では登録できないこと' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it '重複したemailが存在する場合では登録できないこと' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'emailに@が含まれていない場合では登録できないこと' do
      @user.email = FactoryBot.build(:user, email: @user.email)
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'passwordが空では登録できないこと' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが5文字以下であれば登録できないこと' do
      @user.password = '12345'
      @user.password_confirmation = '12345'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'passwordが半角英数字混合ではない場合では登録できないこと' do
      @user.password = 'asdfgh'
      @user.password_confirmation = 'asdfgh'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid')
    end

    it 'passwordとpassword_confirmationが不一致では登録できないこと' do
      @user.password = '123456'
      @user.password_confirmation = '1234567'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'first_nameが空では登録できないこと' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'first_nameが全角（漢字・ひらがな・カタカナ）ではない場合では登録できないこと' do
      @user.first_name = 'asdfgh'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name is invalid')
    end

    it 'last_nameが空では登録できないこと' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'last_nameが全角（漢字・ひらがな・カタカナ）ではない場合では登録できないこと' do
      @user.last_name = 'asdfgh'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name is invalid')
    end

    it 'first_name_katakanaが空では登録できないこと' do
      @user.first_name_katakana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name katakana can't be blank")
    end

    it 'first_name_katakanaが全角（漢字・ひらがな・カタカナ）の場合では登録できないこと' do
      @user.first_name_katakana = 'あいうえお'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name katakana is invalid')
    end

    it 'last_name_katakanaが空では登録できないこと' do
      @user.last_name_katakana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name katakana can't be blank")
    end

    it 'last_name_katakanaが全角（漢字・ひらがな・カタカナ）の場合では登録できないこと' do
      @user.last_name_katakana = 'あいうえお'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name katakana is invalid')
    end

    it 'birthdayが空では登録できないこと' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end
