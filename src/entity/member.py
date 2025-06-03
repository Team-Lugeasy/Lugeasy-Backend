from sqlalchemy import Column, String, Boolean, BigInteger
from sqlalchemy.orm import relationship
from .base import Base

class Member(Base):
    __tablename__ = 'member'

    member_id = Column(BigInteger, primary_key=True, autoincrement=True)
    is_host = Column(Boolean, nullable=False)
    name = Column(String, nullable=True)
    phone_number = Column(String, nullable=True)
    email = Column(String, nullable=False)
    profile_image = Column(String, nullable=False)
    social_type = Column(String, nullable=False)
    social_id = Column(String, nullable=False)

    hosts = relationship('Host', back_populates='member')
    fcms = relationship('FCM', back_populates='member')
    notifications = relationship('Notification', back_populates='member')
    matches = relationship('Match', back_populates='member') 