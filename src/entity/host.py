from sqlalchemy import Column, String, Boolean, BigInteger, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from .base import Base

class Host(Base):
    __tablename__ = 'host'

    host_id = Column(BigInteger, primary_key=True, autoincrement=True)
    member_id = Column(BigInteger, ForeignKey('member.member_id'), nullable=False)
    address = Column(String, nullable=False)
    index_code = Column(String, nullable=False)
    available_time = Column(DateTime, nullable=False)
    is_authentication = Column(Boolean, nullable=False)

    member = relationship('Member', back_populates='hosts')
    matches = relationship('Match', back_populates='host')
    notifications = relationship('Notification', back_populates='host') 