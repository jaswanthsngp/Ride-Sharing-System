import psycopg2

class DBHandler:
	def __init__(this):
		print("Creating Database Connection")
		# database and cursor initialization
		try:
			this.conn = psycopg2.connect("dbname=ridesharing user=postgres password=1234")
			this.cur = this.conn.cursor()
		except(Exception, psycopg2.DatabaseError) as error:
			print(error)
		
		this.cur.execute("select version()")
		print("Connected to "+this.cur.fetchone()[0])

	def __del__(this):
		# closing database connection
		this.cur.close()
		if this.conn is not None:
			this.conn.close()
			print("Database Connection closed")
	
	def validateLogin(this, email, pwd):
		# login form validation. Takes Email and Password, returns user_id if valid
		this.cur.execute(f"select user_id from users where email='{email}' and password='{pwd}'")
		res = this.cur.fetchone()
		if res is not None:
			return res[0]
		return None

	def signUpUser(this, name, email, pwd, role):
		# user signup form, takes required fields and returns user_id on success
		this.cur.execute(f"insert into users(name, email, password, role) values('{name}','{email}','{pwd}','{role}') returning user_id")
		res = this.cur.fetchone()
		if res is not None:
			this.conn.commit()
			return res[0]
		return None
	
	def signUpCompanion(this, name, email, pwd, role, cab_no):
		# special signup for companions, also does the user signup for them
		user_id = this.signUpUser(name, email, pwd, role)
		if user_id is not None:
			this.cur.execute(f"insert into companion(cab_no, user_id) values('{cab_no}',{user_id}) returning cab_no")
			if this.cur.fetchone() is not None:
				this.conn.commit()
				return user_id
		else:
			return None

	def fetchNearestCompanion(this, place):
		# helper function for book ride
		this.cur.execute(f"select loc_x, loc_y from places where place_name='{place}'")
		place_xy = this.cur.fetchone()
		# print(place_xy)
		if place_xy is not None:
			x, y = place_xy
			this.cur.execute(f"select cab_no from companion where occupied=false order by abs(loc_x*loc_y-{x*y})")
			cab_no = this.cur.fetchone()
			if cab_no is not None:
				return cab_no[0]
		return None
	
	def fetchPlaceId(this, place):
		# helper function for book ride
		this.cur.execute(f"select place_id from places where place_name='{place}'")
		place_id = this.cur.fetchone()
		if place_id is not None:
			return place_id[0]
		return None
	
	def bookRide(this, user_id, source, destination):
		# takes user_id, source and destination, assigns companion, returns ride id on success
		companion_id = this.fetchNearestCompanion(source)
		source_id = this.fetchPlaceId(source)
		destination_id = this.fetchPlaceId(destination)
		if companion_id is None or source_id is None or destination_id is None:
			return None
		this.cur.execute(f"update companion set occupied=true where cab_no='{companion_id}'")
		this.cur.execute(f"insert into ride(companion_id, traveler_id, source_id, destination_id) values('{companion_id}', {user_id}, {source_id}, {destination_id}) returning ride_id")
		ride_id = this.cur.fetchone()
		if ride_id is not None:
			this.conn.commit()
			return ride_id[0]
		return None
	
	def finishRide(this, ride_id):
		# Finishes ride by making companion availiable and updating their location
		this.cur.execute(f"select loc_x, loc_y from places join ride on place_id=destination_id where ride_id={ride_id}")
		x, y = this.cur.fetchone()
		this.cur.execute(f"update companion set occupied=false, loc_x={x}, loc_y={y} where cab_no in (select companion_id from ride where ride_id={ride_id}) returning cab_no")
		if this.cur.fetchone() is not None:
			this.conn.commit()
			return True
		return False

	def selectAll(this, tableName):
		this.cur.execute(f'select * from {tableName}')
		print(this.cur.fetchall())

db = DBHandler()

# print(db.validateLogin('user1@example.com','user1'))
# print(db.signUpUser('user3','user3@example.com','user3','traveler'))
# print(db.signUpCompanion('user4', 'user4@example.com', 'user4', 'companion', 'AB07CD6789'))
# db.selectAll('users')
# db.selectAll('companion')
# print(db.fetchNearestCompanion('C'))
# db.fetchPlaceId('B')
# print(db.bookRide(1, 'H', 'D'))
# print(db.finishRide(5))
