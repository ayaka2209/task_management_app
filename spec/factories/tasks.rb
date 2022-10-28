FactoryBot.define do
	factory :task do
		title { '掃除' }
		content { '換気扇の掃除' }
	end
	factory :second_task, class: Task do
		title { 'お買い物' }
		content { 'お弁当のおかず買う' }
	end
end