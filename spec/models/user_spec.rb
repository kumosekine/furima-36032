require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できできる場合' do
      it 'nicknameとemail、passwordとpassword_confirmationとfamily_nameとfirst_nameとfamily_name_kanaとfirst_name_kanaとbirthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが英数６文字以上であれば登録できる' do
        @user.password = 'abc123'
        @user.password_confirmation = 'abc123'
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'family_nameが空では登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'family_name_kanaが空では登録できない' do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
      it 'passwordが５文字以下であれば登録できない' do
        @user.password = 'abc12'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが英語のみであれば登録できない' do
        @user.password = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'passwordが数字のみであれば登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'abc456'
        @user.password_confirmation = 'abc4567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'パスワードは全角文字を含むパスワードでは登録できない' do
        @user.password = 'テストabc'
        @user.password_confirmation = 'テストabc'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'メールアドレスに@を含まない場合は登録できない' do
        @user.email = 'test.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it '姓（全角）に半角文字が含まれていると登録できない' do
        @user.family_name = 'abc'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name 全角文字を使用してください')
      end
      it '名（全角）に半角文字が含まれていると登録できない' do
        @user.first_name = 'abc'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name 全角文字を使用してください')
      end
      it '姓（カナ）にカタカナ以外の文字、平仮名が含まれていると登録できない' do
        @user.family_name_kana = 'あいう'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana 全角カナを使用してください')
      end
      it '姓（カナ）にカタカナ以外の文字、漢字が含まれていると登録できない' do
        @user.family_name_kana = '亜井雨'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana 全角カナを使用してください')
      end
      it '姓（カナ）にカタカナ以外の文字、英数字が含まれていると登録できない' do
        @user.family_name_kana = 'アイ1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana 全角カナを使用してください')
      end
      it '姓（カナ）にカタカナ以外の文字、記号が含まれていると登録できない' do
        @user.family_name_kana = 'アイ%'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana 全角カナを使用してください')
      end
      it '名（カナ）にカタカナ以外の文字、平仮名が含まれていると登録できない' do
        @user.first_name_kana = 'あいう'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana 全角カナを使用してください')
      end
      it '名（カナ）にカタカナ以外の文字、漢字が含まれていると登録できない' do
        @user.first_name_kana = '亜井雨'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana 全角カナを使用してください')
      end
      it '名（カナ）にカタカナ以外の文字、英数字が含まれていると登録できない' do
        @user.first_name_kana = 'アイ1'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana 全角カナを使用してください')
      end
      it '名（カナ）にカタカナ以外の文字、記号が含まれていると登録できない' do
        @user.first_name_kana = 'アイ%'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana 全角カナを使用してください')
      end
    end
  end
end
