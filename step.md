# SCRIPT DE DEVELOPPEMENT

## step 1 : POST STARTUP FUNCTION

* créer la base de donner `rails db:create`
* créer la table startup `rails g model Startup name:string logo:text resume:text telephone:string trade_register:string adresse:text type_of_business:text banner:text`
* créer la base de donner `rails db:migrate`
* créer la base de donner `rails g controller startups`

### config/routes

> root 'startups#index'
> resources :startups

### app/views/startups

* creer `index.html.erb`
* creer `_form.html.erb`
* creer `new.html.erb`
* creer `show.html.erb`
* creer `show.html.erb`
#### app/gemfile
ajouter les gem pour uploader les images
`gem 'mini_magick'`
`gem 'gem 'carrierwave', '~> 2.0'`

faire `bundle install`

#### creer les uploader
* `rails g uploader logo`
* `rails g uploader banner`
* `rails g uploader description`

#### app/models/startup.rb
définir les validations 

>  validates :name, presence:true, null:false
>  validates_word_count :resume,:minimum =>150,:too_few_words => "votre résumé  est trop court (doit contenir 150 mots au moins)"
>  validates :resume, presence:true, null:false
>  validates :logo, presence:true, null:false

definir les uploaders
> mount_uploader :logo, LogoUploader
> mount_uploader :descrption, DecriptionUploader
> mount_uploader :banner, BannerUploader

#### app/view/layout/application.html.erb
définir les messages d'erreur

  `<div class="flash">
      <% flash.each do |key, value|%>
        <%= content_tag(:div,value,class:"alert alert-#{key}")%>
      <% end%>
    </div>`

##### pour les videos et images 
dans le view definir le code suivant pour aficher.

  * pour afficher video (de description) `<p><strong> description </strong> : <video controls width="100%" height="360px" src="<%= @startup.descrption %>"></video></p>` 
  * pour afficher images (logo ) `<p><%= image_tag @startup.logo.url %></p>` 



## step 2 : DEVISE FUNCTION (User create, authentification, Oauth )
### CONFIG MAILER

>  créer la base de donner `rails g mailer ContactMailer`

#### app/gemfile
ajouter les gem 
 `gem 'letter_opener_web'`
`gem 'devise'`
faire  `bundle install`

#### config/routes
ajouter la route pour le mailer

>   mount LetterOpenerWeb::Engine, at: "/inbox" if Rails.env.development?
verifier (http://localhost:3000/inbox/)[http://localhost:3000/inbox/]


#### config/environnement/developpement.rb
appliquer la configuration pour le mailer

>  config.action_mailer.default_url_options = { host: 'localhost:3000' }
>  config.action_mailer.delivery_method = :letter_opener_web

#### app/mailer/contact_mailer.rb

ajouter la configuration pour delivrer le mail

 `def contact_mail(startup)
   @startup = startup
   mail to: "birotori@gmailcom", subject: "vous avez publier votre startup sur bishop"
  end`
  
#### app/contact_mailer/contact_mail.html.erb
créer le model de mail.

#### app/controller/startup_controller
ajouter cette ligne de code dans le def create (envoyer le mail après enregistrement
> `ContactMailer.contact_mail(@startup).deliver`

### CONFIG DIVISE
* faire  `rails generate devise:install`
s'assurer qu'il un `root to: index#home` définit
* faire  `rails g devise:views`
pour créer l'ensemble des view associés à Devise
* faire  `rails generate devise user`
pour créer le model User.rb
* faire  `rails generate devise user`
Voir la migration crée pour user. Il faut décommenter la partie concernant le mail de confirmation (si l'app le nécessite)
ajouter des colonnes (comme name, ou autre dans la migration)
* faire  `rails db:migrate`
#### associer startup et user
* faire  `rails c`
supprimer les enregistrements actuels pour ne pas produire des conflits `# Startup.delete_all` ensute sortir de la console
générer l'index du User dans la table Startup
* faire  `rails g migration AddUserRefToStartup user:references`
*  `rails db:migrate`

##### app/controller/startup_controller.rb
ajouter l'id du user à l'enregistrement `def create` de la startup

`@startup.user_id = current_user.id`

* empêcher à l'utilisateur de publier ou éditer ou supprimer sans être connecter ou s'il n'est pas propiétaire
vérifier que l'utilisateur est connecté
`def login_check
    redirect_to new_user_registration_path, notice:('you are not login, please login or create new accompt') unless user_signed_in?
  end`
  
 vérifier que l'utilisateur connecté est le propriétaire 
` def user_check
    redirect_to startups_path, notice:('access deny') unless current_user == @startup.user_id
  end`
ajouter les collback 
  `before_action :login_check, only: [:new, :edit, :destroy]
   before_action :user_check, only: [:edit, :destroy]`


pour ajouter un avatar à l'utilisateur:

* `rails active_storage:install`
* `rails db:migrate`
ajouter la gem gem `'image_processing', '~> 1.2'`
*  `bundle install`

**ajouter les champs de l'avatar dans app/views/devise/registrations/new.html.erb**

> <div class="field">
>    <%if resource.avatar.attached?%>
>      <%=image_tag(resource.avatar)  %>
>    <% else %>
>      <%=image_tag("/default-avatar.jpg") %>
>    <% end %>
>  </div>
>  <div class="field">
>      <%= f.file_field :avatar, autofocus: true, autocomplete: "avatar" %>
>  </div>
  
**ajouter les champs de l'avatar dans app/views/devise/registrations/new.html.erb**

> <div class="field" >
>     <%=image_tag(resource.avatar_thumbnail) if resource.avatar.attached?%><br />
>   </div>

>   <div class="field">
>     <%= f.file_field :avatar, autofocus: true, autocomplete: "avatar" %>
>   </div>
  
**app/models/user.rb**
ajouter : 
> has_one_attached :avatar

et définir la fonction de l'avatar par défaut)

> def avatar_thumbnail
>    if avatar.attached?
>      avatar.variant(resize: "150x150!").processed
>    else
>      "/default-avatar.jpg"
>    end
>  end

*ne pas oubliez d'ajouter l'image dans le dossiers publics
pour afficher l'avatar:
`<span> <%= image_tag (current_user.avatar_thumbnail), style: 'height:50px;width:50px;'%> </span>`

### CONFIG OAuth

* ajouter les gem
 ` gem'devise' `
 ` gem'omniauth'` 
 ` gem'omniauth-google-oauth2'`
 faire `bundle install`

Ajouter dans la migration Devise User 
les colonnes suivantes
>   t.string :provider, null: false, default: ""
>   t.string :uid, null: false, default: ""
>   add_index :users, [:uid, :provider], unique: true

* faire `rails g controller users::registrations`
ajouter ce code à app/controllers/users/registrations_controllers.rb

  `def build_resource(hash={})
    hash[:uid] = User.create_unique_string
    super
  end`

* Créez une méthode create_unique_string qui crée un uid aléatoire.
app/models/user.rb
  `def self.create_unique_string
    SecureRandom.uuid
  end`

* définir la routes config/routes
>  devise_for :users, controllers: {
>  
>  }

* complèter les validations à user.rb
app/models/user.rb
> devise :database_authenticatable, :registerable,
>         :recoverable, :rememberable, :validatable, :confirmable,
>         :omniauthable, omniauth_providers: %i(google)


* definir le code pour créer un utilisateur avec les informations extérieurs envoyées par google
app/models/user.rb
`def self.find_for_google(auth)
    user = User.find_by(email: auth.info.email)
    unless user
    user = User.new(email: auth.info.email,
                      provider: auth.provider,
                      uid:      auth.uid,
                      password: Devise.friendly_token[0, 20],
                                   )
    end
    user.save
    user
  end`
  
* Définissez les paramètres pour lire les valeurs (ID client et secret) requises pour l'authentification OAuth acquise par Google
ajouter le code suivant dans config/initializers/devise.rb

`config.omniauth :google_oauth2, ENV['GOOGLE_APP_ID'], ENV['GOOGLE_APP_SECRET'], name: :google`

  créer le fichier `.env` pour ajouter les paramettres de Google (https://console.developers.google.com/cloud-resource-manager?pli=1)
  Ne pas oublier de mettre .env dans `.gitignore`

* ajouter les gem
 ` gem 'dotenv-rails' `
 faire `bundle install`
 
 
* le lien pour la connection est :  
> <%= link_to "s'inscrire avec Google", user_google_omniauth_authorize_path %>
> <%= link_to "se connecter avec Google", user_google_omniauth_authorize_path %>

 * config/routes
ajouter `omniauth_callbacks: "users/omniauth_callbacks"` dans le routage de devises_for

créer un ficher omniauth_callbacks_controllers et ajouter le code 

 `class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google
    @user = User.find_for_google(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "google") if is_navigational_format?
    else
      session['devise.google_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end`

** ajouter la route dans es paramettre de google
https://console.developers.google.com/apis/credentials/oauthclient/98071276676-6c5tk99q2le2f1bqqskdjpbrbu0o58ht.apps.googleusercontent.com?project=precise-asset-277210

> http://localhost:3000/users/auth/google/callback

## relationship function

* générer le controller de User
`rails g devise:User`

Il faut commencer par définir un index pour voir la liste des users, et un show pour afficher les profils:
ensuite suivre les étapes 

###### app/models/userrb

 `has_many :active_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :passive_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower`


> #Suivre l'utilisateur spécifié

>  def follow!(other_user)
>    active_relationships.create!(followed_id: other_user.id)
>  end

> #Vérifiez si #Follow
  
>  def following?(other_user)
>    active_relationships.find_by(followed_id: other_user.id)
>  end
>  #Annuler le suivi de l'utilisateur spécifié
>  def unfollow!(other_user)
>    active_relationships.find_by(followed_id: other_user.id).destroy
>  end

**définir la route**
> resources :relationships, only: [:create,:index,:destroy]

**app/views/relationships/create.js.erb**
> $("#follow_form_"+"<%= @user.id %>").html("<%= escape_javascript(render partial: 'users/follow_form', locals: { user: @user } ) %>")


**app/views/relationships/destroy.js.erb**
> $("#follow_form_"+"<%= @user.id %>").html("<%= escape_javascript(render partial: 'users/follow_form', locals: { user: @user } ) %>")


**formulaire d'ajout de la relation app/views/users/_follow_form.htlm.erb**

> <span id="follow_form_<%= user.id %>">
>  <% unless current_user.following?(user) %>
>      <%= form_with(model: current_user.active_relationships.build(followed_id: user.id))  do |f| %>
>        <%= f.hidden_field :followed_id %>
>        <%= f.submit "Devenir partenaire" %>
>      <% end %>
>  <% else %>
>      <%= form_with(model: current_user.active_relationships.find_by(followed_id: user.id), method: :delete ) > do |f| %>
>        <%= f.submit "ne plus suivre" %>
>  <% end %>
> </span>
 
* dans l'index user ajouter le code suivant pour afficher le bouton de suivie
 
> <% @users.each do |user| %> 
> <% if user_signed_in?%>
>     <% unless current_user.id == user.id  %>
>        <span> <%= render 'follow_form', user: user %></span>
>    <% end %>
> <% end %>
> <% end %>
   

* pour pouvoir afficher les suiveurs et les suivis il faut définir dans le controller (relationships_controllers .rb)
>  @users = User.all / @user = User.find(params[:id])
>    @users.each do |user|
>      @followers = user.followers
>      @following = user.following
>    end
   
   
 ## RATING FUNTION (Favoris)
 les utilisateur peuvent contribuer à la promotion d'une startup en l'ajoutant dans ses startup favoris. Il il y aura un compte des favoris et le startup en tête des compte sera affiché en premier.
 
* ` rails g controller favorites `
* ` rails db:migrate`

créer les relations de tables
**app/models/user.rb**
 ` has_many :favorites, dependent: :destroy`
 
**app/models/startup.rb**
  `has_many :favorites, dependent: :destroy`
  `has_many :favorite_users, through: :favorites, source: :user`
  
  **app/models/favorite.rb**
    ` belongs_to :user`
    ` belongs_to :startup`
    
  **app/controllers/favorite_controllers**
  
 >  def create
 >   favorite = current_user.favorites.create(startup_id: params[:startup_id])
 >   flash[:success] = "Merci pour votre contribution à #{favorite.startup.name}"
 > end
 > def destroy
 >   favorite = current_user.favorites.find_by(id: params[:id]).destroy
 >   flash[:success] = "Vous n'êtes plus contributeur de #{favorite.startup.name}"
 > end
   
   **app/controllers/startup_controllers**
   
 > def show
 >  @favorite = @startup.favorites.find_by(startup_id: @startup.id)
 > end


* pour afficher le bouton dans le view (startup)

> <% if user_signed_in? %>
>      <% unless @startup.user_id == current_user.id %>
>          <% if @favorite.present? %>
>            <span> <em> --Vous êtes déjà contributeur de cette startup --</em></span>
>          <% else %>
>            <button type="button" name="button"> <%= link_to 'CONTRIBUER',  favorites_path(startup_id: @startup.id)%></button>
          <% end %>
      <% end %>
 > <% end %>
        
        
  ##RSPEC
  installer les gemfile
  
  $ bundle exec spring binstub rspec


-générer les fichier rspec
rails generate rspec: install

dans .rspec
ajouter  : 
--format documentation


dans config/application.rb

omit
  class Application < Rails::Application
omit
    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: false,
        request_specs: false
      g.fixture_replacement :factory_bot, dir: "spec/factories"
    end
  end
end

**bin/rspec**
pour vérifier les tests
