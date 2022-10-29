FactoryBot.define do
	factory :task do
		title { '掃除' }
		content { '換気扇の掃除' }
		# created_at { '2022/10/29' }
	end
	factory :second_task, class: Task do
		title { 'お買い物' }
		content { 'お弁当のおかず買う' }
		# created_at { '2022/10/30' }
	end
	factory :third_task, class: Task do
		title { '病院に電話' }
		content { '予防接種予約' }
		# created_at { '2022/10/28' }
	end
end