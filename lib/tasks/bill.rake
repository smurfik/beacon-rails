desc "Display all of organizations"
task :bill_all_orgs => :environment do
  orgs = Organization.all
  orgs.each do |org|
    number_of_users = org.users.count
    invoice = Stripe::Charge.list(customer: org.stripe_id, created: {gt: 1.months.ago.to_i}, limit: 1)
    if invoice.data.empty? && org.stripe_id.present?
      Stripe::Charge.create({
        :amount => number_of_users * 1000,
        :currency => "usd",
        :customer => org.stripe_id,
        :description => "Charge for #{org.name}"
      })
    end
  end
  puts orgs.count
end
