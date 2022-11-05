require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  describe 'ユーザー新規登録機能' do
    context '一般ユーザーがsign upした場合' do
      it '作成したユーザーが表示される' do
        visit new_user_path
        fill_in "user[user_name]",with: 'テスト花子'
        fill_in "user[email]",with: 'testhanako@icloud.com'
        fill_in "user[password]",with: 'password'
        fill_in "user[password_confirmation]",with: 'password'
        click_on "Create my account"
        expect(page).to have_content 'テスト花子'
      end
    end 
    context 'ユーザーがログインせずに、タスク一覧画面に飛ぼうとした時' do
      it 'ログイン画面に遷移する' do
        visit new_user_path
        visit tasks_path
        expect(page).to have_content 'Email'
        expect(page).to have_content 'Password'
      end
    end
  end
  describe 'セッション機能' do
    before do
      FactoryBot.create(:user)
      visit new_session_path
      fill_in "session[email]",with: 'testhanako@icloud.com'
      fill_in "session[password]",with: 'password'
      click_on "Log in"
    end
    context 'ログインした場合' do
      it '詳細画面に飛ぶ' do
      expect(page).to have_content 'テスト花子のページ'
      end
    end
    context 'ユーザーが他人の詳細画面に飛ぼうとする' do
      it '自分のタスク一覧画面に遷移する' do
        click_on "タスク一覧"
        visit tasks_path(id:0)
        expect(page).to have_content 'タスク一覧'
        # binding.irb
      end
    end
    context 'ログアウトした場合' do
      it 'Log inページに飛ぶ' do
        click_on "Logout"
        # visit new_session_path
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
  describe '管理画面のテスト' do
    before do
      # FactoryBot.create(:admin_user)
      visit new_session_path
    end
    context '管理ユーザーの場合' do
      it '管理画面にアクセスができる' do
      FactoryBot.create(:admin_user)
      fill_in "session[email]",with: 'test@icloud.com'
      fill_in "session[password]",with: 'password'
      click_on "Log in"
      visit admin_users_path
      expect(page).to have_content '管理画面ユーザー一覧'
      end
    end
    context '一般ユーザーの場合' do
      it '管理画面にアクセスできない' do
      FactoryBot.create(:user)
      fill_in "session[email]",with: 'testhanako@icloud.com'
      fill_in "session[password]",with: 'password'
      click_on "Log in"
      visit admin_users_path
      # binding.irb
      expect(page).to have_content 'あなたは管理者ではありません'
      end
    end
    context '管理ユーザーの場合' do
      it 'ユーザーの新規登録ができる' do
      FactoryBot.create(:admin_user)
      fill_in "session[email]",with: 'test@icloud.com'
      fill_in "session[password]",with: 'password'
      click_on "Log in"
      visit admin_users_path
      click_on "新規登録"
      expect(page).to have_content 'ユーザー登録'
      end
    end
    context '管理ユーザーの場合' do
      it 'ユーザーの詳細画面にアクセスできる' do
      FactoryBot.create(:admin_user)
      fill_in "session[email]",with: 'test@icloud.com'
      fill_in "session[password]",with: 'password'
      click_on "Log in"
      visit admin_users_path
      click_on "詳細"
      expect(page).to have_content 'のページ'
      end
    end
    context '管理ユーザーの場合' do
      it 'ユーザーの編集画面からユーザー編集ができる' do
      FactoryBot.create(:admin_user)
      fill_in "session[email]",with: 'test@icloud.com'
      fill_in "session[password]",with: 'password'
      click_on "Log in"
      visit admin_users_path
      click_on "編集"
      expect(page).to have_content 'ユーザーの編集'
      end
    end
    context '管理ユーザーの場合' do
      it 'ユーザーの削除ができる' do
      FactoryBot.create(:admin_user)
      fill_in "session[email]",with: 'test@icloud.com'
      fill_in "session[password]",with: 'password'
      click_on "Log in"
      visit admin_users_path
      click_on "削除"
      expect(page.accept_confirm).to eq "本当に削除してもいいですか?"
      expect(page).to have_content '削除しました'
      end
    end
  end
end