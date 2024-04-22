from sqlalchemy import Column, Integer, String, DateTime
from database.database import db

class User(db.Model):
  __tablename__ = 'users'

  id = Column(Integer, primary_key=True, autoincrement=True)
  name = Column(String(50), nullable=False)
  email = Column(String(50), nullable=False)
  password = Column(String(50), nullable=False)

  def __repr__(self):
    return f'<User:[id:{self.id}, name:{self.name}, email:{self.email}, password:{self.password}]>'
  
  def serialize(self):
    return {
      "id": self.id,
      "name": self.name,
      "email": self.email,
      "password": self.password}

class Task(db.Model):
    __tablename__ = 'tasks'

    id = Column(Integer, primary_key=True)
    name = Column(String(100), nullable=False)
    description = Column(String(255), nullable=True)
    start_date = Column(DateTime, nullable=False)
    end_date = Column(DateTime, nullable=False)

    def __repr__(self):
        return f'<Task id:{self.id}, name:{self.name}, start_date:{self.start_date}, end_date:{self.end_date}>'

    def serialize(self):
        return {
            "id": self.id,
            "name": self.name,
            "description": self.description,
            "start_date": self.start_date.isoformat(),
            "end_date": self.end_date.isoformat()
        }