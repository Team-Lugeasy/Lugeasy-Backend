from sqlalchemy import Column, String, BigInteger, DateTime, Enum, Float, ForeignKey
from sqlalchemy.orm import relationship
from .base import Base
from .state_enum import StateEnum

class Match(Base):
    __tablename__ = 'match'

    match_id = Column(BigInteger, primary_key=True, autoincrement=True)
    host_id = Column(BigInteger, ForeignKey('host.host_id'), nullable=False)
    member_id = Column(BigInteger, ForeignKey('member.member_id'), nullable=False)
    state = Column(Enum(StateEnum), nullable=False)
    indrive_time = Column(DateTime, nullable=False)
    address = Column(String, nullable=False)
    longitude = Column(Float, nullable=False)
    latitude = Column(Float, nullable=False)

    host = relationship('Host', back_populates='matches')
    member = relationship('Member', back_populates='matches')
    notifications = relationship('Notification', back_populates='match')
    review = relationship('Review', back_populates='match', uselist=False) 