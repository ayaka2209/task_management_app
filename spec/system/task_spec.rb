require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    Task.delete_all
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task_title", with: '掃除'
        fill_in "task_content", with: '換気扇の掃除'
        # fill_in "task[task_expired]", with: '2022/10/29'
        click_on "登録する"
        # click_on "終了期限でソートする"

        # binding.irb
        expect(page).to have_content '掃除'
        expect(page).to have_content '換気扇の掃除'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        # save_and_open_page
        expect(page).to have_content '掃除'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content '病院に電話' 
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        @task = FactoryBot.create(:task)
        visit task_path(@task.id)
          # save_and_open_page
        expect(page).to have_content '掃除'
				task = FactoryBot.create(:task, title: 'task')
				visit tasks_path
				expect(page).to have_content 'task'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        @task = FactoryBot.create(:task, title: '掃除')
				visit tasks_path(@task.id)
				expect(page).to have_content '掃除'
      end
    end
  end
  describe '終了期限でソート' do
    context '終了期限でソートするというリンクを押した時' do
      it '終了期限の降順に並び替えられる' do
        FactoryBot.create(:task)
        FactoryBot.create(:second_task)
        FactoryBot.create(:third_task)
        visit tasks_path
        click_on "終了期限でソートする"
        sleep(1)
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'お買い物' 
      end
    end
  end
  describe '検索機能'
  before do
    visit tasks_path
  end
  context 'タイトルであいまい検索した時' do
    it '検索キーワード含むタスクで絞り込まれる' do
      fill_in 'task[title]', with: '掃除'
      click_on "検索"
      expect(page).to have_content '掃除'
    end
  end
  context 'ステータス検索をした場合' do
    it "ステータスに完全一致するタスクが絞り込まれる" do
      select '完了', from: 'task[status]'
      click_on "検索"
      expect(page).to have_content '完了'
    end
  end
  context 'タイトルのあいまい検索とステータス検索をした場合' do
    it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
      fill_in 'task[title]', with: '掃除'
      select '未着手', from: 'task[status]'
      click_on "検索"
      expect(page).to have_content '掃除'
      expect(page).to have_content '未着手'
    end
  end
end