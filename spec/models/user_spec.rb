require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '全ての情報が正しく入力されると新規登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'ニックネームが空白だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it 'メールアドレスが空白だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end

      it 'すでに登録されたメールアドレスでは登録できない' do
        @user.save
        other_user = FactoryBot.build(:user)
        other_user.email = @user.email
        other_user.valid?
        expect(other_user.errors.full_messages).to include('Eメールはすでに存在します')
      end

      it 'メールアドレスは、@を含まないと登録できない' do
        @user.email = 'testmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end

      it 'パスワードが空白だと登録できない' do
        @user.password = ''
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end

      it 'パスワードは、6文字以上でないと登録できない' do
        @user.password = 'p1234'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it 'パスワードは、半角数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは文字と数字の両方を含めてください')
      end

      it 'パスワードは、半角英数字のみでは登録できない' do
        @user.password = 'password'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは文字と数字の両方を含めてください')
      end

      it 'パスワードとパスワード（確認）は、値の一致しないと登録できない' do
        @user.password = 'password2'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it 'パスワードは、全角での入力では登録できない' do
        @user.password = 'ｐ１２３４５'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは文字と数字の両方を含めてください')
      end

      it '苗字が空白だと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字を入力してください")
      end

      it '名前がが空白だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end

      it '苗字が半角だと登録できない' do
        @user.last_name = 'ﾐｮｳｼﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字は全角文字で入力してください')
      end

      it '名前が半角だと登録できない' do
        @user.first_name = 'ﾅﾏｴ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前は全角文字で入力してください')
      end

      it '苗字カナが空白だと登録できない' do
        @user.last_name_ruby = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字カナを入力してください")
      end

      it '名前カナが空白だと登録できない' do
        @user.first_name_ruby = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前カナを入力してください")
      end

      it '苗字カナが半角だと登録できない' do
        @user.last_name_ruby = 'ﾐｮｳｼﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字カナは全角カナで入力してください')
      end

      it '苗字カナが全角でもカタカナ以外だと登録できない' do
        @user.last_name_ruby = 'みょうじ'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字カナは全角カナで入力してください')
      end

      it '名前カナが半角だと登録できない' do
        @user.first_name_ruby = 'ﾅﾏｴ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前カナは全角カナで入力してください')
      end

      it '名前カナが全角でもカタカナ以外だと登録できない' do
        @user.first_name_ruby = 'なまえ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前カナは全角カナで入力してください')
      end

      it '生年月日が空白だと登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
