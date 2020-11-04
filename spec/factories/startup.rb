FactoryBot.define do
 factory :startup do
   name { 'startup1' }
   logo { 'default_logo.png' }
   contact { '67153974' }
   trade_registre { '12003654879' }
   adresse { '22 rue benin' }
   sector_of_business { 'it' }
   banner { 'banner.gif' }
   video { 'https://www.youtube.com/watch?v=sQR2-Q-k_9Y' }
   resume { '"Sed ut perspiciatis unde
     omnis iste natus error sit voluptatem
     accusantium doloremque laudantium,
     totam rem aperiam, eaque ipsa quae ab illo
     inventore veritatis et quasi architecto beatae
      vitae dicta sunt explicabo. Nemo enim ipsam
      voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores
      eos qui ratione voluptatem sequi nesciunt.' }


   association :user
 end
end
