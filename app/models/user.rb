class User < ApplicationRecord
  self.table_name = 'User'

  def self.Validate?(params)
    User.ValidateNick(params[:nick]) and
    User.ValidatePassword(params[:password], params[:password_confirmation])
  end

  def self.ValidateNick(nick)
    nick.length > 3 and User.GetUserByNick(nick).nil?
  end

  def self.ValidatePassword(password, password_confirmation)
    password.length >= 6 and password == password_confirmation
  end

  def self.CreateUser(nick, password, salt)
    #User.find_by_sql(["INSERT INTO User (nick, password, salt) VALUES (?, ?, ?)", nick.to_s, password, salt])
    st = ActiveRecord::Base.connection.raw_connection.prepare("INSERT INTO User (nick, password, salt) VALUES (?, ?, ?)")
    st.execute(nick.to_s, password, salt)
    st.close
  end

  def self.GetUserByNick(nick)
    User.find_by_sql(["SELECT * FROM User WHERE nick=?", nick.to_s]).first
  end

  def self.GetUserById(id)
    User.find_by_sql(["SELECT * FROM User WHERE id=?", id.to_i]).first
  end

  def self.Authenticate(nick, password)
    user = User.GetUserByNick(nick)
    user and user.password == BCrypt::Engine.hash_secret(password, user.salt)
  end

  def updateNick(nick)
    self.nick = nick.to_s
    st = ActiveRecord::Base.connection.raw_connection.prepare("UPDATE User SET nick=? WHERE id=?")
    st.execute(self.nick, self.id)
    st.close
    #User.find_by_sql(["UPDATE User SET nick=? WHERE id=?", self.nick, self.id])
  end

  def updatePassword(password)
    self.salt = BCrypt::Engine.generate_salt
    self.password = BCrypt::Engine.hash_secret(password, self.salt)
    st = ActiveRecord::Base.connection.raw_connection.prepare("UPDATE User SET password=?, salt=? WHERE id=?")
    st.execute(self.password, self.salt, self.id)
    st.close
    #User.find_by_sql(["UPDATE User SET password=?, salt=? WHERE id=?", self.password, self.salt, self.id])
  end

  def changeAdminStatus(admin)
    self.admin = admin
    st = ActiveRecord::Base.connection.raw_connection.prepare("UPDATE User SET admin=? WHERE id=?")
    st.execute((self.admin ? 1 : 0), self.id)
    st.close
    #User.find_by_sql(["UPDATE User SET admin=? WHERE id=?", (self.admin ? 1 : 0), self.id])
  end

  def newLogin
    time = Time.now.getutc.strftime('%Y-%m-%d %H:%M:%S')
    self.last_login = time
    st = ActiveRecord::Base.connection.raw_connection.prepare("UPDATE User SET last_login=? WHERE id=?")
    st.execute(time, self.id)
    st.close
    #User.find_by_sql(["UPDATE User SET last_login=? WHERE id=?", time, self.id])
  end
end
