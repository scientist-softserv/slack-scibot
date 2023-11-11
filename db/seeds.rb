# frozen_string_literal: true

Group.find_or_create_by(name: 'devops') do |group|
  group.description = 'SoftServ DevOps Team'
end

Member.find_or_create_by(member_id: 'U02QC5MTU8N') do |member|
  member.handle = 'april'
  member.name = 'April Rieger'
  member.group = Group.find_by(name: 'devops')
end
