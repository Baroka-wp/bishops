10.times do |n|
  avatar = Faker::Avatar.image
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "000000"
  User.create!(avatar: name,
               name: name,
               email: email,
               password: password,
               password_confirmation: password,
               confirmed_at: Time.now
               )
end
Startup.create( [
  name:'BangBang',
  contact:"22967153975",
  trade_registre:"2296700215397002205",
  adresse: "rue bénin 229 doo",
  sector_of_business: "it",
  resume: "On the other hand, we denounce with
  righteous indignation and dislike men who are so beguiled and demoralized by
   the charms of pleasure of the moment, so blinded by desire, that they cannot
    foresee the pain and trouble that are bound to ensue; and equal blame belongs
    to those who fail in their duty through weakness of will, which is the same as
    saying through shrinking from toil and pain. These cases are perfectly simple and
     easy to distinguish. In a free hour, when our power of choice is untrammelled and
   when nothing prevents our being able to do what we like best, every pleasure",
  user_id:"13"
  ])
  Startup.create( [
    name:'RUCH',
    contact:"22967153975",
    trade_registre:"2296700215397002205",
    adresse: "rue bénin 229 doo",
    sector_of_business: "it",
    resume: "On the other hand, we denounce with
    righteous indignation and dislike men who are so beguiled and demoralized by
     the charms of pleasure of the moment, so blinded by desire, that they cannot
      foresee the pain and trouble that are bound to ensue; and equal blame belongs
      to those who fail in their duty through weakness of will, which is the same as
      saying through shrinking from toil and pain. These cases are perfectly simple and
       easy to distinguish. In a free hour, when our power of choice is untrammelled and
     when nothing prevents our being able to do what we like best, every pleasure",
    user_id:"12"
    ])
    Startup.create( [
      name:'Margo',
      contact:"22967153975",
      trade_registre:"2296700215397002205",
      adresse: "rue bénin 229 doo",
      sector_of_business: "it",
      resume: "On the other hand, we denounce with
      righteous indignation and dislike men who are so beguiled and demoralized by
       the charms of pleasure of the moment, so blinded by desire, that they cannot
        foresee the pain and trouble that are bound to ensue; and equal blame belongs
        to those who fail in their duty through weakness of will, which is the same as
        saying through shrinking from toil and pain. These cases are perfectly simple and
         easy to distinguish. In a free hour, when our power of choice is untrammelled and
       when nothing prevents our being able to do what we like best, every pleasure",
      user_id:"15"
      ])
      Startup.create( [
        name:'BangBang',
        contact:"22967153975",
        trade_registre:"2296700215397002205",
        adresse: "rue bénin 229 doo",
        sector_of_business: "it",
        resume: "On the other hand, we denounce with
        righteous indignation and dislike men who are so beguiled and demoralized by
         the charms of pleasure of the moment, so blinded by desire, that they cannot
          foresee the pain and trouble that are bound to ensue; and equal blame belongs
          to those who fail in their duty through weakness of will, which is the same as
          saying through shrinking from toil and pain. These cases are perfectly simple and
           easy to distinguish. In a free hour, when our power of choice is untrammelled and
         when nothing prevents our being able to do what we like best, every pleasure",
        user_id:"9"
        ])
        Startup.create( [
          name:'gaf',
          contact:"22967153975",
          trade_registre:"2296700215397002205",
          adresse: "rue bénin 229 doo",
          sector_of_business: "it",
          resume: "On the other hand, we denounce with
          righteous indignation and dislike men who are so beguiled and demoralized by
           the charms of pleasure of the moment, so blinded by desire, that they cannot
            foresee the pain and trouble that are bound to ensue; and equal blame belongs
            to those who fail in their duty through weakness of will, which is the same as
            saying through shrinking from toil and pain. These cases are perfectly simple and
             easy to distinguish. In a free hour, when our power of choice is untrammelled and
           when nothing prevents our being able to do what we like best, every pleasure",
          user_id:"16"
          ])

          Startup.create( [
            name:'gari',
            contact:"22967153975",
            trade_registre:"2296700215397002205",
            adresse: "rue bénin 229 doo",
            sector_of_business: "it",
            resume: "On the other hand, we denounce with
            righteous indignation and dislike men who are so beguiled and demoralized by
             the charms of pleasure of the moment, so blinded by desire, that they cannot
              foresee the pain and trouble that are bound to ensue; and equal blame belongs
              to those who fail in their duty through weakness of will, which is the same as
              saying through shrinking from toil and pain. These cases are perfectly simple and
               easy to distinguish. In a free hour, when our power of choice is untrammelled and
             when nothing prevents our being able to do what we like best, every pleasure",
            user_id:"4"
            ])

            Startup.create( [
              name:'real',
              contact:"22967153975",
              trade_registre:"2296700215397002205",
              adresse: "rue bénin 229 doo",
              sector_of_business: "it",
              resume: "On the other hand, we denounce with
              righteous indignation and dislike men who are so beguiled and demoralized by
               the charms of pleasure of the moment, so blinded by desire, that they cannot
                foresee the pain and trouble that are bound to ensue; and equal blame belongs
                to those who fail in their duty through weakness of will, which is the same as
                saying through shrinking from toil and pain. These cases are perfectly simple and
                 easy to distinguish. In a free hour, when our power of choice is untrammelled and
               when nothing prevents our being able to do what we like best, every pleasure",
              user_id:"7"
              ])
