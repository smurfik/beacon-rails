desc "Display all of organizations"
task :bill_all_orgs => :environment do
  orgs = Organization.all
  orgs.each do |org|
    if org.stripe_id.present?
      Stripe::Charge.create({
        :amount => 200,
        :currency => "usd",
        :customer => org.stripe_id,
        :description => "Charge for #{org.name}"
      })
    end
  end
  puts orgs.count
end
