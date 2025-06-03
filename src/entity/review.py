from sqlalchemy import Column, String, Integer, BigInteger, ForeignKey
from sqlalchemy.orm import relationship
from .base import Base

class Review(Base):
    __tablename__ = 'review'

    review_id = Column(BigInteger, primary_key=True, autoincrement=True)
    match_id = Column(BigInteger, ForeignKey('match.match_id'), nullable=False, unique=True)
    comment = Column(String, nullable=True)
    rate = Column(Integer, nullable=True)

    match = relationship('Match', back_populates='review') 