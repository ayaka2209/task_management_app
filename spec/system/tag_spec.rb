require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  # let!(:task) { FactoryBot.create(:task, user: user) }
  let!(:task) { FactoryBot.create(:tag) }
  before do
    visit new_session_path
    fill_in "session[email]",with: 'testhanako@icloud.com'
    fill_in "session[password]",with: 'password'
    click_on "Log in"
  end
  describe 'ラベル登録機能' do
    context 'ラベルにチェックをつけた時' do
      it 'タスク一覧に表示される' do
        visit new_task_path
        fill_in "task_title", with: '掃除'
        fill_in "task_content", with: '換気扇の掃除'
        check "task[tag_ids][]"
        # binding.irb
        click_on "登録する"
        expect(page).to have_content '掃除'
        expect(page).to have_content '換気扇の掃除'
        expect(page).to have_content 'sample5'
      end
    end
  end
end