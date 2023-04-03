# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server "31.172.65.115", user: "deployer", primary: true
server "31.172.65.115", user: "deployer", roles: %w{app db web}, primary: true
set :rails_env, :production 

# server "example.com", user: "deploy", roles: %w{app db web}, my_property: :my_value
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}

# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}


# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
 set :ssh_options, {
  keys: %w(C:\Users\vovan\.ssh\id_rsa /home/deployer/.ssh/id_ed25519),
  forward_agent: true,
  auth_methods: %w(publickey password),
  port: 2222
 }

# The server-based syntax can be used to override options:
# ------------------------------------
# server "31.172.65.115",
#   user: "deployer",
#   primary: true,
#   ssh_options: {
#     user: "deployer",
#     keys: %w(C:\Users\vovan\.ssh\id_rsa /home/deployer/.ssh/id_ed25519),
#     # forward_agent: true,
#     auth_methods: %w(publickey password),
#     port: 2222
#   }
