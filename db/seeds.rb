Group.find_or_create_by(name: 'devops') do |group|
  group.description = 'SoftServ DevOps Team'
end

Group.find_or_create_by(name: 'gcsupport') do |group|
  group.description = 'Glass Canvas Support Team'
end

Group.find_or_create_by(name: 'gcdev') do |group|
  group.description = 'Glass Canvas Dev Team'
end

Member.find_or_create_by(handle: 'rob') do |member|
  member.name = 'Rob Kaufman'
  member.group = Group.find_by(name: 'devops')
  member.member_id = 'U0E347KGF'
end

Member.find_or_create_by(handle: 'crystal') do |member|
  member.name = 'Crystal Richardson'
  member.group = Group.find_by(name: 'devops')
end

Member.find_or_create_by(handle: 'stefan') do |member|
  member.name = 'Stefan'
  member.group = Group.find_by(name: 'gcdev')
end
