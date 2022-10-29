require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
	describe '一覧表機能' do
		FactoryBot.create(:task)
    FactoryBot.create(:task2)
		# let!(:task){ FactoryBot.create(:task) }
		# let!(:task){ FactoryBot.create(:task2) }
		# let!(:task){ FactoryBot.create(:task3) }
		before do
			visit tasks_path
		end
	end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
				visit new_task_path
				# binding.irb
				fill_in "task_title", with: '掃除'
				fill_in "task_content", with: '換気扇の掃除'
				click_on "登録する"
				expect(page).to have_content '掃除'
				expect(page).to have_content '換気扇の掃除'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
				# FactoryBot.create(:task, title: 'task')
				visit tasks_path
				# save_and_open_page
				expect(page).to have_content '掃除'
      end
    end

		context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
				visit tasks_path

      end
		end
  end

  describe '詳細表示機能' do
      context '任意のタスク詳細画面に遷移した場合' do
        it '該当タスクの内容が表示される' do
          @task = FactoryBot.create(:task)
					visit task_path(@task.id)
					# save_and_open_page
					# expect(page).to have_content 'タスク詳細画面'
					expect(page).to have_content '掃除'
					# expect(page).to have_content content
        end
      end
  end
end