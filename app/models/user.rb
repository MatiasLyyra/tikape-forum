class User < ApplicationRecord
	self.table_name = 'user'


	def self.Validate?(params)
		params[:nick].length > 3 and
		params[:password].length > 6 and
		params[:password_confirmation] == params[:password] and
		self.GetUserByNick(nick: params[:nick]).nil?
	end

	def self.CreateUser(params, password, salt)
		User.find_by_sql(["INSERT INTO User (nick, password, salt) VALUES (?, ?, ?)", params[:nick], password, salt])
	end

	def self.GetUserByNick(params)
		User.find_by_sql(["SELECT * FROM User WHERE nick=?", params[:nick]]).first
	end

	def self.GetUserById(params)
		User.find_by_sql(["SELECT * FROM User WHERE id=?", params[:id]]).first
	end

	def updateNick
		User.find_by_sql(["UPDATE User SET nick=? WHERE id=?", self.nick, self.id]);
	end

	def updatePassword
		User.find_by_sql(["UPDATE User SET salasana=?, salt=? WHERE id=?", self.password, self.salt, self.id]);
	end

	def newLogin
		time = Time.now.getutc.strftime('%Y-%m-%d %H:%M:%S')
		self.last_login = time
		User.find_by_sql(["UPDATE User SET last_login=? WHERE id=?", time, self.id]);
	end
end
