class User(db.Model): 

    id: Mapped[int] = mapped_column(db.Integer, primary_key=True) 

    username: Mapped[str] = mapped_column(db.String, unique=True, nullable=False) 
