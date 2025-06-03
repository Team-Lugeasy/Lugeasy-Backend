from sqlalchemy import Column, Boolean, BigInteger, ForeignKey
from sqlalchemy.orm import relationship
from .base import Base

class Notification(Base):
    __tablename__ = 'notification'

    notification_id = Column(BigInteger, primary_key=True, autoincrement=True)
    match_id = Column(BigInteger, ForeignKey('match.match_id'), nullable=False)
    host_id = Column(BigInteger, ForeignKey('host.host_id'), nullable=False)
    member_id = Column(BigInteger, ForeignKey('member.member_id'), nullable=False)
    is_read = Column(Boolean, nullable=False, default=False)

    match = relationship('Match', back_populates='notifications')
    host = relationship('Host', back_populates='notifications')
    member = relationship('Member', back_populates='notifications') 