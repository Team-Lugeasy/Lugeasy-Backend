from sqlalchemy import Column, String, BigInteger, ForeignKey
from sqlalchemy.orm import relationship
from .base import Base

class FCM(Base):
    __tablename__ = 'fcm'

    fcm_id = Column(BigInteger, primary_key=True, autoincrement=True)
    member_id = Column(BigInteger, ForeignKey('member.member_id'), nullable=False)
    device_id = Column(String, nullable=False)
    os_type = Column(String, nullable=False)
    os_version = Column(String, nullable=False)

    member = relationship('Member', back_populates='fcms') 